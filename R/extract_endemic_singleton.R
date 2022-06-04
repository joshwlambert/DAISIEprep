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
#' extract_endemic_singleton(phylod = phylod, species_label = "bird_i")
extract_endemic_singleton <- function(phylod,
                                      species_label) {

  # check input data
  phylod <- check_phylo_data(phylod)

  # create an instance of the island_colonist class to store data
  island_colonist <- island_colonist()

  # assign data to instance of island_colonist class
  set_clade_name(island_colonist) <- species_label
  set_status(island_colonist) <- "endemic"
  set_missing_species(island_colonist) <- 0
  set_branching_times(island_colonist) <-
    as.numeric(phylobase::edgeLength(phylod, species_label))
  set_species(island_colonist) <- species_label

  #return instance of island_colonist class
  island_colonist
}
