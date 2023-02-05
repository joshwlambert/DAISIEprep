#' Write biogeography input file for BioGeoBEARS
#'
#' Write a text file containing occurrence data for all tips in the PHYLIP
#' format expected by BioGeoBEARS
#'
#' @inheritParams default_params_doc
#' @param path_to_biogeo string specifying the path and name to write the file
#' to.
#'
#' @export
#'
write_phylip_biogeo_file <- function(phylod, path_to_biogeo) {
  labels <- phylod@label
  ntips <- phylobase::nTips(phylod)
  endemicity <- phylod@data$endemicity_status[1:ntips]
  is_on_mainland <- as.integer(endemicity %in% c("nonendemic", "not_present"))
  is_on_island <- as.integer(endemicity %in% c("nonendemic", "endemic"))

  first_line <- paste0(ntips, "\t2\t(M I)\n")
  cat(first_line, file = path_to_biogeo, append = FALSE)
  for (i in seq_along(labels)) {
    next_line <- paste0(labels[i], "\t", is_on_mainland[i], is_on_island[i], "\n")
    cat(next_line, file = path_to_biogeo, append = TRUE)
  }
}

#' Write tree input file for BioGeoBEARS
#'
#' Write a text file containing a phylogenetic tree in the Newick format
#' expected by BioGeoBEARS
#'
#' @inheritParams default_params_doc
#' @param path_to_phylo string specifying the path and name to write the file to.
#'
#' @export
#'
write_newick_file <- function(phylod, path_to_phylo) {
  phylo <- methods::as(phylod, "phylo")
  ape::write.tree(phylo, file = path_to_phylo)
}

#' Write input files for BioGeoBEARS
#'
#' Write input files for a BioGeoBEARS analysis, i.e. a phlyogenetic tree in
#' Newick format and occurrence data in PHYLIP format.
#'
#' @inheritParams default_params_doc
#' @param path_to_phylo string specifying the path and name to write the phylogeny file to.
#' @param path_to_biogeo string specifying the path and name to write the biogeography file to.
#' @param path_to_biogeo string specifying the path and name to write the biogeography file to.
#' @export
#'
write_biogeobears_input <- function(phylod, path_to_phylo, path_to_biogeo) {
  write_newick_file(phylod, path_to_phylo)
  write_phylip_biogeo_file(phylod, path_to_biogeo)
}

#' Extract ancestral state probabilities from BioGeoBEARS output
#'
#' Extract the probabilities of each endemicity status for tip and internal node
#' states from the output of an optimisation performed with BioGeoBEARS
#'
#' @param biogeobears_res a list, the output of [BioGeoBEARS::bears_optim_run()]
#' @return a data.frame with one row per node (tips and internals) and four
#' columns: label | not_present | endemic | nonendemic, the last three columns
#' containing the probability of each endemicity status (and summing to 1).
#'
#' @export
#'
extract_biogeobears_ancestral_states_probs <- function(biogeobears_res) {
  # Extract probabilities
  asr_likelihoods <- biogeobears_res$ML_marginal_prob_each_state_at_branch_top_AT_node[,-1]
  # Need to find match tip labels to each row
  tree <- ape::read.tree(biogeobears_res$inputs$trfn)
  tip_labels <- tree$tip.label
  node_labels <- tree$node.label
  if (is.null(node_labels)) node_labels <- rep(NA, length(tip_labels) - 1)
  asr_df <- data.frame(
    label = c(tip_labels, node_labels),
    not_present_prob = asr_likelihoods[,1],
    endemic_prob = asr_likelihoods[,2],
    nonendemic_prob = asr_likelihoods[,3]
  )
  return(asr_df)
}
