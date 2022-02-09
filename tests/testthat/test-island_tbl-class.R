test_that("island_tbl class is correct", {
  island_tbl <- island_tbl()
  expect_s4_class(object = island_tbl, class = "island_tbl")
})
