test_that("extract_stem_age_asr works for island clade", {
  set.seed(1)
  tree <- ape::rcoal(10)
  tree$tip.label <- c(
    "passerine_a", "passerine_b", "passerine_c", "passerine_d", "passerine_e",
    "passerine_f", "parrot_a", "parrot_b", "parrot_c", "passerine_j")
  tree <- phylobase::phylo4(tree)
  endemicity_status <- c(
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "endemic", "endemic", "endemic", "not_present")
  phylod <- phylobase::phylo4d(tree, as.data.frame(endemicity_status))
  # commented out plot can be uncommented for checking
  # DAISIEprep::plot_phylod(phylod)

  phylod <- phylobase::subset(x = phylod, tips.exclude = "parrot_a")
  # commented out plot can be uncommented for checking
  # DAISIEprep::plot_phylod(phylod)

  phylod <- add_asr_node_states(
    phylod = phylod,
    asr_method = "parsimony",
    tie_preference = "mainland"
  )
  # commented out plot can be uncommented for checking
  # DAISIEprep::plot_phylod(phylod)

  stem_age <- extract_stem_age_asr(
    genus_in_tree = c(7, 8),
    phylod = phylod
  )

  expect_equal(stem_age, 1.72142283601)
})

test_that("extract_stem_age_asr fails without node states", {
  set.seed(1)
  tree <- ape::rcoal(10)
  tree$tip.label <- c(
    "passerine_a", "passerine_b", "passerine_c", "passerine_d", "passerine_e",
    "passerine_f", "parrot_a", "parrot_b", "parrot_c", "passerine_j")
  tree <- phylobase::phylo4(tree)
  endemicity_status <- c(
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "endemic", "endemic", "endemic", "not_present")
  phylod <- phylobase::phylo4d(tree, as.data.frame(endemicity_status))
  # commented out plot can be uncommented for checking
  # DAISIEprep::plot_phylod(phylod)

  phylod <- phylobase::subset(x = phylod, tips.exclude = "parrot_a")
  # commented out plot can be uncommented for checking
  # DAISIEprep::plot_phylod(phylod)

  expect_error(extract_stem_age_asr(
    genus_in_tree = c(7, 8),
    phylod = phylod
  ))
})
