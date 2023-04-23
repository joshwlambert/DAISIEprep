#' Extracts the colonisation, diversification, and endemicty data from
#' phylogenetic and endemicity data and stores it in an `Island_tbl` object
#' using the "asr" algorithm that extract island species given their ancestral
#' states of either island presence or absence.
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `island_tbl` class
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
#'                             replace = TRUE, prob = c(0.8, 0.1, 0.1))
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' phylod <- add_asr_node_states(
#'   phylod = phylod,
#'   asr_method = "parsimony"
#' )
#' island_tbl <- island_tbl()
#' extract_species_asr(
#'   phylod = phylod,
#'   species_label = "bird_g",
#'   species_endemicity = "endemic",
#'   island_tbl = island_tbl,
#'   include_not_present = FALSE
#' )
extract_species_asr <- function(phylod,
                                species_label,
                                species_endemicity,
                                island_tbl,
                                include_not_present) {

  # check input data
  phylod <- check_phylo_data(phylod)

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
              time from the stem age cannot be collected, colonisation time
              will be set to infinite.")
      break
    }
    island_ancestor <- ancestor_island_status %in% c("endemic", "nonendemic")
  }

  # count number of island species in the clade
  if (include_not_present) {
    num_descendants <- length(clade)

  } else {

    # which species are in the clade
    tips_in_clade <- phylobase::tipLabels(phylod) %in% names(clade)

    # which species are not present
    not_present <- phylobase::tipData(phylod)$endemicity_status == "not_present"

    # how many species are both in the clade and not present
    not_present_in_clade <- sum(tips_in_clade & not_present)

    num_descendants <- length(clade) - not_present_in_clade
  }

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
      island_colonist <- extract_endemic_singleton(
        phylod = phylod,
        species_label = species_label
      )
    }
  } else {
    # check if all descendants are the same species
    multi_tip_species <- all_descendants_conspecific(
      descendants = names(descendants)
    )

    if (isTRUE(multi_tip_species)) {
      # extract multi-tip species
      island_colonist <- extract_multi_tip_species(
        phylod = phylod,
        species_label = species_label,
        species_endemicity = species_endemicity
      )
    } else {
      island_colonist <- extract_asr_clade(
        phylod = phylod,
        species_label = species_label,
        clade = clade,
        include_not_present = include_not_present
      )
    }
  }

  # check if colonist has already been stored in island_tbl class
  duplicate_colonist <- is_duplicate_colonist(
    island_colonist = island_colonist,
    island_tbl = island_tbl
  )

  if (!duplicate_colonist) {
    # bind data from island_colonist class into island_tbl class
    island_tbl <- bind_colonist_to_tbl(
      island_colonist = island_colonist,
      island_tbl = island_tbl
    )
  }

  # append species in clade to island_tbl
  set_extracted_species(island_tbl) <- names(clade)

  #return instance of island_tbl class
  island_tbl
}
