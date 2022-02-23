is_back_colonisation <- function(phylod, species_label) {

  # get the endemicity of the focal species
  which_species <- which(phylobase::labels(phylod) %in% names(species_label))
  species_endemicity <-
    phylobase::tdata(phylod)[which_species, "endemicity_status"]

  # if the species is nonendemic or not present check if its a back colonist
  if (!identical(species_endemicity, "endemic")) {

    # recursive tree traversal to find colonisation time from node states
    island_ancestor <- TRUE
    ancestor <- species_label
    descendants <- species_label
    while (island_ancestor) {
      # get species ancestor (node)
      ancestor <- phylobase::ancestor(phy = phylod, node = ancestor)
      # save a copy of descendants for when loop stops
      clade <- descendants
      descendants <- phylobase::descendants(phy = phylod, node = ancestor)
      # get the island status at the ancestor (node)
      ancestor_island_status <-
        phylobase::tdata(phylod)[ancestor, "island_status"]
      is_root <- unname(phylobase::nodeType(phylod)[ancestor])
      island_ancestor <- ancestor_island_status == "island" && !is_root == "root"
    }
  }
}
