#' Extracts the information for an endemic clade (i.e. more than one species on
#' the island more closely related to each other than other mainland species)
#' from a phylogeny (specifically `phylo4d`  object from `phylobase` package)
#' and stores it in an `island_colonist` class
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `Island_colonist` class
#' @export
#'
#' @examples
#' set.seed(1)
#' phylo <- ape::rcoal(10)
#' phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
#'                      "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
#' phylo <- methods::as(phylo, "phylo4")
#' endemicity_status <- sample(c("not_present", "endemic", "nonendemic"),
#'                               size = length(phylobase::tipLabels(phylo)),
#'                               replace = TRUE)
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' island_col <- extract_endemic_clade(
#'   phylod = phylod,
#'   species_label = "bird_i"
#' )
extract_endemic_clade <- function(phylod,
                                  species_label) {

  # create an instance of the island_colonist class to store data
  island_col <- island_colonist()


  # if not all species in the tree are endemic find endemic clade
  all_phylo_endemic <- all(
    phylobase::tipData(phylod)$endemicity_status %in% "endemic"
  )

  if (isFALSE(all_phylo_endemic)) {
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
      sibling_endemicity <-
        phylobase::tdata(phylod)[which_siblings, "endemicity_status"]
      all_siblings_endemic <- all(sibling_endemicity == "endemic")
    }
  }

  # extract colonisation time as stem age of clade (time before present)
  col_time <- as.numeric(phylobase::nodeHeight(
    x = phylod,
    node = ancestor,
    from = "min_tip"
  ))

  # subset the endemic clade from the rest of the tree
  endemic_clade_phylod <- phylobase::subset(
    x = phylod,
    tips.include = endemic_clade
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

  # remove any duplicates if two species come from the same branching event
  branching_times <- sort(unique(node_heights), decreasing = TRUE)

  # remove any zero valued branching times
  branching_times <- branching_times[-which(branching_times == 0)]

  # add the colonisation time to the branching times
  branching_times <- c(col_time, branching_times)

  # extract clade name from species labels
  clade_name <- extract_clade_name(endemic_clade)

  # assign data to instance of island_colonist class
  set_clade_name(island_col) <- species_label #clade_name
  set_status(island_col) <- "endemic"
  set_missing_species(island_col) <- 0
  set_branching_times(island_col) <- branching_times

  # return island_colonist class
  island_col
}
