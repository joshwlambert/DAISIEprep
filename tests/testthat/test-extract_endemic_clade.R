test_that("2 endemics, 3 species tree, sisters", {
  phylod <- create_test_phylod(test_scenario = 14)
  island_colonist <- extract_endemic_clade(
    phylod = phylod,
    species_label = "bird_a",
    unique_clade_name = TRUE
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_a")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_col_time(island_colonist), 1.433370056817)
  expect_false(get_col_max_age(island_colonist))
  expect_equal(get_branching_times(island_colonist), 0.25173)
  expect_true(is.na(get_min_age(island_colonist)))
  expect_equal(
    get_species(island_colonist),
    c("bird_a", "bird_b")
  )
  expect_equal(get_clade_type(island_colonist), 1)
})

test_that("2 endemics, 4 species tree, sisters", {
  phylod <- create_test_phylod(test_scenario = 15)
  island_colonist <- extract_endemic_clade(
    phylod = phylod,
    species_label = "bird_c",
    unique_clade_name = TRUE
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_c")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(get_col_time(island_colonist), 0.519744565224)
  expect_false(get_col_max_age(island_colonist))
  expect_equal(get_branching_times(island_colonist), 0.12586)
  expect_true(is.na(get_min_age(island_colonist)))
  expect_equal(
    get_species(island_colonist),
    c("bird_c", "bird_d")
  )
  expect_equal(get_clade_type(island_colonist), 1)
})
