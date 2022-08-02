#' Loops through the genera that have missing species and removes the ones that
#' are found in the missing genus list which have phylogenetic data. This is
#' useful when wanting to know which missing species have not been assigned to
#' the island_tbl using `add_multi_missing_species()`.
#'
#' @inheritParams default_params_doc
#'
#' @return Data frame
#' @export
#'
#' @examples
#' phylod <- DAISIEprep:::create_test_phylod(test_scenario = 6)
#' island_tbl <- suppressWarnings(extract_island_species(
#'  phylod = phylod,
#'  extraction_method = "asr",
#' ))
#' phylod <- DAISIEprep:::create_test_phylod(test_scenario = 7)
#' island_tbl <- suppressWarnings(extract_island_species(
#'  phylod = phylod,
#'  extraction_method = "asr",
#'  island_tbl = island_tbl
#' ))
#' missing_species <- data.frame(
#'   clade_name = "bird",
#'   missing_species = 1,
#'   endemicity_status = "endemic"
#' )
#' missing_genus <- list("bird", character(0))
#' rm_missing_species <- rm_multi_missing_species(
#'   missing_species = missing_species,
#'   missing_genus = missing_genus
#' )
rm_multi_missing_species <- function(missing_species,
                                     missing_genus,
                                     island_tbl) {

  for (i in seq_along(missing_genus)) {
    which_species <- which(
      missing_species$clade_name %in% missing_genus[[i]]
    )

    # if that clade contains a genus that has missing species then add missing
    # species to island_tbl
    if (length(which_species) > 0) {

      # check if the species being added and the species being added to are
      # endemic, if not do not add missing species
      if (island_tbl@island_tbl$status[i] == "endemic" &&
          any(missing_species$endemicity_status[which_species] == "endemic")) {

        # sum up number of missing species if there are multiple genera in
        # a clade
        which_endemic <- which(
          missing_species$endemicity_status[which_species] == "endemic"
        )

        # delete rows from missing_species
        missing_species <- missing_species[-which_endemic, ]
      }
    }
  }

  # return missing_species
  missing_species
}
