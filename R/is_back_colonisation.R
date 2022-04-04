#' Checks whether species has undergone back-colonisation from
#'
#' @inheritParams default_params_doc
#'
#' @return A character string or FALSE. Character string is in the format
#' ancestral_node -> focal_node, where the ancestral node is not on mainland
#' but the focal node is.
#' @export
#'
#' @examples
#' set.seed(
#' 3,
#' kind = "Mersenne-Twister",
#' normal.kind = "Inversion",
#' sample.kind = "Rejection"
#' )
#' phylo <- ape::rcoal(5)
#' phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e")
#' phylo <- phylobase::phylo4(phylo)
#' endemicity_status <- c("endemic", "endemic", "not_present",
#'                        "endemic", "not_present")
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
#' # aritificially modify data to produce back-colonisation
#' phylobase::tdata(phylod)$island_status[8] <- "endemic"
#' # Example without back colonisation
#' is_back_colonisation(phylod = phylod, node_label = 2)
#' # Example with back colonisation
#' is_back_colonisation(phylod = phylod, node_label = 3)
is_back_colonisation <- function(phylod,
                                 node_label) {

  # check phylod
  phylod <- check_phylo_data(phylod)

  # get the node type
  node_type <- phylobase::nodeType(phylod)[node_label]

  # get the endemicity of the focal species
  which_species <- which(phylobase::nodeId(phylod) == node_label)

  if (node_type == "tip") {
    species_endemicity <-
      phylobase::tdata(phylod)[which_species, "endemicity_status"]
  } else if (node_type == "internal") {
    species_endemicity <-
      phylobase::tdata(phylod)[which_species, "island_status"]
  } else if (node_type == "root") {
    # root has no ancestral state
    return(FALSE)
  }

  # cannot be a back-colonisation if the state is on the island
  if (species_endemicity %in% c("endemic")) {
    return(FALSE)
  }

  # get species ancestor (node)
  ancestor <- unname(phylobase::ancestor(phy = phylod, node = node_label))
  # get the endemicity of the ancestral species
  species_endemicity <-
    phylobase::tdata(phylod)[ancestor, "island_status"]

  if (species_endemicity == "endemic") {
    back_colonist <- paste(ancestor, "->", node_label)
  } else {
    return(FALSE)
  }

  # return back_colonist
  back_colonist
}
