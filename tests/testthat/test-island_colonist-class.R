test_that("island_colonist class is correct", {
  island_tbl <- methods::new("island_colonist")
  expect_s4_class(object = island_tbl, class = "island_colonist")
})
