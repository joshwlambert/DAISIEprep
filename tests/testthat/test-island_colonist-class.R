test_that("island_colonist class is correct", {
  island_colonist <- island_colonist()
  expect_s4_class(object = island_colonist, class = "Island_colonist")
})
