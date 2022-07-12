test_that("extract_stem_age_genus works for island clade", {
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

  stem_age <- extract_stem_age_genus(
    genus_in_tree = c(7, 8),
    phylod = phylod,
    constrain_to_island = FALSE
  )

  expect_equal(stem_age, 0.764855342311)
})

test_that("extract_stem_age_genus works for no island species", {
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

  stem_age <- extract_stem_age_genus(
    genus_in_tree = c(7, 8),
    phylod = phylod,
    constrain_to_island = FALSE
  )

  expect_equal(stem_age, 0.764855342311)
})

test_that("extract_stem_age_genus works for multiple genera", {
  set.seed(1)
  tree <- ape::rcoal(10)
  tree$tip.label <- c(
    "passerine_a", "passerine_b", "passerine_c", "passerine_d", "passerine_e",
    "passerine_f", "parrot_a", "parrot_b", "kakapo_a", "passerine_j")
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

  stem_age <- extract_stem_age_genus(
    genus_in_tree = c(7, 8),
    phylod = phylod,
    constrain_to_island = FALSE
  )

  expect_equal(stem_age, 0.764855342311)
})

test_that("extract_stem_age_genus fails for no island species constrain_to_island", {
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

  expect_error(extract_stem_age_genus(
    genus_in_tree = c(7, 8),
    phylod = phylod,
    constrain_to_island = TRUE
  ))
})
