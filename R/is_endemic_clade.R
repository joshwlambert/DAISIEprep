#' Checks whether the focal species (given by its tip lable in species_label
#' argument) is part of an endemic clade on the island
#'
#' @inheritParams default_params_doc
#'
#' @return Boolean
#' @export
#'
#' @examples x = 1
is_endemic_clade <- function(phylod,
                            species_label) {

  # if not all species in the tree are endemic find endemic clade
  all_phylo_endemic <- all(
    phylobase::tipData(phylod)$endemicity_status %in% "endemic"
  )

  # if every species in the tree is endemic then it must be an endemic clade
  if (isTRUE(all_phylo_endemic)) {
    return(TRUE)
  }

  # get the species name (genus_species) from the focal species
  focal_split_species_names <- strsplit(x = species_label, split = "_")
  focal_genus_name <- sapply(focal_split_species_names, "[[", 1)
  focal_species_name <- sapply(focal_split_species_names, "[[", 2)
  focal_genus_species_name <- paste(
    focal_genus_name, focal_species_name, sep = "_"
  )

  num_species_clade <- 0
  all_siblings_endemic <- TRUE
  no_siblings_conspecific <- TRUE
  ancestor <- species_label
  descendants <- species_label
  while (all_siblings_endemic && no_siblings_conspecific) {
    ancestor <- phylobase::ancestor(phy = phylod, node = ancestor)
    # save a copy of descendants for when loop stops
    clade <- descendants
    descendants <- phylobase::descendants(phy = phylod, node = ancestor)
    # get the species names (genus_species) for sister species
    split_species_names <- strsplit(x = names(descendants), split = "_")
    genus_name <- sapply(split_species_names, "[[", 1)
    species_name <- sapply(split_species_names, "[[", 2)
    genus_species_name <- paste(genus_name, species_name, sep = "_")
    no_siblings_conspecific <- length(unique(genus_species_name)) > 1
    # get endemicity of siblings
    which_siblings <- which(phylobase::labels(phylod) %in% names(descendants))
    sibling_endemicity <-
      phylobase::tdata(phylod)[which_siblings, "endemicity_status"]
    all_siblings_endemic <- all(sibling_endemicity == "endemic")
    num_species_clade <- num_species_clade + 1
  }

  # if number of matches is greater than 1 (it will match with itself)
  if (num_species_clade > 1) {
    TRUE
  } else {
    FALSE
  }
}
