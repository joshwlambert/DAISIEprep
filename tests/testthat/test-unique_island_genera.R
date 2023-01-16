test_that("unique_island_genera works for endemics", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  phylod <- create_test_phylod(test_scenario = 7)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
    island_tbl = island_tbl
  ))
  unique_genera <- unique_island_genera(island_tbl = island_tbl)

  expect_true(is.list(unique_genera))
  expect_length(unique_genera, 2)
  expect_equal(unique_genera[[1]], "bird")
  expect_equal(unique_genera[[2]], character(0))
})

test_that("unique_island_genera works for nonendemics", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  phylod <- create_test_phylod(test_scenario = 2)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
    island_tbl = island_tbl
  ))
  unique_genera <- unique_island_genera(island_tbl = island_tbl)

  expect_true(is.list(unique_genera))
  expect_length(unique_genera, 2)
  expect_equal(unique_genera[[1]], NA_character_)
  expect_equal(unique_genera[[2]], character(0))
})

test_that("unique_island_genera works for endemic and nonendemic", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  phylod <- create_test_phylod(test_scenario = 2)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
    island_tbl = island_tbl
  ))
  unique_genera <- unique_island_genera(island_tbl = island_tbl)

  expect_true(is.list(unique_genera))
  expect_length(unique_genera, 2)
  expect_equal(unique_genera[[1]], "bird")
  expect_equal(unique_genera[[2]], NA_character_)
})

test_that("unique_island_genera works for nonendemic and endemic", {
  phylod <- create_test_phylod(test_scenario = 2)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
    island_tbl = island_tbl
  ))
  unique_genera <- unique_island_genera(island_tbl = island_tbl)

  expect_true(is.list(unique_genera))
  expect_length(unique_genera, 2)
  expect_equal(unique_genera[[1]], NA_character_)
  expect_equal(unique_genera[[2]], "bird")
})
