#' Extracts the stem age from the phylogeny when the a species is known to
#' belong to a genus but is not itself in the phylogeny and there are members
#' of the same genus are in the phylogeny
#'
#' @inheritParams default_params_doc
#'
#' @return Numeric
extract_stem_age_genus <- function(genus_in_tree,
                                   phylod) {

  # set ingroup of species
  ingroup <- genus_in_tree

  # get the crown age of the ingroup
  crown <- phylobase::MRCA(phylod, ingroup)

  # the stem age is the parent of the crown node
  stem <- phylobase::ancestor(phy = phylod, node = crown)

  # get time of stem as time before present (assuming ultrametric tree)
  stem <- unname(phylobase::nodeHeight(
    x = phylod,
    node = stem,
    from = "min_tip"
  ))

  # return stem age
  stem
}
