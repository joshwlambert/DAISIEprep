#' Checks if a species is represented in the tree as multiple tips and those
#' tips form a monophyletic group (i.e. one species with multiple samples)
#'
#' @inheritParams default_params_doc
#'
#' @return Boolean
#' @keywords internal
is_multi_tip_species <- function(phylod, species_label) {

  # check phylod
  phylod <- check_phylo_data(phylod)

  # get the species name (genus_species) from the focal species
  focal_split_species_names <- strsplit(x = species_label, split = "_")
  focal_genus_name <- sapply(focal_split_species_names, "[[", 1)
  focal_species_name <- sapply(focal_split_species_names, "[[", 2)
  focal_genus_species_name <- paste(
    focal_genus_name, focal_species_name, sep = "_"
  )

  # get the ancestral node and descendants from that node
  ancestor <- phylobase::ancestor(phy = phylod, node = species_label)
  descendants <- phylobase::descendants(phy = phylod, node = ancestor)
  # get the species names (genus_species) for sister species
  split_species_names <- strsplit(x = names(descendants), split = "_")
  genus_name <- sapply(split_species_names, "[[", 1)
  species_name <- sapply(split_species_names, "[[", 2)
  genus_species_name <- paste(genus_name, species_name, sep = "_")
  all_siblings_conspecific <- length(unique(genus_species_name)) == 1

  # return all_siblings_conspecific
  all_siblings_conspecific
}
