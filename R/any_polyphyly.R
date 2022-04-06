#' Checks whether there are any species in the phylogeny that have multiple
#' tips (i.e. multiple subspecies per species) and whether any of those tips are
#' paraphyletic (i.e. are their subspecies more distantly related to each other
#' than to other subspecies or species).
#'
#' @inheritParams default_params_doc
#'
#' @return Boolean
#' @export
#'
#' @examples
#' \dontrun{
#' "WIP"
#' }
any_polyphyly <- function(phylod) {

  # check phylod
  phylod <- check_phylo_data(phylod)

  # get the species names (genus_species) for all tips on the tree
  tip_labels <- phylobase::tipLabels(phylod)
  split_species_names <- strsplit(x = tip_labels, split = "_")
  genus_name <- sapply(split_species_names, "[[", 1)
  species_name <- sapply(split_species_names, "[[", 2)
  genus_species_name <- paste(genus_name, species_name, sep = "_")
  duplicated_species <- which(duplicated(genus_species_name))

  if (length(duplicated_species) == 0) {
    return(FALSE)
  }

  # loop through subspecies and check whether they form monophyletic species
  conspecific <- c()
  for (i in duplicated_species) {
    # get ancestor of tip
    ancestor <- phylobase::ancestor(phy = phylod, node = i)
    # get descendants from the ancestral node
    descendants <- phylobase::descendants(phy = phylod, node = ancestor)
    # check if all descendants are the same species
    conspecific <- c(
      conspecific,
      all_descendants_conspecific(descendants = names(descendants))
    )
  }

  # return boolean
  all(conspecific)
}








