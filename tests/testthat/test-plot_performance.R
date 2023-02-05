test_that("plot_performance runs silent with one parameter setting", {
  performance <- benchmark(
    phylod = NULL,
    tree_size_range = c(10, 100),
    num_points = 3,
    prob_on_island = 0.5,
    prob_endemic = 0.5,
    replicates = 1,
    extraction_method = "min",
    asr_method = NA,
    tie_preference = NA,
    log_scale = FALSE
  )
  expect_silent(
    plot_performance(
      performance_data = performance,
      group_by = prob_on_island
    )
  )
})

test_that("plot_performance runs silent with two parameter settings", {
  performance <- benchmark(
    phylod = NULL,
    tree_size_range = c(10, 100),
    num_points = 3,
    prob_on_island = c(0.4, 0.6),
    prob_endemic = 0.5,
    replicates = 1,
    extraction_method = "min",
    asr_method = NA,
    tie_preference = NA,
    log_scale = FALSE
  )
  expect_silent(
    plot_performance(
      performance_data = performance,
      group_by = prob_on_island
    )
  )
})

test_that("plot_performance runs silent with multiple parameter settings", {
  performance <- benchmark(
    phylod = NULL,
    tree_size_range = c(10, 100),
    num_points = 3,
    prob_on_island = c(0.4, 0.6),
    prob_endemic = c(0.4, 0.6),
    replicates = 1,
    extraction_method = "min",
    asr_method = NA,
    tie_preference = NA,
    log_scale = FALSE
  )
  expect_silent(
    plot_performance(
      performance_data = performance,
      group_by = prob_endemic
    )
  )
})
