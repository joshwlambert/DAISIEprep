test_that("2 endemics, 3 species tree, sisters", {
  phylod <- create_test_phylod(test_scenario = 14)
  island_colonist <- extract_endemic_clade(
    phylod = phylod,
    species_label = "bird_a"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_a")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(
    get_branching_times(island_colonist),
    c(1.433370056817, 0.25173)
  )
  expect_true(is.na(get_min_age(island_colonist)))
})


test_that("2 endemics, 4 species tree, sisters", {
  phylod <- create_test_phylod(test_scenario = 15)
  island_colonist <- extract_endemic_clade(
    phylod = phylod,
    species_label = "bird_c"
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_c")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(
    get_branching_times(island_colonist),
    c(0.519744565224, 0.12586)
  )
  expect_true(is.na(get_min_age(island_colonist)))
})
