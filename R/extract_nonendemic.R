#' Extracts the information for a non-endemic species from a phylogeny
#' (specifically `phylo4d`  object from `phylobase` package) and stores it in
#' in an `island_colonist` class
#'
#' @inheritParams default_params_doc
#'
#' @return
#' @export
#'
#' @examples
extract_nonendemic <- function(phylod,
                               species_label) {

  # create an instance of the island_colonist class to store data
  island_col <- new("island_colonist")

  # assign data to instance of island_colonist class
  set_clade_name(island_col) <- species_label
  set_status(island_col) <- "nonendemic"
  set_missing_species(island_col) <- 0
  set_branching_times(island_col) <-
    as.numeric(phylobase::edgeLength(phylod, species_label))

  #return instance of island_colonist class
  island_col
}
