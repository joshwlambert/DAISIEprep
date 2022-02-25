#' Extracts the information for an endemic species from a phylogeny
#' (specifically `phylo4d`  object from `phylobase` package) and stores it in
#' in an `island_colonist` class
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `Island_colonist` class
#' @export
#'
#' @examples
#' set.seed(1)
#' phylo <- ape::rcoal(10)
#' phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
#'                      "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
#' phylo <- methods::as(phylo, "phylo4")
#' endemicity_status <- sample(c("not_present", "endemic", "nonendemic"),
#'                             size = length(phylobase::tipLabels(phylo)),
#'                             replace = TRUE)
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' island_col <- extract_endemic(
#'   phylod = phylod,
#'   species_label = "bird_c"
#' )
extract_endemic <- function(phylod,
                            species_label) {

  # create an instance of the island_colonist class to store data
  island_col <- island_colonist()

  #TODO: write check that the species_label refers to endemic species

  # check whether the focal species is in an endemic clade
  clade <- is_endemic_clade(phylod, species_label)

  # does species have multiple tips in the tree (i.e. population sampling)
  multi_tip_species <- is_multi_tip_species(
    phylod = phylod,
    species_label = species_label
  )

  singleton_endemic <- isFALSE(clade) && isFALSE(multi_tip_species)
  multi_tip_endemic <- isFALSE(clade) && multi_tip_species
  endemic_clade <- clade && isFALSE(multi_tip_species)
  multi_tip_endemic_clade <- clade && multi_tip_species

  if (singleton_endemic) {
    # assign data to instance of island_colonist class
    set_clade_name(island_col) <- species_label
    set_status(island_col) <- "endemic"
    set_missing_species(island_col) <- 0
    set_branching_times(island_col) <-
      as.numeric(phylobase::edgeLength(phylod, species_label))
  } else if (multi_tip_endemic) {
    island_col <- extract_multi_tip_endemic(phylod, species_label)
  } else if (endemic_clade) {
    island_col <- extract_endemic_clade(phylod, species_label)
  }

  #return instance of island_colonist class
  island_col
}
