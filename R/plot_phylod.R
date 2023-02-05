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
plot_phylod <- function(phylod,
                        node_pies = FALSE) {

  node_pie_data <-
    all(c("nonendemic_prob", "not_present_prob") %in%
          names(phylobase::tdata(phylod)))
  if (node_pies && !node_pie_data) {
    stop("To plot probabilities in at the nodes they must be in phylod")
  }

  # Fix build warnings
  endemicity_status <- NULL; rm(endemicity_status) # nolint, fixes warning: no visible binding for global variable
  island_status <- NULL; rm(island_status) # nolint, fixes warning: no visible binding for global variable

  # remove underscores in species names for plotting
  phylobase::tipLabels(phylod) <-  gsub(
    pattern = "_",
    replacement = " ",
    x = phylobase::tipLabels(phylod)
  )

  # generate plot
  # suppress Scale for 'y' is already present.
  p <- suppressMessages(ggtree::ggtree(phylod) +
    ggtree::theme_tree2() +
    ggtree::geom_tiplab(as_ylab = TRUE))

  # suppress Scale for 'x' is already present.
  attr(p$data, "revts.done") <- FALSE # attribute required by ggtree::revts
  p <- suppressMessages(ggtree::revts(treeview = p) +
    ggplot2::scale_x_continuous(labels = abs) +
    ggplot2::xlab("Time (Million years ago)"))


  if (!is.null(phylobase::nodeData(phylod)$endemicity_status)) {
    p <- p +
      ggtree::geom_tippoint(
        ggplot2::aes(colour = endemicity_status),
        size = 3,
      ) +
      ggplot2::labs(colour = "Endemicity status")
  }

  if (isTRUE(node_pies)) {

    if ("endemic_prob" %in% names(phylobase::tdata(phylod))) {
      states <- c("endemic_prob", "nonendemic_prob", "not_present_prob")
    } else {
      states <- c("nonendemic_prob", "not_present_prob")
    }

    node_pies <-
      phylobase::nodeData(phylod)[, states]
    node_pies <- cbind(node_pies, node = rownames(node_pies))

    pies <- ggtree::nodepie(node_pies, cols = 1:2)

    p <- p +
      ggtree::geom_inset(
        insets = pies,
        width = 0.1,
        height = 0.1,
      )

  } else if (!is.null(phylobase::nodeData(phylod)$island_status)) {
    p <- p +
      ggtree::geom_nodepoint(
        ggplot2::aes(colour = island_status),
        size = 3
      )
  }

  # return plot
  p
}
