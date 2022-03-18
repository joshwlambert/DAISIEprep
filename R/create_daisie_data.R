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
  browser()

  num_col <- nrow(daisie_datatable)
  datalist <- list()
  if (num_clade_types == 1) {
    datalist[[1]] <- list(
      island_age = island_age,
      not_present = (num_mainland_species - num_col)
    )
  }
  if (num_clade_types == 2) {
    num_type2_colonisations <- length(list_type2_clades)
    num_type1_colonisations <- num_colonisations -
      num_type2_colonisations
    if (prop_type2_pool == "proportional") {
      not_present_type1 <- DDD::roundn( (num_mainland_species / num_colonisations) *
                                          num_type1_colonisations) -
        num_type1_colonisations
      not_present_type2 <- DDD::roundn( (num_mainland_species / num_colonisations) *
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

  datalist_cols <- unlist(daisie_datatable, recursive = FALSE)
  datalist <- list(datalist, datalist_cols)

  # replace Clade_name with colonist_name
  datalist <- lapply(datalist, function(x) {
   if (!is.null(x$Clade_name)) {
     names(x)[which(names(x) == "Clade_name")] <- "colonist_name"
   }
  })

  # replace Status with stac

  # replace Missing_species with missing_species

  # replace Brancing_times with branching_times

  # append type1or2 to each element apart from first
  #datalist <- lapply ... type1or2 = 1

  for (i in seq_len(nrow(daisie_datatable))) {

    brts <- sort(
      unlist(daisie_datatable[i, "Branching_times"]),
      decreasing = TRUE
    )

    # get the status of the colonist
    status <- translate_status(daisie_datatable[i, "Status"])

    if (is.na(brts[1])) {
      brts <- island_age

      if (status == "endemic") {
        daisie_datatable[i, "Status"] <-"Endemic_MaxAge"
      }
      if (status == "nonendemic") {
        daisie_datatable[i,"Status"] <-"Non_endemic_MaxAge"
      }
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

    if(length(brts) == 1) {
      datalist[[i + 1]]$branching_times <-
        c(island_age, min(brts, island_age - epss))
    }
    if (length(brts) > 1) {
      brts[1] <- min(brts[1],island_age - epss)
      datalist[[i + 1]]$branching_times <- c(island_age,brts)
      if (brts[2] >= brts[1]) {
        stop(paste(
          "Cladogenetic event or minimum colonisation time in ",
          daisie_datatable[i,"Clade_name"],
          " is older than the island, or of the same age as the island",
          sep = ""
        ))
      }
    }

    if (status == "nonendemic_max_age") {

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

      datalist[[i + 1]]$stac = 1

    }

    if (status == "endemic") {
      datalist[[i + 1]]$stac = 2
    }

    if (status == "endemic&nonendemic") {
      datalist[[i + 1]]$stac = 3
    }

    if (status == "nonendemic") {
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
      datalist[[i + 1]]$stac = 4
    }

    if(status == "endemic_max_age") {
      if (length(brts) == 1) {
        datalist[[i + 1]]$stac = 5
      }
      if (length(brts) > 1) {
        datalist[[i + 1]]$stac = 6
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
      datalist[[i + 1]]$stac = 8
    }

    if (status == "endemic_max_age_min_age") {
      datalist[[i + 1]]$stac = 9
    }

    if(num_clade_types == 2) {
      if(length(which(list_type2_clades == daisie_datatable[i,"Clade_name"])) > 0) {
        datalist[[i + 1]]$type1or2 = 2
      }
    }
  }

  if (length(which(is.na(unlist(datalist)[which(names(unlist(datalist)) == 'stac')]) == TRUE)) > 0) {
    stop("The status of one or more lineages is incorrectly spelled in the source table and has not been assigned.")
  }


  # make sure branching times are sorted
  #datalist <- lapply ... sort(..., decreasing = TRUE)

  # return datalist
  datalist
}
