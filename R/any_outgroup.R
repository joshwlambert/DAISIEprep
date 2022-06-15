#' Checks whether the phylogeny has an outgroup that is not present on the
#' island. This is critical when extracting data from the phylogeny so the
#' stem age (colonisation time) is correct.
#'
#' @inheritParams default_params_doc
#'
#' @return Boolean
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
#' endemicity_status <- sample(c("not_present", "endemic", "nonendemic"),
#'                             size = length(phylobase::tipLabels(phylo)),
#'                             replace = TRUE)
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' any_outgroup(phylod)
any_outgroup <- function(phylod) {

  # get the root node of the tree
  root_node <- phylobase::rootNode(phylod)

  # get descendants from ancestral node
  descendants <- phylobase::descendants(
    phy = phylod,
    node = root_node,
    type = "children"
  )

  # get endemicity status of immediate descendants of root node
  descendant_not_present <-
    phylobase::tdata(phylod)[descendants, "endemicity_status"]

  # remove NAs from descendants_not_present
  descendant_not_present <- stats::na.omit(descendant_not_present)

  # if any of the immediate descendants of the root are not_present tips there
  # is an outgroup
  if (any(descendant_not_present == "not_present")) {
    return(TRUE)
  } else {

    # get all the tip descended from the two descendants of root node
    tips <- lapply(
      as.list(descendants),
      phylobase::descendants,
      phy = phylod,
      type = "tips"
    )

    for (i in seq_along(tips)) {
      # get endemicity status of descendants
      tip_status <-
        phylobase::tdata(phylod)[tips[[i]], "endemicity_status"]

      if (all(tip_status == "not_present")) {
        return(TRUE)
      }
    }
  }

  # if none of the conditions for an outgroup species are met return FALSE
  FALSE
}
