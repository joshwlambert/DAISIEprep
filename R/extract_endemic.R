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
#' set.seed(
#'   1,
#'   kind = "Mersenne-Twister",
#'   normal.kind = "Inversion",
#'   sample.kind = "Rejection"
#' )
#' phylo <- ape::rcoal(10)
#' phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
#'                      "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
#' phylo <- phylobase::phylo4(phylo)
#' endemicity_status <- sample(
#'   x = c("not_present", "endemic", "nonendemic"),
#'   size = length(phylobase::tipLabels(phylo)),
#'   replace = TRUE,
#'   prob = c(0.6, 0.2, 0.2)
#' )
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' island_col <- extract_endemic(
#'   phylod = phylod,
#'   species_label = "bird_c"
#' )
extract_endemic <- function(phylod,
                            species_label) {

  # check input data
  check_phylo_data(phylod)

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
    island_col <- extract_endemic_singleton(phylod, species_label)
  } else if (multi_tip_endemic) {
    island_col <- extract_multi_tip_endemic(phylod, species_label)
  } else if (endemic_clade) {
    island_col <- extract_endemic_clade(phylod, species_label)
  }

  #return instance of island_colonist class
  island_col
}
