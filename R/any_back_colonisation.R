#' Detects any cases where a non-endemic species or species not present on the
#' island has likely been on the island given its ancestral state reconstruction
#' indicating ancestral presence on the island and so is likely a back
#' colonisation from the island to the mainland (or potentially different
#' island). This function is useful if using extraction_method = "min" in
#' `DAISIEprep::extract_island_species()` as it may brake up a single colonist
#' into multiple colonists because of back-colonisation.
#'
#' @inheritParams default_params_doc
#'
#' @return A single or vector of character strings. Character string is in the
#' format ancestral_node -> focal_node, where the ancestral node is not on
#' mainland but the focal node is. In the case of no back colonisations a
#' different message string is returned.
#' @export
#'
#' @examples
#' # Example with no back colonisation
#' phylod <- create_test_phylod(test_scenario = 15)
#' any_back_colonisation(phylod)
#'
#' # Example with back colonisation
#' set.seed(
#'   3,
#'   kind = "Mersenne-Twister",
#'   normal.kind = "Inversion",
#'   sample.kind = "Rejection"
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
#' any_back_colonisation(phylod = phylod)
any_back_colonisation <- function(phylod,
                                  only_tips = FALSE) {

  # check phylod
  phylod <- check_phylo_data(phylod)

  # check data input has node data
  missing_node_data <- "island_status" %in% names(phylobase::nodeData(phylod))

  if (isFALSE(missing_node_data)) {
    stop("This function requires ancestral state reconstruction data of the
         island presence at the nodes")
  }

  back_cols <- c()
  if (only_tips) {
    # loop through the terminal branches of the phylogeny
    for (i in phylobase::nodeId(phylod, type = "tip")) {
      # determine and store if each tip is a back colonisation
      back_cols[i] <- is_back_colonisation(
        phylod = phylod,
        node_label = i
      )
    }
  } else {
    # loop through all branches in the phylogeny
    for (i in phylobase::nodeId(phylod, type = "all")) {
      # determine and store if each branch is a back colonisation
      back_cols[i] <- is_back_colonisation(
        phylod = phylod,
        node_label = i
      )
    }
  }

  # remove FALSE from vector
  back_cols <- back_cols[-which(back_cols == FALSE)]

  # when no back-colonisation are found
  if (length(back_cols) == 0) {
    return("No back-colonisation events found in the phylogeny")
  }

  # return the named vector
  back_cols
}
