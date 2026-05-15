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
#'   species_label = "bird_i",
#'   species_endemicity = "endemic",
#'   island_tbl = island_tbl,
#'   include_not_present = FALSE
#' )
extract_species_asr <- function(phylod,
                                species_label,
                                species_endemicity,
                                island_tbl,
                                include_not_present,
                                min_off_island_nodes = Inf) {

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

  # If `min_off_island_nodes` is set, scan the candidate clade for re-colonisations
  # separated from the previous on-island ancestor by a long enough off-island
  # detour. Each such sub-clade is split out as its own Island_colonist.
  split_nodes <- integer(0)
  if (is.finite(min_off_island_nodes)) {
    candidate_root <- ancestor
    for (child in phylobase::children(phylod, candidate_root)) {
      split_nodes <- c(split_nodes, find_off_island_split_nodes(
        phylod = phylod,
        node = child,
        off_count = 0L,
        min_off_island_nodes = min_off_island_nodes
      ))
    }
  }

  if (length(split_nodes) > 0) {
    return(
      extract_split_colonists(
        phylod = phylod,
        species_label = species_label,
        clade = clade,
        split_nodes = split_nodes,
        island_tbl = island_tbl,
        include_not_present = include_not_present
      )
    )
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

#' Recursively scan downward from `node` to find island sub-clades that sit
#' below a stretch of at least `min_off_island_nodes` consecutive `not_present`
#' internal nodes. Such sub-clades should be split out as separate island
#' colonists.
#'
#' @inheritParams default_params_doc
#' @param node Integer node id to start the recursive scan from.
#' @param off_count Integer count of consecutive `not_present` internal node
#' ancestors traversed so far on the path from the last on-island node.
#'
#' @return Integer vector of node ids to split off as their own colonists.
#' @keywords internal
find_off_island_split_nodes <- function(phylod,
                                        node,
                                        off_count,
                                        min_off_island_nodes) {

  node_type <- unname(phylobase::nodeType(phylod)[node])
  is_tip <- node_type == "tip"

  if (is_tip) {
    state <- phylobase::tdata(phylod)[node, "endemicity_status"]
  } else {
    state <- phylobase::tdata(phylod)[node, "island_status"]
  }
  is_island <- state %in% c("endemic", "nonendemic")

  results <- integer(0)

  if (is_island) {
    if (off_count >= min_off_island_nodes) {
      results <- c(results, as.integer(node))
    }
    if (!is_tip) {
      for (child in phylobase::children(phylod, node)) {
        results <- c(results, find_off_island_split_nodes(
          phylod = phylod,
          node = child,
          off_count = 0L,
          min_off_island_nodes = min_off_island_nodes
        ))
      }
    }
  } else if (!is_tip) {
    new_count <- off_count + 1L
    for (child in phylobase::children(phylod, node)) {
      results <- c(results, find_off_island_split_nodes(
        phylod = phylod,
        node = child,
        off_count = new_count,
        min_off_island_nodes = min_off_island_nodes
      ))
    }
  }

  results
}

#' Given a candidate clade and a set of `split_nodes` identified by
#' `find_off_island_split_nodes()`, build an `Island_colonist` for each split
#' sub-clade and one for the outer remainder, append them all to `island_tbl`,
#' and mark every tip in the candidate clade as extracted.
#'
#' @inheritParams default_params_doc
#' @param split_nodes Integer vector of node ids returned by
#' `find_off_island_split_nodes()`.
#'
#' @return An object of `Island_tbl` class.
#' @keywords internal
extract_split_colonists <- function(phylod,
                                    species_label,
                                    clade,
                                    split_nodes,
                                    island_tbl,
                                    include_not_present) {

  inner_tip_sets <- lapply(split_nodes, function(n) {
    desc <- phylobase::descendants(phy = phylod, node = n)
    names(desc)
  })
  all_inner_tips <- unique(unlist(inner_tip_sets))
  outer_tips <- setdiff(names(clade), all_inner_tips)

  endemicity <- phylobase::tipData(phylod)$endemicity_status
  names(endemicity) <- phylobase::tipLabels(phylod)

  build_subclade_colonist <- function(tip_names, sub_species_label) {
    sub_clade <- clade[names(clade) %in% tip_names]
    island_tips <- tip_names[endemicity[tip_names] %in%
                               c("endemic", "nonendemic")]
    if (length(island_tips) == 0) {
      return(NULL)
    }
    if (is.null(sub_species_label)) {
      sub_species_label <- island_tips[1]
    }
    sub_endemicity <- endemicity[sub_species_label]
    if (length(island_tips) == 1) {
      if (sub_endemicity == "nonendemic") {
        extract_nonendemic(phylod = phylod, species_label = sub_species_label)
      } else {
        extract_endemic_singleton(
          phylod = phylod,
          species_label = sub_species_label
        )
      }
    } else {
      extract_asr_clade(
        phylod = phylod,
        species_label = sub_species_label,
        clade = sub_clade,
        include_not_present = include_not_present
      )
    }
  }

  # Outer colonist (keeps the original species_label if that tip is still in
  # the outer remainder; otherwise the first island tip in the outer is used).
  outer_label <- if (species_label %in% outer_tips) species_label else NULL
  outer_colonist <- build_subclade_colonist(outer_tips, outer_label)
  if (!is.null(outer_colonist) &&
      !is_duplicate_colonist(outer_colonist, island_tbl)) {
    island_tbl <- bind_colonist_to_tbl(outer_colonist, island_tbl)
  }

  for (tip_set in inner_tip_sets) {
    inner_colonist <- build_subclade_colonist(tip_set, NULL)
    if (!is.null(inner_colonist) &&
        !is_duplicate_colonist(inner_colonist, island_tbl)) {
      island_tbl <- bind_colonist_to_tbl(inner_colonist, island_tbl)
    }
  }

  set_extracted_species(island_tbl) <- names(clade)
  island_tbl
}
