test_that("plot_sensitivity runs silent for density", {
  sens <- read_sensitivity()
  sens <- sens$sensitivity_dna
  expect_silent(
    plot_sensitivity(sensitivity_data = sens, pairwise_diffs = FALSE)
  )
})

test_that("plot_sensitivity runs silent for pairwise diff scatter", {
  sens <- read_sensitivity()
  sens <- sens$sensitivity_dna
  expect_silent(
    plot_sensitivity(sensitivity_data = sens, pairwise_diffs = TRUE)
  )
})


