#' Adds a specified number of missing species to an existing island_tbl at the
#' colonist specified by the species_name argument given. The species given is
#' located within the island_tbl data and missing species are assigned. This is
#' to be used after `extract_island_species()` to input missing species.
#'
#' @inheritParams default_params_doc
#'
#' @return Object of Island_tbl class
#' @export
#'
#' @examples
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
#' island_tbl <- add_missing_species(
#'   island_tbl = island_tbl,
#'   num_missing_species = 1,
#'   species_name = "bird_c"
#' )
add_missing_species <- function(island_tbl,
                                num_missing_species,
                                species_name) {

  # check the island_tbl input
  if (isFALSE(class(island_tbl) == "Island_tbl")) {
    stop("island_tbl must be an object of Island_tbl")
  }

  # find the specified species in the island tbl and locate index of colonist
  find_species <- lapply(
    island_tbl@island_tbl$species,
    function(x) {
      which_colonist <- grepl(pattern = species_name, x = x)
    }
  )
  colonist_index <- which(unlist(lapply(find_species, any)))

  if (length(colonist_index) > 1) {
    warning("Number of missing species being assigned to two island colonists")
  }

  # add number of missing species to the specified colonist
  island_tbl@island_tbl$missing_species[colonist_index] <-
    island_tbl@island_tbl$missing_species[colonist_index] +
    num_missing_species

  # return island_tbl
  island_tbl
}
