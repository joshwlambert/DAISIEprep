test_that("read_performance works as expected", {
  performance <- read_performance()
  expect_type(performance, "list")
  expect_length(performance, 2)
  expect_named(performance, c("performance_data_min", "performance_data_asr"))
  expect_identical(dim(performance$performance_data_min), c(260L, 8L))
  expect_identical(dim(performance$performance_data_asr), c(260L, 8L))
})

test_that("read_performance fails as expected", {
  expect_error(read_performance("fake_argument"))
})
