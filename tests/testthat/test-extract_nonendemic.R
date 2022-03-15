test_that("1 nonendemic, 2 species tree", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_colonist <- extract_nonendemic(
    phylod = phylod,
    species_label = "bird_b"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_b")
  expect_equal(get_status(island_colonist), "nonendemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_branching_times(island_colonist), 0.755181833128)
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("1 nonendemic, 3 species tree, outgroup", {
  phylod <- create_test_phylod(test_scenario = 2)
  island_colonist <- extract_nonendemic(
    phylod = phylod,
    species_label = "bird_c"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_c")
  expect_equal(get_status(island_colonist), "nonendemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_branching_times(island_colonist), 1.43337005682)
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("1 nonendemic, 3 species tree, non-outgroup", {
  phylod <- create_test_phylod(test_scenario = 3)
  island_colonist <- extract_nonendemic(
    phylod = phylod,
    species_label = "bird_b"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_b")
  expect_equal(get_status(island_colonist), "nonendemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_branching_times(island_colonist), 0.251727277709)
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("1 nonendemic, 4 species tree, outgroup", {
  phylod <- create_test_phylod(test_scenario = 4)
  island_colonist <- extract_nonendemic(
    phylod = phylod,
    species_label = "bird_a"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_a")
  expect_equal(get_status(island_colonist), "nonendemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_branching_times(island_colonist), 0.665451291928)
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("1 nonendemic, 4 species tree, non-outgroup", {
  phylod <- create_test_phylod(test_scenario = 5)
  island_colonist <- extract_nonendemic(
    phylod = phylod,
    species_label = "bird_b"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_b")
  expect_equal(get_status(island_colonist), "nonendemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_branching_times(island_colonist), 0.519744565224)
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("2 nonendemics, 3 species tree, sisters", {
  phylod <- create_test_phylod(test_scenario = 11)
  island_colonist <- extract_nonendemic(
    phylod = phylod,
    species_label = "bird_a"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_a")
  expect_equal(get_status(island_colonist), "nonendemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_branching_times(island_colonist), 0.251727277709)
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("2 nonendemics, 4 species tree, sister", {
  phylod <- create_test_phylod(test_scenario = 12)
  island_colonist <- extract_nonendemic(
    phylod = phylod,
    species_label = "bird_c"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_c")
  expect_equal(get_status(island_colonist), "nonendemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_branching_times(island_colonist), 0.125863638855)
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("2 nonendemics, 4 species tree, min, non-sisters", {
  phylod <- create_test_phylod(test_scenario = 13)
  island_colonist <- extract_nonendemic(
    phylod = phylod,
    species_label = "bird_b"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_b")
  expect_equal(get_status(island_colonist), "nonendemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_branching_times(island_colonist), 0.519744565224)
  expect_true(is.na(get_min_age(island_colonist)))
})
