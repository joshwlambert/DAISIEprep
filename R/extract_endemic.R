#' Extracts the information for an endemic species from a phylogeny
#' (specifically `phylo4d`  object from `phylobase` package) and stores it in
#' in an `island_colonist` class
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `island_colonist` class
#' @export
#'
#' @examples
#' set.seed(1)
#' phylo <- ape::rcoal(10)
#' phylo <- as(phylo, "phylo4")
#' endemicity_status <- sample(c("not_present", "endemic", "nonendemic"),
#'                               size = length(phylobase::tipLabels(phylo)),
#'                               replace = TRUE)
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' extract_endemic(phylod = phylod, species_label = "t1")
extract_endemic <- function(phylod,
                            species_label) {

  # create an instance of the island_colonist class to store data
  island_col <- island_colonist()

  #TODO: write check that the species_label refers to nonendemic species

  # check whether the focal species is in an endemic clade
  clade <- is_island_clade(phylod, species_label)

  if (isFALSE(clade)) {
    # assign data to instance of island_colonist class
    set_clade_name(island_col) <- species_label
    set_status(island_col) <- "endemic"
    set_missing_species(island_col) <- 0
    set_branching_times(island_col) <-
      as.numeric(phylobase::edgeLength(phylod, species_label))
  } else {
    island_col <- extract_endemic_clade(phylod, species_label)
  }

  #return instance of island_colonist class
  island_col
}
