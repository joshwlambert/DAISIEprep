test_that("island_colonist class is correct", {
  island_col <- island_colonist()
  expect_s4_class(object = island_col, class = "Island_colonist")
})
