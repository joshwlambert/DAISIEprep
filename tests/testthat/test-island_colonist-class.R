test_that("island_colonist class is correct", {
  island_tbl <- island_colonist()
  expect_s4_class(object = island_tbl, class = "island_colonist")
})
