test_that("extract_stem_age works for island clade without constraint", {
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
    extraction_method = "min",
    constrain_to_island = FALSE
  )

  expect_equal(stem_age, 0.764855342311)
})

test_that("extract_stem_age works for island clade with constraint", {
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
    extraction_method = "min",
    constrain_to_island = TRUE
  )

  expect_equal(stem_age, 0.764855342311)
})

test_that("extract_stem_age works for no island species without constraint", {
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
    extraction_method = "min",
    constrain_to_island = FALSE
  )

  expect_equal(stem_age, 0.764855342311)
})

test_that("extract_stem_age fails for no island species with constraint", {
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

  expect_error(extract_stem_age(
    genus_name = "parrot",
    phylod = phylod,
    extraction_method = "min",
    constrain_to_island = TRUE
  ),
  regexp = "constrain_to_island = TRUE but no island species in genus found")
})
