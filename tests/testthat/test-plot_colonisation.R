test_that("plot_colonisation runs silent without error with crown age", {
  phylod <- create_test_phylod(test_scenario = 15)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  expect_silent(plot_colonisation(
    island_tbl = island_tbl,
    island_age = 1,
    include_crown_age = TRUE
  ))
})

test_that("plot_colonisation runs silent without error without crown age", {
  phylod <- create_test_phylod(test_scenario = 15)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  expect_silent(plot_colonisation(
    island_tbl = island_tbl,
    island_age = 1,
    include_crown_age = FALSE
  ))
})

test_that("plot_colonisation fails correctly with incorrect island_tbl", {
  phylod <- create_test_phylod(test_scenario = 15)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  expect_error(
    object = plot_colonisation(
    island_tbl = data.frame(),
    island_age = 1,
    include_crown_age = TRUE
  ), regexp = "island_tbl must be an object of class Island_tbl")
})

test_that("plot_colonisation fails correctly with incorrect island_age", {
  phylod <- create_test_phylod(test_scenario = 15)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  expect_error(
    object = plot_colonisation(
      island_tbl = island_tbl,
      island_age = "1",
      include_crown_age = TRUE
    ), regexp = "island_age must be numeric")
})

test_that("plot_colonisation fails correctly with incorrect include_crown_age", {
  phylod <- create_test_phylod(test_scenario = 15)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  expect_error(
    object = plot_colonisation(
      island_tbl = island_tbl,
      island_age = 1,
      include_crown_age = "TRUE"
    ), regexp = "include_crown_age must be either TRUE or FALSE")
})

