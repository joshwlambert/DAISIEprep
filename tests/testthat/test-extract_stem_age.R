test_that("extract_stem_age works for island clade with island_presence min", {
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

  stem_age <- extract_stem_age(
    genus_name = "parrot",
    phylod = phylod,
    stem = "island_presence",
    extraction_method = "min"
  )

  expect_equal(stem_age, 0.764855342311)
})

test_that("extract_stem_age works for island clade with island_presence asr", {
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

  stem_age <- extract_stem_age(
    genus_name = "parrot",
    phylod = phylod,
    stem = "island_presence",
    extraction_method = "min"
  )

  expect_equal(stem_age, 0.764855342311)
})

test_that("extract_stem_age works for no island species island_presence min", {
  set.seed(1)
  tree <- ape::rcoal(10)
  tree$tip.label <- c(
    "passerine_a", "passerine_b", "passerine_c", "passerine_d", "passerine_e",
    "passerine_f", "parrot_a", "parrot_b", "parrot_c", "passerine_j")
  tree <- phylobase::phylo4(tree)
  endemicity_status <- c(
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "endemic", "not_present", "not_present", "not_present")
  phylod <- phylobase::phylo4d(tree, as.data.frame(endemicity_status))
  # commented out plot can be uncommented for checking
  # DAISIEprep::plot_phylod(phylod)

  phylod <- phylobase::subset(x = phylod, tips.exclude = "parrot_a")
  # commented out plot can be uncommented for checking
  # DAISIEprep::plot_phylod(phylod)

  stem_age <- extract_stem_age(
    genus_name = "parrot",
    phylod = phylod,
    stem = "island_presence",
    extraction_method = "min"
  )

  expect_equal(stem_age, 0.0496052290447)
})

test_that("extract_stem_age works for island clade for island_presence asr", {
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

  stem_age <- extract_stem_age(
    genus_name = "parrot",
    phylod = phylod,
    stem = "island_presence",
    extraction_method = "asr"
  )

  expect_equal(stem_age, 1.72142283601)
})
