extract_endemic_clade <- function(phylod, species_label) {

  # create an instance of the island_colonist class to store data
  island_col <- new("island_colonist")

  # recursive tree traversal to find all endemic species in clade
  all_siblings_endemic <- TRUE
  ancestor <- species_label
  descendants <- species_label
  while (all_siblings_endemic) {
    ancestor <- phylobase::ancestor(phy = phylod, node = ancestor)
    # save a copy of descendants for when loop stops
    endemic_clade <- descendants
    descendants <- phylobase::descendants(phy = phylod, node = ancestor)
    # get endemicity of siblings
    which_siblings <- which(phylobase::labels(phylod) %in% names(descendants))
    sibling_endemicity <- phylobase::tdata(phylod)[which_siblings, ]
    all_siblings_endemic <- all(sibling_endemicity == "endemic")
  }

  # extract colonisation time as stem age of clade (time before present)
  col_time <- as.numeric(phylobase::nodeHeight(
    x = phylod,
    node = ancestor,
    from = "min_tip"
  ))

  # extract branching times (time before present)
  branching_times <- c()
  for (tip in endemic_clade) {
    branching_times <- c(
      branching_times,
      as.numeric(phylobase::nodeHeight(
        x = phylod,
        node = phylobase::ancestor(phy = phylod, node = tip),
        from = "min_tip"
      ))
    )
  }

  # remove any duplicates if two species come from the same branching event
  branching_times <- unique(branching_times)

  # add the colonisation time to the branching times
  branching_times <- c(col_time, branching_times)

  # assign data to instance of island_colonist class
  set_clade_name(island_col) <- species_label
  set_status(island_col) <- "endemic"
  set_missing_species(island_col) <- 0
  set_branching_times(island_col) <- branching_times

  # return island_colonist class
  island_col
}
