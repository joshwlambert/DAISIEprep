test_that("1 endemic, 3 species tree", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "not_present", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  expect_false(
    is_endemic_clade(
      phylod = phylod,
      species_label = "bird_a"
    )
  )
})

test_that("2 endemics, 3 species tree, sisters", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  expect_true(
    is_endemic_clade(
      phylod = phylod,
      species_label = "bird_a"
    )
  )
})

test_that("2 endemics, 4 species tree, sisters", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "not_present", "endemic", "endemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  expect_true(
    is_endemic_clade(
      phylod = phylod,
      species_label = "bird_c"
    )
  )
})

test_that("2 endemics, 4 species tree, non-sisters", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "endemic", "not_present", "endemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  expect_false(
    is_endemic_clade(
      phylod = phylod,
      species_label = "bird_b"
    )
  )
})
