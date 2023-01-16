#' Extracts the stem age from the phylogeny when the a species is known to
#' belong to a genus but is not itself in the phylogeny and there are members
#' of the same genus are in the phylogeny using the 'asr' extraction method
#'
#' @inheritParams default_params_doc
#'
#' @return Numeric
extract_stem_age_asr <- function(genus_in_tree,
                                 phylod) {

  # check extraction_method and asr_method input
  missing_node_data <- "island_status" %in% names(phylobase::nodeData(phylod))

  if (isFALSE(missing_node_data)) {
    stop("Using colonisation times from ancestral state reconstruction requires
         data of the island presence at the nodes")
  }

  extracted_col_times <- c()
  # add for loop to loop over genus_in_tree elements
  for (i in genus_in_tree) {
    species_label <- phylobase::tipLabels(phylod)[i]

    # set up variables to be modified in the loop
    island_ancestor <- TRUE
    ancestor <- species_label
    descendants <- 1
    names(descendants) <- species_label

    # recursive tree traversal to find colonisation time from node states
    while (island_ancestor) {
      # get species ancestor (node)
      ancestor <- phylobase::ancestor(phy = phylod, node = ancestor)
      # save a copy of descendants for when loop stops
      clade <- descendants
      descendants <- phylobase::descendants(phy = phylod, node = ancestor)
      # get the island status at the ancestor (node)
      ancestor_island_status <-
        phylobase::tdata(phylod)[ancestor, "island_status"]
      node_type <- unname(phylobase::nodeType(phylod)[ancestor])
      # if the root state is island then all species in the tree are in the clade
      if (node_type == "root" &&
          ancestor_island_status %in% c("endemic", "nonendemic")) {
        clade <- phylobase::descendants(phy = phylod, node = ancestor)
        warning("Root of the phylogeny is on the island so the colonisation
              time from the stem age cannot be collected, stem age will be the
              crown age of the phylogeny.")
        break
      }
      island_ancestor <- ancestor_island_status %in% c("endemic", "nonendemic")
    }

    # count the number of species in the focal clade
    if (length(clade) == 1) {
      # when only one species is in the clade use the edge length
      col_time <- as.numeric(phylobase::edgeLength(phylod, names(clade)))
    } else {

      # when more than one species is in the clade extract the stem age
      # use S3 phylo objects for speed
      # suppress warnings about tree conversion as they are fine
      phylo <- suppressWarnings(methods::as(phylod, "phylo"))

      # extract colonisation time as stem age of clade (time before present)
      mrca <- ape::getMRCA(phylo, tip = clade)
      stem <- phylo$edge[which(phylo$edge[, 2] == mrca), 1]
      col_times <- ape::node.depth.edgelength(phy = phylo)

      # convert from distance from root to distance from tip
      col_times <- abs(col_times - max(col_times))

      # if all the species in
      if (all(phylobase::tipLabels(phylod) %in% names(clade))) {
        # get only the stem age
        col_time <- max(col_times)
      } else {
        # get only the stem age
        col_time <- col_times[stem]
      }
    }

    # add stem age
    extracted_col_times <- c(extracted_col_times, col_time)
  }

  # maximum age from those extracted
  col_time <- max(extracted_col_times)

  # return stem age
  col_time
}
