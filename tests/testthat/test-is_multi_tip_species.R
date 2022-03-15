test_that("1 nonendemic, 3 species tree", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("nonendemic", "not_present", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  expect_false(
    is_multi_tip_species(
      phylod = phylod,
      species_label = "bird_a"
    )
  )
})

test_that("1 endemic, 3 species tree", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "not_present", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  expect_false(
    is_multi_tip_species(
      phylod = phylod,
      species_label = "bird_a"
    )
  )
})

test_that("2 tips nonendemic, 3 species tree, sisters", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("nonendemic", "nonendemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  expect_true(
    is_multi_tip_species(
      phylod = phylod,
      species_label = "bird_a_1"
    )
  )
})

test_that("2 tips endemic, 3 species tree, sisters", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  expect_true(
    is_multi_tip_species(
      phylod = phylod,
      species_label = "bird_a_1"
    )
  )
})
