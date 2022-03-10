#' Plots the phylogenetic tree and its associated tip and/or node data
#'
#' @inheritParams default_params_doc
#'
#' @return `ggplot` object
#' @export
#'
#' @examples
#' set.seed(
#'   1,
#'   kind = "Mersenne-Twister",
#'   normal.kind = "Inversion",
#'   sample.kind = "Rejection"
#' )
#' phylo <- ape::rcoal(10)
#' phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
#'                      "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
#' phylo <- phylobase::phylo4(phylo)
#' endemicity_status <- sample(
#'   c("not_present", "endemic", "nonendemic"),
#'   size = length(phylobase::tipLabels(phylo)),
#'   replace = TRUE,
#'   prob = c(0.6, 0.2, 0.2)
#' )
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' plot_phylod(phylod)
plot_phylod <- function(phylod) {

  # Fix build warnings
  endemicity_status <- NULL; rm(endemicity_status) # nolint, fixes warning: no visible binding for global variable
  island_status <- NULL; rm(island_status) # nolint, fixes warning: no visible binding for global variable

  #generate plot
  p <- ggtree::ggtree(phylod) +
    ggtree::geom_tippoint(
      ggplot2::aes(colour = endemicity_status),
      size = 3,
    ) +
    ggtree::theme_tree2() +
    ggtree::geom_tiplab(as_ylab = TRUE)

  if (!is.null(phylobase::nodeData(phylod)$island_status)) {
    p <- p +
      ggtree::geom_nodepoint(
        ggplot2::aes(colour = island_status),
        size = 3
      )
  }

  # return plot
  p
}
