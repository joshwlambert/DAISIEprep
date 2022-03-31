test_that("1 endemic, 3 species tree", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "not_present", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  endemic_species <- get_endemic_species(
    phylod = phylod,
    species_label = "bird_a"
  )
  expect_equal(endemic_species, c(bird_a = 1))
})

test_that("2 endemics, 3 species tree, sisters", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  endemic_species <- get_endemic_species(
    phylod = phylod,
    species_label = "bird_a"
  )
  expect_equal(endemic_species, c(bird_a = 1, bird_b = 2))
})

test_that("2 endemics, 4 species tree, sisters", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "not_present", "endemic", "endemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  endemic_species <- get_endemic_species(
    phylod = phylod,
    species_label = "bird_c"
  )
  expect_equal(endemic_species, c(bird_c = 3, bird_d = 4))
})

test_that("2 endemics, 4 species tree, non-sisters", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "endemic", "not_present", "endemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  endemic_species <- get_endemic_species(
    phylod = phylod,
    species_label = "bird_b"
  )
  expect_equal(endemic_species, c(bird_b = 1))
})
