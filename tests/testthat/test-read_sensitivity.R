test_that("read_sensitivity works as expected", {
  sensitivity <- read_sensitivity()
  expect_type(sensitivity, "list")
  expect_length(sensitivity, 2)
  expect_named(sensitivity, c("sensitivity_dna", "sensitivity_complete"))
  expect_identical(dim(sensitivity$sensitivity_dna), c(1500L, 5L))
  expect_identical(dim(sensitivity$sensitivity_complete), c(1500L, 5L))
})

test_that("read_sensitivity fails as expected", {
  expect_error(read_sensitivity("fake_argument"))
})
