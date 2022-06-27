#' Converts the `island_tbl` class to a data frame in the format of a DAISIE
#' data table (see DAISIE R package for details). This can then be input into
#' `DAISIEprep::create_daisie_data` function which creates the list input into
#' the DAISIE ML models.
#'
#' @inheritParams default_params_doc
#'
#' @return A data frame in the format of a DAISIE data table
#' @export
#' @author Joshua W. Lambert, Pedro Neves
#'
#' @examples
#' phylod <- DAISIEprep:::create_test_phylod(10)
#' island_tbl <- extract_island_species(
#'   phylod = phylod,
#'   extraction_method = "asr"
#' )
#'
#' # Example where precise colonisation times are known
#' daisie_datatable <- as_daisie_datatable(
#'   island_tbl = island_tbl,
#'   island_age = 0.2,
#'   col_uncertainty = "none"
#' )
#'
#' # Example where colonisation times are uncertain and set to max ages
#' daisie_datatable <- as_daisie_datatable(
#'   island_tbl = island_tbl,
#'   island_age = 0.2,
#'   col_uncertainty = "max"
#' )
as_daisie_datatable <- function(island_tbl,
                                island_age,
                                col_uncertainty = "none") {

  # extract data frame from island_tbl class
  island_tbl <- get_island_tbl(island_tbl)

  daisie_datatable <- data.frame(
    Clade_name = character(),
    Status = character(),
    Missing_species = numeric(),
    Branching_times = numeric()
  )

  # initialise recursion index
  i <- 1

  # recursively loop through island colonists
  while (nrow(island_tbl) > 0) {

    # descending branching times
    brts <- sort(
      unlist(island_tbl[1, "branching_times"]),
      decreasing = TRUE,
      na.last = TRUE
    )

    # add colonist information to data table
    daisie_datatable[i, "Clade_name"] <- island_tbl[1, "clade_name"]
    daisie_datatable[i, "Status"] <- island_tbl[1, "status"]
    daisie_datatable[i, "Missing_species"] <- island_tbl[1, "missing_species"]
    daisie_datatable[i, "Branching_times"][[1]] <- list(brts)

    # check if first branching time is before the island age
    max_age <- brts[1] >= island_age
    # check if minimum age of colonisation is available
    min_age_available <- !is.na(island_tbl[1, "min_age"])

    # MaxAge cases
    if (all(is.na(brts)) || col_uncertainty == "max" && isFALSE(max_age)) {

      # max age after island age or no branching times
      daisie_datatable[i, "Branching_times"][[1]] <-
        island_tbl[1, "branching_times"]
      daisie_datatable[i, "Status"] <- paste0(
        island_tbl[1, "status"],
        "_MaxAge"
      )
    } else if (max_age && isFALSE(min_age_available)) {

      # max age before island age
      if (length(brts) == 1) {
        daisie_datatable[i, "Clade_name"] <- island_tbl[1, "clade_name"]
        daisie_datatable[i, "Branching_times"][[1]] <- list(brts)
        daisie_datatable[i, "Missing_species"] <-
          island_tbl[1, "missing_species"]
        daisie_datatable[i, "Status"] <- paste0(
          island_tbl[1, "status"],
          "_MaxAge"
        )
      } else {

        # if there are branching times before the islanda age split the clade
        split_clade <- 1
        clade_name <- daisie_datatable[i, "Clade_name"]

        # recursively split clade until branching times are after island age
        while (brts[1] >= island_age) {

          # extract island colonist information
          daisie_datatable[i, "Clade_name"] <- paste(
            clade_name, split_clade, sep = "_"
          )
          split_clade <- split_clade + 1
          daisie_datatable[i, "Branching_times"] <- brts[1]
          brts <- brts[-1]
          if (length(brts) > 0) {
            # split singletons do not get assigned any missing species
            daisie_datatable[i, "Missing_species"] <- 0
          } else {
            # the last clade gets assigned the missing species
            daisie_datatable[i, "Missing_species"] <-
              island_tbl[1, "missing_species"]
          }

          daisie_datatable[i, "Status"] <- paste0(
            island_tbl[1, "status"],
            "_MaxAge"
          )

          # increment recursion index
          i <- nrow(daisie_datatable) + 1

          # if there are no more branching times stop recursion
          if (length(brts) == 0) {
            break
          }
        }

        # if there are branching times left after recursion put them in a clade
        if (length(brts) >= 1) {
          daisie_datatable[i, "Clade_name"] <- island_tbl[1, "clade_name"]
          daisie_datatable[i, "Branching_times"][[1]] <- list(brts)
          daisie_datatable[i, "Missing_species"] <-
            island_tbl[1, "missing_species"]
          daisie_datatable[i, "Status"] <- island_tbl[1, "status"]
        }
      }
    } else if ((min_age_available && max_age) ||
               (min_age_available && col_uncertainty == "min")) {
      # MinAge normal use and MinAge favouring cases (col_uncertainty == "min")
      # Note that max cases don't take minage if available
      daisie_datatable[i, "Branching_times"][[1]] <- list(c(
        daisie_datatable[i, "Branching_times"][[1]],
        island_tbl[1, "min_age"]
      ))
      daisie_datatable[i, "Status"] <- paste0(
        island_tbl[1, "status"],
        "_MaxAgeMinAge"
      )
    }

    # remove first row and continue recursion
    island_tbl <- island_tbl[-1, ]

    # increment recursion index
    i <- nrow(daisie_datatable) + 1
  }
  # return daisie_datatable
  daisie_datatable
}
