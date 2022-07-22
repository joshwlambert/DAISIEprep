#' Extracts the stem age from the phylogeny when the a species is known to
#' belong to a genus but is not itself in the phylogeny and there are members
#' of the same genus are in the phylogeny using the 'min' extraction method
#'
#' @inheritParams default_params_doc
#'
#' @return Numeric
extract_stem_age_min <- function(genus_in_tree,
                                 phylod) {

  extracted_col_times <- c()
  # add for loop to loop over genus_in_tree elements
  for (i in genus_in_tree) {
    species_label <- phylobase::tipLabels(phylod)[i]

    # set up variables to be modified in the loop
    all_siblings <- TRUE
    ancestor <- species_label
    descendants <- 1
    names(descendants) <- species_label

    # recursive tree traversal to find endemic clade
    while (all_siblings) {
      ancestor <- phylobase::ancestor(phy = phylod, node = ancestor)
      # save a copy of descendants for when loop stops
      clade <- descendants
      descendants <- phylobase::descendants(phy = phylod, node = ancestor)
      # get endemicity of siblings
      which_siblings <- which(phylobase::labels(phylod) %in% names(descendants))

      # check whether all siblings are present on the island
      sibling_endemicity <-
        phylobase::tdata(phylod)[which_siblings, "endemicity_status"]
      all_siblings <- all(sibling_endemicity %in% c("endemic", "nonendemic"))
    }

    if (length(clade) == 1) {
      # extract stem age
      col_time <- as.numeric(phylobase::edgeLength(phylod, names(clade)))

      # add stem age
      extracted_col_times <- c(extracted_col_times, col_time)
    } else {
      # use S3 phylo objects for speed
      # suppress warnings about tree conversion as they are fine
      phylo <- suppressWarnings(methods::as(phylod, "phylo"))

      # extract colonisation time as stem age of clade (time before present)
      mrca <- ape::getMRCA(phylo, tip = clade)
      stem <- phylo$edge[which(phylo$edge[, 2] == mrca), 1]
      col_times <- ape::node.depth.edgelength(phy = phylo)

      # convert from distance from root to distance from tip
      col_times <- abs(col_times - max(col_times))

      # get only the stem age
      col_time <- col_times[stem]

      # add stem age
      extracted_col_times <- c(extracted_col_times, col_time)
    }

  }

  # maximum age from those extracted
  col_time <- max(extracted_col_times)

  # return stem age
  col_time
}
