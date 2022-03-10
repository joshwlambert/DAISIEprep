create_test_phylod <- function(test_scenario) {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )

  if (test_scenario == 0) {
    phylo <- ape::rcoal(2)
    phylo$tip.label <- c("bird_a", "bird_b")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "not_present")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 1) {
    phylo <- ape::rcoal(2)
    phylo$tip.label <- c("bird_a", "bird_b")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "nonendemic")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }


  # return phylod
  phylod
}


