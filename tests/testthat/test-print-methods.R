test_that("Island_colonist print method works correctly", {
  island_colonist <- island_colonist()
  expect_output(print(island_colonist))
})

test_that("Island_tbl print method works correctly", {
  island_tbl <- island_tbl()
  expect_output(print(island_tbl))
})

test_that("Multi_island_tbl print method works correctly", {
  multi_island_tbl <- multi_island_tbl()
  expect_output(print(multi_island_tbl))
})

test_that("Island_colonist show method works correctly", {
  island_colonist <- island_colonist()
  expect_output(show(island_colonist))
})

test_that("Island_tbl show method works correctly", {
  island_tbl <- island_tbl()
  expect_output(show(island_tbl))
})

test_that("Multi_island_tbl show method works correctly", {
  multi_island_tbl <- multi_island_tbl()
  expect_output(show(multi_island_tbl))
})

