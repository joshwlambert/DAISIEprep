test_that("island_colonist class is correct", {
  island_colonist <- island_colonist()
  expect_s4_class(object = island_colonist, class = "Island_colonist")
})

test_that("check_island_colonist returns true when class is correct", {
  island_colonist <- island_colonist()
  expect_true(check_island_colonist(object = island_colonist))
})

test_that("check_island_colonist returns character vector when clade_name is not length 1", {
  island_colonist <- island_colonist()
  island_colonist@clade_name <- c("bird_a", "bird_b")
  expect_vector(check_island_colonist(object = island_colonist))
})

test_that("check_island_colonist returns character vector when status is not length 1", {
  island_colonist <- island_colonist()
  island_colonist@status <- c("endemic", "endemic")
  expect_vector(check_island_colonist(object = island_colonist))
})

test_that("check_island_colonist returns character vector when missing_species is not length 1", {
  island_colonist <- island_colonist()
  island_colonist@missing_species <- c(0, 0)
  expect_vector(check_island_colonist(object = island_colonist))
})

test_that("check_island_colonist returns character vector when min_age is not length 1", {
  island_colonist <- island_colonist()
  island_colonist@min_age <- c(1, 1)
  expect_vector(check_island_colonist(object = island_colonist))
})
