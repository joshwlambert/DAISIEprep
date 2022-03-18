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
  if (num_clade_types == 1) {
    datalist <- list(
      island_age = island_age,
      not_present = (num_mainland_species - num_col)
    )
  }
  if (num_clade_types == 2) {
    num_type2_colonisations <- length(list_type2_clades)
    num_type1_colonisations <- num_col - num_type2_colonisations
    if (prop_type2_pool == "proportional") {
      not_present_type1 <- DDD::roundn( (num_mainland_species / num_col) *
                                          num_type1_colonisations) -
        num_type1_colonisations
      not_present_type2 <- DDD::roundn( (num_mainland_species / num_col) *
                                          num_type2_colonisations) -
        num_type2_colonisations
    } else {
      not_present_type1 <- DDD::roundn(num_mainland_species * (1 - prop_type2_pool)) -
        num_type1_colonisations
      not_present_type2 <- DDD::roundn(num_mainland_species * prop_type2_pool) -
        num_type2_colonisations
    }
    datalist[[1]] <- list(island_age = island_age,
                          not_present_type1 = not_present_type1,
                          not_present_type2 = not_present_type2)
  }

  # loop over every colonist excluding metadata (first element)
  for (i in seq_len(nrow(daisie_datatable))) {

    datalist[[i]] <- list(
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
browser()
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
      if (status == "endemic") {
        daisie_datatable[i,"Status"] <- "Endemic_MaxAge"
      }
      if (status == "nonendemic") {
        daisie_datatable[i,"Status"] <-"Non_endemic_MaxAge"
      }
    }

    if (length(brts) == 1) {
      datalist[[i]]$branching_times <- c(
        island_age,
        min(brts, island_age - epss)
      )
    }
    if (length(brts) > 1) {
      brts[1] <- min(brts[1], island_age - epss)
      datalist[[i]]$branching_times <- c(island_age, brts)
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
          " because it is a non-endemic species. If you mean to specifiy a minimum age as well, please use Non_Endemic_MaxAgeMinAge.",
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
        datalist[[i]]$stac <- 4
      } else {
        datalist[[i]]$stac <- 1
      }
    }

    if (status == "endemic") {
      datalist[[i]]$stac <- 2
    }

    if (status == "endemic&nonendemic") {
      datalist[[i]]$stac <- 3
    }

    if(status == "endemic_max_age") {
      if (length(brts) == 1) {
        datalist[[i]]$stac <- 5
      }
      if (length(brts) > 1) {
        datalist[[i]]$stac <- 6
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
      datalist[[i]]$stac <- 8
    }

    if (status == "endemic_max_age_min_age") {
      datalist[[i]]$stac <- 9
    }

    if(num_clade_types == 2) {
      if(length(which(list_type2_clades == daisie_datatable[i,"Clade_name"])) > 0) {
        datalist[[i]]$type1or2 <- 2
      }
    }
  }

  if (length(which(is.na(unlist(datalist)[which(names(unlist(datalist)) == 'stac')]) == TRUE)) > 0) {
    stop("The status of one or more lineages is incorrectly spelled in the source table and has not been assigned.")
  }

  # return datalist
  datalist
}
