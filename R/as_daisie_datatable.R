#' Converts the `Island_tbl` class to a data frame in the format of a DAISIE
#' data table (see DAISIE R package for details). This can then be input into
#' `DAISIEprep::create_daisie_data()` function which creates the list input into
#' the DAISIE ML models.
#'
#' @details
#' When the colonisation time of an island colonist is older than `island_age`
#' (either because `col_max_age = TRUE` in the `island_tbl`, because
#' `precise_col_time = FALSE`, or because the extracted colonisation time itself
#' exceeds `island_age`), the colonist's status is appended with `_MaxAge`. This
#' tells the downstream `create_daisie_data()` step to treat the colonisation
#' time as an upper bound and integrate over possible colonisation times between
#' the island age and the present.
#'
#' If the island colonist additionally contains one or more in-island branching
#' times that are also older than `island_age`, those branching events cannot
#' represent on-island cladogenesis (the island did not yet exist). In that
#' case the clade is _split_:
#'
#' * each branching time older than `island_age` is written as its own
#'   `_MaxAge` singleton row, with the clade name suffixed `_1`, `_2`, ...; and
#' * the colonisation time together with any remaining (valid, in-island)
#'   branching times stays as the main `_MaxAge` row under the original clade
#'   name.
#'
#' If all branching times exceed `island_age`, the main row contains only the
#' colonisation time. The numeric values written to `Branching_times` are not
#' clamped to `island_age` at this stage; clamping (to `island_age - epss`)
#' happens in `create_daisie_data()`, which treats the `_MaxAge` flag as an
#' instruction to integrate up to the island age.
#'
#' @inheritParams default_params_doc
#'
#' @return A data frame in the format of a DAISIE data table
#' @export
#' @author Joshua W. Lambert, Pedro Neves
#'
#' @examples
#' phylod <- create_test_phylod(10)
#' island_tbl <- extract_island_species(
#'   phylod = phylod,
#'   extraction_method = "asr"
#' )
#'
#' # Example where precise colonisation times are known
#' daisie_datatable <- as_daisie_datatable(
#'   island_tbl = island_tbl,
#'   island_age = 0.2,
#'   precise_col_time = TRUE
#' )
#'
#' # Example where colonisation times are uncertain and set to max ages
#' daisie_datatable <- as_daisie_datatable(
#'   island_tbl = island_tbl,
#'   island_age = 0.2,
#'   precise_col_time = FALSE
#' )
as_daisie_datatable <- function(island_tbl,
                                island_age,
                                precise_col_time = TRUE) {

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

    # get branching times
    brts <- unlist(island_tbl[1, "branching_times"])

    # merge colonisation time and branching times
    if (!all(is.na(brts))) {
      event_times <- c(island_tbl[1, "col_time"], brts)
    } else {
      event_times <- island_tbl[1, "col_time"]
    }

    # descending branching times
    event_times <- sort(
      event_times,
      decreasing = TRUE,
      na.last = TRUE
    )

    # add colonist information to data table
    daisie_datatable[i, "Clade_name"] <- island_tbl[1, "clade_name"]
    daisie_datatable[i, "Status"] <- island_tbl[1, "status"]
    daisie_datatable[i, "Missing_species"] <- island_tbl[1, "missing_species"]
    daisie_datatable[i, "Branching_times"][[1]] <- list(event_times)

    # max age if first branching time is before the island age
    if (!all(is.na(event_times))) {
      island_age_max_age <- event_times[1] >= island_age
    } else {
      island_age_max_age <- TRUE
    }

    # max age if older than island or specified in precise_col_time or
    # island_tbl
    max_age <- isFALSE(precise_col_time) ||
      island_tbl[1, "col_max_age"] ||
      island_age_max_age

    # check if minimum age of colonisation is available
    min_age_available <- !is.na(island_tbl[1, "min_age"])

    # MaxAge without a min age
    if (max_age && isFALSE(min_age_available)) {

      # assign MaxAge status
      daisie_datatable[i, "Status"] <- paste0(
        island_tbl[1, "status"],
        "_MaxAge"
      )

      # if there are branching time and col time exceeds island age, check if
      # branching times are older than the island and if so split the clade
      if (length(event_times) > 1 && island_age_max_age) {

        # check if first branching time is older than island
        split_clade <- brts[1] >= island_age

        if (split_clade) {

          # if there are branching times before the island age split the clade
          split_clade <- 1
          clade_name <- daisie_datatable[i, "Clade_name"]

          # recursively split clade until branching times are after island age
          while (length(event_times) >= 2 && event_times[2] >= island_age) {

            # extract island colonist information
            daisie_datatable[i, "Clade_name"] <- paste(
              clade_name, split_clade, sep = "_"
            )
            split_clade <- split_clade + 1
            daisie_datatable[i, "Branching_times"][[1]] <- list(event_times[2])
            event_times <- event_times[-2]
            if (length(event_times) > 0) {
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
            if (length(event_times) == 0) {
              break
            }
          }

          # if there are branching times left after recursion put them in a
          # clade
          if (length(event_times) >= 1) {
            daisie_datatable[i, "Clade_name"] <- island_tbl[1, "clade_name"]
            daisie_datatable[i, "Branching_times"][[1]] <- list(event_times)
            daisie_datatable[i, "Missing_species"] <-
              island_tbl[1, "missing_species"]
            daisie_datatable[i, "Status"] <- island_tbl[1, "status"]
            if (max(daisie_datatable[i, "Branching_times"][[1]]) >= island_age) {
              # assign MaxAge status
              daisie_datatable[i, "Status"] <- paste0(
                daisie_datatable[i, "Status"], "_MaxAge"
              )
            }
          }
        }
      }
    } else if (max_age && min_age_available) {
      # MaxAgeMinAge cases
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
