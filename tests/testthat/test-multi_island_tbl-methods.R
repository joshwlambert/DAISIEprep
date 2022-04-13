test_that("Multi_island_tbl summary method works correctly without colonists", {
  multi_island_tbl <- multi_island_tbl()
  expect_output(summary(multi_island_tbl))
})

test_that("Multi_island_tbl summary method works correctly with colonists", {
  multi_island_tbl <- multi_extract_island_species(
    multi_phylod = list(
      create_test_phylod(test_scenario = 1),
      create_test_phylod(test_scenario = 1)),
    extraction_method = "min")
  expect_output(summary(multi_island_tbl))
})
