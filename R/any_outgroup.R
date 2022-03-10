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

  # get species not present on the island
  species_not_present <- which(
    phylobase::tipData(phylod)$endemicity_status %in% "not_present"
  )

  # is_outgroup is a flag to stop once outgroup is found
  is_outgroup <- FALSE

  # loop over all species not present on the island
  for (i in species_not_present) {

    # stops the loop once outgroup is found
    if (is_outgroup) {
      break
    }

    # get the name of the species and its ancestor node
    species_label <- phylobase::labels(phylod)[i]

    # recursive tree traversal to find root
    all_siblings_not_present <- TRUE
    ancestor <- species_label
    descendants <- species_label
    while (all_siblings_not_present) {
      # get ancestral node
      ancestor <- phylobase::ancestor(phy = phylod, node = ancestor)
      is_outgroup <- identical(ancestor, phylobase::rootNode(phylod))
      if (is_outgroup) {
        break
      }
      # get descendants from ancestral node
      descendants <- phylobase::descendants(phy = phylod, node = ancestor)
      # get presence of siblings
      which_siblings <- which(phylobase::labels(phylod) %in% names(descendants))
      sibling_presence <-
        phylobase::tdata(phylod)[which_siblings, "endemicity_status"]
      # check if all siblings are not present on the island
      all_siblings_not_present <- all(sibling_presence == "not_present")
    }
  }

  # return is_group
  is_outgroup
}
