#' Adds the missing species to the clades that have missing species from the
#' tree in the Island_tbl object. This is to be used after
#' extract_island_species to input missing species.
#'
#' @inheritParams default_params_doc
#'
#' @return Data frame with single column of character strings and row names
#' @export
#'
#' @examples
#' missing_species <- data.frame(clade_name = "bird_c", missing_species = 1)
#' set.seed(
#'   1,
#'   kind = "Mersenne-Twister",
#'   normal.kind = "Inversion",
#'   sample.kind = "Rejection"
#' )
#' phylo <- ape::rcoal(5)
#' phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e")
#' phylo <- phylobase::phylo4(phylo)
#' endemicity_status <- c(
#'   "not_present", "not_present", "endemic", "not_present", "not_present"
#' )
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' island_tbl <- extract_island_species(phylod, extraction_method = "min")
#' island_tbl <- add_missing_species(island_tbl, missing_species)
add_missing_species <- function(island_tbl,
                                missing_species_df) {

  # check the island_tbl input
  if (isFALSE(class(island_tbl) == "Island_tbl")) {
    stop("island_tbl must be an object of Island_tbl")
  }

  # check the data frame input
  correct_colnames <- identical(
    colnames(missing_species_df),
    c("clade_name", "missing_species")
  )

  if (isFALSE(is.data.frame(missing_species_df)) || isFALSE(correct_colnames)) {
    stop("missing_species needs to be a data frame with the clade and the
         number of missing species")
  }
  # loop over each clade in the missing species data frame
  for (i in seq_len(nrow(missing_species_df))) {
    # get which clades have missing species
    missing_species_clades <- grep(
      pattern = missing_species_df[i, "clade_name"],
      x = island_tbl@island_tbl$clade_name
    )

    if (length(missing_species_clades) > 1) {
      warning("Number of missing species being assigned to two island colonists")
    }

    # input the missing species from data frame into island_tbl
    island_tbl@island_tbl$missing_species[missing_species_clades] <-
      missing_species_df[i, "missing_species"]
  }

  # return island_tbl
  island_tbl
}
