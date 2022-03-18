#' This is a wrapper function for DAISIE::DAISIE_dataprep(). It allows the
#' final DAISIE data structure to be produced from within DAISIEprep. For
#' detailed documentation see the help documentation in the DAISIE package
#' (?DAISIE::DAISIE_dataprep).
#'
#' @inheritParams default_params_doc
#'
#' @return DAISIE data list
#' @export
#'
#' @examples
#' \dontrun{
#' island_tbl <- extract_island_specie()
#' daisie_datatable <- as_daisie_datatable(island_tbl)
#' daisie_data_list <- create_daisie_data(
#'   daisie_datatable = daisie_datatable,
#'   island_age = 1,
#'   num_mainland_species = 1000,
#'   num_clade_types = 1,
#'   list_type2_clades = NA,
#'   prop_type2_pool = NA,
#'   epss = 1e-5,
#'   verbose = FALSE
#' )
#' }
create_daisie_data <- function(daisie_datatable,
                               island_age,
                               num_mainland_species,
                               num_clade_types = 1,
                               list_type2_clades = NA,
                               prop_type2_pool = "proportional",
                               epss = 1e-5,
                               verbose = FALSE) {

  num_col <- nrow(daisie_datatable)
  datalist <- list()
  if (num_clade_types == 1) {
    datalist[[1]] <- list(
      island_age = island_age,
      not_present = (num_mainland_species - num_col)
    )
  }
  if (num_clade_types == 2) {
    num_type2_col <- length(list_type2_clades)
    num_type1_col <- num_col - num_type2_col
    if (prop_type2_pool == "proportional") {
      not_present_type1 <- round_up(
        (num_mainland_species / num_col) * num_type1_col
      ) - num_type1_col
      not_present_type2 <- round_up(
        (num_mainland_species / num_col) * num_type2_col
      ) - num_type2_col
    } else {
      not_present_type1 <- round_up(
        num_mainland_species * (1 - prop_type2_pool)) -
        num_type1_col
      not_present_type2 <- round_up(num_mainland_species * prop_type2_pool) -
        num_type2_col
    }
    datalist[[1]] <- list(
      island_age = island_age,
      not_present_type1 = not_present_type1,
      not_present_type2 = not_present_type2
    )
  }

  # loop over every colonist excluding metadata (first element)
  for (i in seq_len(nrow(daisie_datatable))) {

    # create index for colonist list element
    colonist <- i + 1
    datalist[[colonist]] <- list(
      colonist_name = daisie_datatable[i, "Clade_name"],
      branching_times = NA,
      stac = NA,
      missing_species = daisie_datatable[i, "Missing_species"],
      type1or2 = 1
    )

    brts <- sort(
      unlist(daisie_datatable[i, "Branching_times"]),
      decreasing = TRUE
    )

    # get the status of the colonist
    status <- translate_status(daisie_datatable[i, "Status"])

    if (is.na(brts[1])) {
      brts <- island_age
    }

    if (max(brts) > island_age) {
      if (verbose == TRUE) {
        message(
          "Colonisation time of ",
          max(brts),
          " for ",
          daisie_datatable[i, "Clade_name"],
          " is older than island age", sep = ""
        )
      }
    }

    if (length(brts) == 1) {
      datalist[[colonist]]$branching_times <- c(
        island_age,
        min(brts, island_age - epss)
      )
    }
    if (length(brts) > 1) {
      brts[1] <- min(brts[1], island_age - epss)
      datalist[[colonist]]$branching_times <- c(island_age, brts)
      if (brts[2] >= brts[1]) {
        stop(paste(
          "Cladogenetic event or minimum colonisation time in ",
          daisie_datatable[i,"Clade_name"],
          " is older than the island, or of the same age as the island",
          sep = ""
        ))
      }
    }

    if (status %in% c("nonendemic", "nonendemic_max_age")) {

      if (length(brts) > 1) {
        stop(paste(
          "Only one branching time should be provided for ",
          daisie_datatable[i,"Clade_name"],
          " because it is a non-endemic species. If you mean to specifiy a
          minimum age as well, please use Non_Endemic_MaxAgeMinAge.",
          sep = ""
        ))
      }

      if (daisie_datatable[i, "Missing_species"] > 0) {
        stop(paste(
          "Missing species for ",
          daisie_datatable[i,"Clade_name"],
          " should be 0 because it is a non-endemic species.",
          sep = ""
        ))
      }

      if (status == "nonendemic") {
        datalist[[colonist]]$stac <- 4
      } else {
        datalist[[colonist]]$stac <- 1
      }
    }

    if (status == "endemic") {
      datalist[[colonist]]$stac <- 2
    }

    if (status == "endemic&nonendemic") {
      datalist[[colonist]]$stac <- 3
    }

    if(status == "endemic_max_age") {
      if (length(brts) == 1) {
        datalist[[colonist]]$stac <- 5
      }
      if (length(brts) > 1) {
        datalist[[colonist]]$stac <- 6
      }
      if (max(brts)>island_age) {
        if (length(brts) > 1) {
          stop(paste(
            "Radiation of ",
            daisie_datatable[i,"Clade_name"],
            " is older than the island",
            sep = ""
          ))
        }
      }
    }

    if(status == "nonendemic_max_age_min_age") {
      datalist[[colonist]]$stac <- 8
    }

    if (status == "endemic_max_age_min_age") {
      datalist[[colonist]]$stac <- 9
    }

    if (num_clade_types == 2) {
      is_type_2_colonist <-
        daisie_datatable[i, "Clade_name"] %in% list_type2_clades
      if (is_type_2_colonist) {
        datalist[[colonist]]$type1or2 <- 2
      }
    }
  }

  # go through datalist and find any stacs that have not been assigned
  any_na_stacs <- any(unlist(lapply(datalist, function(x) {
    if (!is.null(x$stac)) {
      is.na(x$stac)
    }
  })))
  if (any_na_stacs) {
    stop("The status of one or more lineages is incorrectly spelled in the
         source table and has not been assigned.")
  }

  # return datalist
  datalist
}
