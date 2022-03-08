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
#' \dontrun{
#' set.seed(
#'   1,
#'   kind = "Mersenne-Twister",
#'   normal.kind = "Inversion",
#'   sample.kind = "Rejection"
#' )
#' phylo <- ape::rcoal(10)
#' phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
#'                      "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
#' phylo <- methods::as(phylo, "phylo4")
#' endemicity_status <- sample(c("not_present", "endemic", "nonendemic"),
#'                               size = length(phylobase::tipLabels(phylo)),
#'                               replace = TRUE)
#' tip_states <- as.numeric(grepl(pattern = "endemic", x = endemicity_status)) + 1
#' phylo <- as(phylo, "phylo")
#' asr <- castor::asr_max_parsimony(phylo, tip_states)
#' colnames(asr$ancestral_likelihoods) <- c("not_present", "island")
#' node_states <- max.col(asr$ancestral_likelihoods, ties.method = "last")
#' node_states <- gsub(pattern = "2", replacement = "island", x = node_states)
#' node_states <- gsub(pattern = "1", replacement = "not_present", x = node_states)
#' node_data <- data.frame(
#'   island_status = node_states,
#'   row.names = phylobase::nodeId(phylod, "internal")
#' )
#' phylod <- phylo4d(
#'   phylo,
#'   tip.data = as.data.frame(endemicity_status),
#'   node.data = node_data
#' )
#' island_tbl <- island_tbl()
#' extract_species_asr(
#'   phylod = phylod,
#'   species_label = "bird_g",
#'   species_endemicity = "endemic",
#'   island_tbl = island_tbl
#' )
#' }
extract_species_asr <- function(phylod,
                                species_label,
                                species_endemicity,
                                island_tbl,
                                include_not_present) {

  # recursive tree traversal to find colonisation time from node states
  island_ancestor <- TRUE
  ancestor <- species_label
  descendants <- species_label
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
    if (node_type == "root" && ancestor_island_status == "island") {
      clade <- phylobase::descendants(phy = phylod, node = ancestor)
      break
    }
    island_ancestor <- ancestor_island_status == "island"
  }

  # count number of island species in the clade
  if (include_not_present) {
    num_descendants <- length(clade)
  } else {

    # which species are in the clade
    tips_in_clade <- phylobase::tipLabels(phylod) %in% clade

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
      island_colonist <- extract_endemic(
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
  #return instance of island_tbl class
  island_tbl
}
