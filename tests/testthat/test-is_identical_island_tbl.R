test_that("is_identical_island_tbl works correctly for identical tbls", {
  multi_island_tbl <- multi_extract_island_species(
    multi_phylod = list(
      create_test_phylod(test_scenario = 1),
      create_test_phylod(test_scenario = 1)),
   extraction_method = "min")
  expect_true(
    is_identical_island_tbl(
      multi_island_tbl[[1]],
      multi_island_tbl[[2]]
    )
  )
})

test_that("is_identical_island_tbl works correctly for non-identical tbls", {
  multi_island_tbl <- multi_extract_island_species(
    multi_phylod = list(
      create_test_phylod(test_scenario = 1),
      create_test_phylod(test_scenario = 11)),
    extraction_method = "min")
  expect_vector(
    is_identical_island_tbl(
      multi_island_tbl[[1]],
      multi_island_tbl[[2]]
    )
  )
})
