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
#' \dontrun{
#' missing_species_df <- data.frame(clade_name = "bird_a", missing_species = 1)
#' island_tbl <- NULL
#' add_missing_species(island_tbl, missing_species)
#' }
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

  # get which clades have missing species
  missing_species_clades <-
    which(island_tbl@island_tbl$clade_name %in% missing_species_df$clade_name)

  # input the missing species from data frame into island_tbl
  island_tbl@island_tbl$missing_species[missing_species_clades] <-
    missing_species_df$missing_species[missing_species_clades]

  # return island_tbl
  island_tbl
}
