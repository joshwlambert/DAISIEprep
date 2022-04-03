test_that("Multi_island_tbl class is correct", {
  multi_island_tbl <- multi_island_tbl()
  expect_s4_class(
    object = multi_island_tbl,
    class = "Multi_island_tbl"
  )
})

test_that("check_multi_island_tbl returns true when class is correct", {
  multi_island_tbl <- multi_island_tbl()
  expect_true(check_multi_island_tbl(object = multi_island_tbl))
})

test_that("check_multi_island_tbl returns error when class does not contain island_tbl", {
  multi_island_tbl <- multi_island_tbl()
  multi_island_tbl[[1]] <- data.frame()
  expect_error(check_multi_island_tbl(object = multi_island_tbl))
})
