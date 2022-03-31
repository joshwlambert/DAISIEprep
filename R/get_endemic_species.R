#' Checks whether the focal species (given by its tip lable in species_label
#' argument) is part of an endemic clade on the island and a vector of the
#' endemic species, either a single species for a singleton or multiple species
#' in an endemic clade.
#'
#' @inheritParams default_params_doc
#'
#' @return Named numeric vector
#' @keywords internal
get_endemic_species <- function(phylod,
                                species_label) {

  # check input data
  phylod <- check_phylo_data(phylod)

  # set up variables to be modified in the loop
  all_siblings_endemic <- TRUE
  ancestor <- species_label
  descendants <- 1
  names(descendants) <- species_label

  # recursive tree traversal to find endemic clade
  while (all_siblings_endemic) {
    ancestor <- phylobase::ancestor(phy = phylod, node = ancestor)
    # save a copy of descendants for when loop stops
    clade <- descendants
    descendants <- phylobase::descendants(phy = phylod, node = ancestor)
    # get endemicity of siblings
    which_siblings <- which(phylobase::labels(phylod) %in% names(descendants))
    sibling_endemicity <-
      phylobase::tdata(phylod)[which_siblings, "endemicity_status"]
    all_siblings_endemic <- all(sibling_endemicity == "endemic")
  }

  # prune species with multiple subspecies to a single species
  split_species_names <- strsplit(x = names(clade), split = "_")
  genus_name <- sapply(split_species_names, "[[", 1)
  species_name <- sapply(split_species_names, "[[", 2)
  genus_species_name <- paste(genus_name, species_name, sep = "_")
  if (any(duplicated(genus_species_name))) {
    clade <- clade[-which(duplicated(genus_species_name))]
  }

  # return clade
  clade
}
