#' Extracts the information for an endemic species which has multiple tips in
#' the phylogeny (i.e. more than one sample per species) from a phylogeny
#' (specifically `phylo4d`  object from `phylobase` package)
#' and stores it in an `island_colonist` class
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `Island_colonist` class
#' @export
extract_multi_tip_endemic <- function(phylod, species_label) {

  # create an instance of the island_colonist class to store data
  island_col <- island_colonist()

  #TODO: write check that the species_label refers to nonendemic species

  # recursive tree traversal to find all nonendemic species in clade
  all_same_species <- TRUE
  ancestor <- species_label
  descendants <- species_label
  while (all_same_species) {
    ancestor <- phylobase::ancestor(phy = phylod, node = ancestor)
    # save a copy of descendants for when loop stops
    endemic_species_tips <- descendants
    descendants <- phylobase::descendants(phy = phylod, node = ancestor)
    # get endemicity of siblings
    which_siblings <- which(phylobase::labels(phylod) %in% names(descendants))
    sibling_endemicity <-
      phylobase::tdata(phylod)[which_siblings, "endemicity_status"]
    all_siblings_endemic <- all(sibling_endemicity == "endemic")
    # get names of siblings
    descendants_names <- names(descendants)
    split_descendants_names <- strsplit(x = descendants_names, split = "_")
    descendants_genus_names <- sapply(split_descendants_names, "[[", 1)
    descendants_species_names <- sapply(split_descendants_names, "[[", 2)
    descendants_genus_species_names <- paste(
      descendants_genus_names, descendants_species_names, sep = "_"
    )

    # if all siblings are endemic and all tips are the same species continue
    island_endemics <- all_siblings_endemic &&
      any(duplicated(descendants_genus_species_names))
    if (isFALSE(island_endemics)) {
      all_same_species <- FALSE
    }
  }

  # extract colonisation time as stem age of species pops (time before present)
  col_time <- as.numeric(phylobase::nodeHeight(
    x = phylod,
    node = ancestor,
    from = "min_tip"
  ))

  # subset the multi-tip endemic species from the rest of the tree
  endemic_clade_phylod <- phylobase::subset(
    x = phylod,
    tips.include = endemic_species_tips
  )

  # extract branching times (time before present)
  node_heights <- c()
  for (i in seq_len(phylobase::nEdges(endemic_clade_phylod))) {
    node_heights[i] <- phylobase::nodeHeight(
      x = endemic_clade_phylod,
      node = i,
      from = "min_tip"
    )
  }

  # the min age is the crown age of the multi-tip species (i.e. earliest split)
  min_age <- max(node_heights)

  # assign data to instance of island_colonist class
  # extract species name from species label
  species_name <- unlist(strsplit(x = species_label, split = "_"))[1:2]
  species_name <- paste(species_name, collapse = "_")
  set_clade_name(island_col) <- species_name
  set_status(island_col) <- "endemic"
  set_missing_species(island_col) <- 0
  set_branching_times(island_col) <- col_time
  set_min_age(island_col) <- min_age

  # return instance of island_colonist class
  island_col
}
