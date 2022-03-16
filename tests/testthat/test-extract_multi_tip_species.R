test_that("2 tips nonendemic, 3 species tree, sisters", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("nonendemic", "nonendemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_colonist <- extract_multi_tip_species(
    phylod = phylod,
    species_label = "bird_a_1",
    species_endemicity = "nonendemic"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_a")
  expect_equal(get_status(island_colonist), "nonendemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_branching_times(island_colonist), 1.43337005682)
  expect_equal(get_min_age(island_colonist), 0.251727277709)
})

test_that("2 tips nonendemic, 4 species tree, sisters", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c_1", "bird_c_2")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "not_present", "nonendemic",
                         "nonendemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_colonist <- extract_multi_tip_species(
    phylod = phylod,
    species_label = "bird_c_1",
    species_endemicity = "nonendemic"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_c")
  expect_equal(get_status(island_colonist), "nonendemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_branching_times(island_colonist), 0.519744565224)
  expect_equal(get_min_age(island_colonist), 0.125863638855)
})

test_that("2 tips endemic, 3 species tree, sisters", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_colonist <- extract_multi_tip_species(
    phylod = phylod,
    species_label = "bird_a_1",
    species_endemicity = "endemic"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_a")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_branching_times(island_colonist), 1.43337005682)
  expect_equal(get_min_age(island_colonist), 0.251727277709)
})

test_that("2 tips endemic, 4 species tree, sisters", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c_1", "bird_c_2")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "not_present", "endemic", "endemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_colonist <- extract_multi_tip_species(
    phylod = phylod,
    species_label = "bird_c_1",
    species_endemicity = "endemic"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_c")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_branching_times(island_colonist), 0.519744565224)
  expect_equal(get_min_age(island_colonist), 0.125863638855)
})

test_that("3 tips nonendemic, 4 species tree, sisters", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b_1", "bird_b_2", "bird_b_3")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "nonendemic", "nonendemic",
                         "nonendemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_colonist <- extract_multi_tip_species(
    phylod = phylod,
    species_label = "bird_b_1",
    species_endemicity = "nonendemic"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_b")
  expect_equal(get_status(island_colonist), "nonendemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_branching_times(island_colonist), 0.665451291928)
  expect_equal(get_min_age(island_colonist), 0.519744565224)
})

test_that("3 tips endemic, 4 species tree, sisters", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b_1", "bird_b_2", "bird_b_3")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "endemic", "endemic", "endemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_colonist <- extract_multi_tip_species(
    phylod = phylod,
    species_label = "bird_b_1",
    species_endemicity = "endemic"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_b")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_branching_times(island_colonist), 0.665451291928)
  expect_equal(get_min_age(island_colonist), 0.519744565224)
})
