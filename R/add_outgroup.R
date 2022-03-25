#' Add an outgroup species to a given phylogeny.
#'
#' @inheritParams default_params_doc
#'
#' @return A `phylo` object
#' @export
#'
#' @examples
#' phylo <- ape::rcoal(10)
#' phylo_with_outgroup <- add_outgroup(phylo)
add_outgroup <- function(phylo) {

  # check the phylo input
  correct_class <- class(phylo) %in% c("phylo", "phylo4")
  if (isFALSE(correct_class)) {
    stop("The phylo object should be a 'phylo' or 'phylo4' object")
  }

  if (identical(class(phylo), "phylo4")) {
    # require S3 phylo objects
    # suppress warnings about tree conversion as they are fine
    phylo <- suppressWarnings(methods::as(phylo, "phylo"))
  }

  # make a two species phylogeny to as backbone to bind phylogeny onto
  outgroup <- list(
    edge = matrix(c(3, 3, 1, 2), 2, 2),
    tip.label = c("species_one", "species_two"),
    edge.length = c(1, 1),
    Nnode = 1
  )
  class(outgroup) <- "phylo"

  # bind the two phylogenies
  bound_phylo <- ape::bind.tree(x = outgroup, y = phylo, where = 2)

  # make the phylogeny ultrametric
  bound_phylo$edge.length[1] <- max(ape::node.depth.edgelength(bound_phylo))

  if (!ape::is.ultrametric(bound_phylo)) {
    stop("Phylogeny is not ultrametric after adding outgroup")
  }

  #return phylo object
  bound_phylo
}
