#' Converts the `island_tbl` class to a data frame in the format of a DAISIE
#' data table (see DAISIE R package for details). This can then be input into
#' `DAISIEprep::create_daisie_data` function which creates the list input into
#' the DAISIE ML models.
#'
#' @inheritParams default_params_doc
#'
#' @return A data frame in the format of a DAISIE data table
#' @export
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

  for (i in seq_len(nrow(island_tbl))) {
    brts <- sort(
      unlist(island_tbl[i, "branching_times"]),
      decreasing = TRUE,
      na.last = TRUE
    )
    temp_datatable <- data.frame(
      Clade_name = island_tbl[i, "clade_name"],
      Status = NA_character_,
      Missing_species = island_tbl[i, "missing_species"],
      Branching_times = I(list(brts))
    )
    daisie_datatable <- rbind(daisie_datatable, temp_datatable)
    status_suffix <- ""
    min_age_available <- !is.na(island_tbl[i, "min_age"])
    # MaxAge cases
    if ((brts[1] >= island_age || is.na(brts)) || col_uncertainty == "max") {
      status_suffix <- "_MaxAge"
      col_time <- island_age - 1e-5
      if (length(brts) > 1 && brts[2] >= island_age) {
        brts_before_island <- which(brts > island_age)
        #TODO: check this line #########
        daisie_datatable[i, "Branching_times"] <-
          c(col_time, brts[-brts_before_island])
      }

    }
    # MinAge normal use and MinAge favouring cases (stac_handlings == "min")
    if ((isTRUE(min_age_available) && isTRUE(brts[1] >= island_age)) ||
        (isTRUE(min_age_available) && col_uncertainty == "min"))  {
      status_suffix <- "_MaxAgeMinAge"
      daisie_datatable[i, "Branching_times"] <- c(
        daisie_datatable[i, "Branching_times"],
        island_tbl[i, "min_age"]
      )
    }

    daisie_datatable[i, "Status"] <- paste0(
      island_tbl[i, "status"],
      status_suffix
    )
  }

  # return daisie_datatable
  daisie_datatable
}
