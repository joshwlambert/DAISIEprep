test_that("1 endemic, 2 species tree", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_colonist <- extract_endemic_singleton(
    phylod = phylod,
    species_label = "bird_b"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_b")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_col_time(island_colonist), 0.755181833128)
  expect_true(is.na(get_branching_times(island_colonist)))
  expect_true(is.na(get_min_age(island_colonist)))
  expect_equal(get_species(island_colonist), "bird_b")
  expect_equal(get_clade_type(island_colonist), 1)
})

test_that("1 endemic, 3 species tree, outgroup", {
  phylod <- create_test_phylod(test_scenario = 7)
  island_colonist <- extract_endemic_singleton(
    phylod = phylod,
    species_label = "bird_c"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_c")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_col_time(island_colonist), 1.43337005682)
  expect_true(is.na(get_branching_times(island_colonist)))
  expect_true(is.na(get_min_age(island_colonist)))
  expect_equal(get_species(island_colonist), "bird_c")
  expect_equal(get_clade_type(island_colonist), 1)
})

test_that("1 endemic, 3 species tree, non-outgroup", {
  phylod <- create_test_phylod(test_scenario = 8)
  island_colonist <- extract_endemic_singleton(
    phylod = phylod,
    species_label = "bird_b"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_b")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_col_time(island_colonist), 0.251727277709)
  expect_false(get_col_max_age(island_colonist))
  expect_true(is.na(get_branching_times(island_colonist)))
  expect_true(is.na(get_min_age(island_colonist)))
  expect_equal(get_species(island_colonist), "bird_b")
  expect_equal(get_clade_type(island_colonist), 1)
})

test_that("1 endemic, 4 species tree, outgroup", {
  phylod <- create_test_phylod(test_scenario = 9)
  island_colonist <- extract_endemic_singleton(
    phylod = phylod,
    species_label = "bird_a"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_a")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_col_time(island_colonist), 0.665451291928)
  expect_false(get_col_max_age(island_colonist))
  expect_true(is.na(get_branching_times(island_colonist)))
  expect_true(is.na(get_min_age(island_colonist)))
  expect_equal(get_species(island_colonist), "bird_a")
  expect_equal(get_clade_type(island_colonist), 1)
})

test_that("1 endemic, 4 species tree, non-outgroup", {
  phylod <- create_test_phylod(test_scenario = 10)
  island_colonist <- extract_endemic_singleton(
    phylod = phylod,
    species_label = "bird_b"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_b")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_col_time(island_colonist), 0.519744565224)
  expect_false(get_col_max_age(island_colonist))
  expect_true(is.na(get_branching_times(island_colonist)))
  expect_true(is.na(get_min_age(island_colonist)))
  expect_equal(get_species(island_colonist), "bird_b")
  expect_equal(get_clade_type(island_colonist), 1)
})

test_that("2 endemics, 3 species tree, sisters", {
  phylod <- create_test_phylod(test_scenario = 14)
  island_colonist <- extract_endemic_singleton(
    phylod = phylod,
    species_label = "bird_a"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_a")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_col_time(island_colonist), 0.251727277709)
  expect_false(get_col_max_age(island_colonist))
  expect_true(is.na(get_branching_times(island_colonist)))
  expect_true(is.na(get_min_age(island_colonist)))
  expect_equal(get_species(island_colonist), "bird_a")
  expect_equal(get_clade_type(island_colonist), 1)
})

test_that("2 endemics, 4 species tree, sister", {
  phylod <- create_test_phylod(test_scenario = 15)
  island_colonist <- extract_endemic_singleton(
    phylod = phylod,
    species_label = "bird_c"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_c")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_col_time(island_colonist), 0.125863638855)
  expect_false(get_col_max_age(island_colonist))
  expect_true(is.na(get_branching_times(island_colonist)))
  expect_true(is.na(get_min_age(island_colonist)))
  expect_equal(get_species(island_colonist), "bird_c")
  expect_equal(get_clade_type(island_colonist), 1)
})

test_that("2 endemics, 4 species tree, non-sisters", {
  phylod <- create_test_phylod(test_scenario = 16)
  island_colonist <- extract_endemic_singleton(
    phylod = phylod,
    species_label = "bird_b"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_b")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_col_time(island_colonist), 0.519744565224)
  expect_false(get_col_max_age(island_colonist))
  expect_true(is.na(get_branching_times(island_colonist)))
  expect_true(is.na(get_min_age(island_colonist)))
  expect_equal(get_species(island_colonist), "bird_b")
  expect_equal(get_clade_type(island_colonist), 1)
})
