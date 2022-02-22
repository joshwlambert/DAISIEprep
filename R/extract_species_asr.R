#' Extracts the information for a non-endemic species from a phylogeny
#' (specifically `phylo4d`  object from `phylobase` package) and stores it in
#' in an `island_colonist` class
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `island_colonist` class
#' @export
#'
#' @examples
#' set.seed(1)
#' phylo <- ape::rcoal(10)
#' phylo <- methods::as(phylo, "phylo4")
#' endemicity_status <- sample(c("not_present", "endemic", "nonendemic"),
#'                               size = length(phylobase::tipLabels(phylo)),
#'                               replace = TRUE)
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' extract_nonendemic(phylod = phylod, species_label = "t7")
extract_species_asr <- function(phylod,
                                species_label,
                                species_endemicity,
                                island_tbl) {
browser()
  # create an instance of the island_colonist class to store data
  island_col <- island_colonist()

  #TODO: write check that the species_label refers to nonendemic species

  # recursive tree traversal to find colonisation time from node states
  island_ancestor <- TRUE
  ancestor <- species_label
  descendants <- species_label
  while (island_ancestor) {
    # get species ancestor (node)
    ancestor <- phylobase::ancestor(phy = phylod, node = ancestor)
    # get the island status at the ancestor (node)
    ancestor_island_status <-
      phylobase::tdata(phylod)[ancestor, "island_status"]
    is_root <- unname(phylobase::nodeType(phylod)[ancestor])
    island_ancestor <- ancestor_island_status == "island" && !is_root == "root"
  }

  descendants <- phylobase::descendants(phy = phylod, node = ancestor)
  num_descendants <- length(descendants)

  if (num_descendants == 1) {
    # extract nonendemic singleton
    if (species_endemicity == "nonendemic") {
      # extract singleton nonendemic
      island_colonist <- extract_nonendemic(
        phylod = phylod,
        species_label = species_label
      )
    } else if (species_endemicity == "endemic") {
      #extract singleton endemic
      island_colonist <- extract_endemic(
        phylod = phylod,
        species_label = species_label
      )
    }
  } else {
    # check if all descendants are the same species
    multi_tip_species <- all_descendants_conspecific()

    if (isTRUE(multi_tip_species)) {
      if (species_endemicity == "nonendemic") {
        # extact multi-tip nonendemic
        island_colonist <- extract_multi_tip_nonendemic(
          phylod = phylod,
          species_label = species_label
        )
      } else if (species_endemicity == "endemic") {
        # extract multi-tip endemic
        island_colonist <- extract_multi_tip_endemic(
          phylod = phylod,
          species_label = species_label
        )
      }
    } else {
      island_colonist <- extract_asr_clade(
        phylod = phylod,
        species_label = species_label
      )
    }
  }







  # extract colonisation time as stem age of clade (time before present)
  col_time <- as.numeric(phylobase::nodeHeight(
    x = phylod,
    node = ancestor,
    from = "min_tip"
  ))

  # assign data to instance of island_colonist class
  set_clade_name(island_col) <- species_label
  set_status(island_col) <- "nonendemic"
  set_missing_species(island_col) <- 0
  set_branching_times(island_col) <- col_time

  #return instance of island_colonist class
  island_col

  # check if colonist has already been stored in island_tbl class
  duplicate_colonist <- is_duplicate_colonist(
    island_colonist = island_colonist,
    island_tbl = tbl
  )

  if (!duplicate_colonist) {
    # bind data from island_colonist class into island_tbl class
    tbl <- bind_colonist_to_tbl(
      island_colonist = island_colonist,
      island_tbl = tbl
    )
  }
  #return instance of island_tbl class
  island_tbl
}
