#' Checks if a species is represented in the tree has multiple tips and those
#' tips form a monophyletic group (i.e. one species with multiple samples) all
#' labeled as with the same endemicity status
#'
#' @details
#' [is_multi_tip_species()] only returns `TRUE` if all tips for each sample
#' of the species (i.e. conspecific tips) are labelled the same. It is
#' possible that a phylogeny has multiple tips for the same species but only
#' the island samples are labelled as `"endemic"` or `"nonendemic"` as the
#' other tips are from samples from the mainland, and are labelled
#' `"not_present"`, see
#' `vignette("Multi_tip_extraction", package = "DAISIEprep")`.
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

  # do not treat conspecifics with different endemicity status as multi-tip
  all_siblings_endemicity <- length(
    unique(phylod[descendants]@data$endemicity_status)
  ) == 1

  # return whether multi-tip species
  all_siblings_conspecific && all_siblings_endemicity
}
