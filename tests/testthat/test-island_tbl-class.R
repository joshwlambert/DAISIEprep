test_that("island_tbl class is correct", {
  island_tbl <- island_tbl()
  expect_s4_class(object = island_tbl, class = "Island_tbl")
})

test_that("check_island_tbl returns true when class is correct", {
  island_tbl <- island_tbl()
  expect_true(check_island_tbl(object = island_tbl))
})

test_that("check_island_tbl returns character vector when class does not have 5 cols", {
  island_tbl <- island_tbl()
  island_tbl@island_tbl <- data.frame(
    clade_name = character(),
    status = character(),
    missing_species = numeric(),
    branching_times = numeric()
  )
  expect_vector(check_island_tbl(object = island_tbl))
})

test_that("check_island_tbl returns character vector when class does not have correct col names", {
  island_tbl <- island_tbl()
  island_tbl@island_tbl <- data.frame(
    Clade_name = character(),
    status = character(),
    missing_species = numeric(),
    branching_times = numeric(),
    min_age = numeric()
  )
  expect_vector(check_island_tbl(object = island_tbl))
})

test_that("check_island_tbl returns character vector when class does not have correct metadata", {
  island_tbl <- island_tbl()
  island_tbl@metadata <- list()
  expect_vector(check_island_tbl(object = island_tbl))
})
