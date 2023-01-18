test_that("benchmark works as expected on linear scale", {

  res <- benchmark(
    phylod = NULL,
    tree_size_range = c(10, 100),
    num_points = 3,
    prob_on_island = 0.5,
    prob_endemic = 0.5,
    replicates = 1,
    extraction_method = "min",
    asr_method = NA,
    tie_preference = NA,
    log_scale = FALSE,
    verbose = FALSE
  )

  expect_s3_class(res, "data.frame")
  expect_identical(
    colnames(res),
    c("tree_size", "prob_on_island", "prob_endemic", "extraction_method",
      "asr_method", "tie_preference", "median_time")
  )
  expect_identical(nrow(res), 3L)
  expect_identical(res$tree_size, c(10, 55, 100))
  expect_identical(res$prob_on_island, rep(0.5, 3))
  expect_identical(res$prob_endemic, rep(0.5, 3))
  expect_identical(res$extraction_method, rep("min", 3))
  expect_identical(res$asr_method, rep(NA_character_, 3))
  expect_identical(res$tie_preference, rep(NA_character_, 3))
  expect_equal(
    res$median_time,
    c(1.500000e-11, 7.133333e-11, 1.753333e-10),
    tolerance = 1e-5
  )
})

test_that("benchmark works as expected on log scale", {

  res <- benchmark(
    phylod = NULL,
    tree_size_range = c(10, 100),
    num_points = 3,
    prob_on_island = 0.5,
    prob_endemic = 0.5,
    replicates = 1,
    extraction_method = "min",
    asr_method = NA,
    tie_preference = "island",
    log_scale = TRUE,
    verbose = FALSE
  )

  expect_s3_class(res, "data.frame")
  expect_identical(
    colnames(res),
    c("tree_size", "prob_on_island", "prob_endemic", "extraction_method",
      "asr_method", "tie_preference", "median_time")
  )
  expect_identical(nrow(res), 3L)
  expect_identical(res$tree_size, c(10, 32, 100))
  expect_identical(res$prob_on_island, rep(0.5, 3))
  expect_identical(res$prob_endemic, rep(0.5, 3))
  expect_identical(res$extraction_method, rep("min", 3))
  expect_identical(res$asr_method, rep(NA_character_, 3))
  expect_identical(res$tie_preference, rep(NA_character_, 3))
  expect_equal(
    res$median_time,
    c(1.066667e-11, 4.233333e-11, 1.316667e-10),
    tolerance = 1e-5
  )
})

test_that("benchmark works as expected for multiple extraction methods", {

  # suppress warning for root of the phylogeny is on the island for asr
  res <- suppressWarnings(
    benchmark(
      phylod = NULL,
      tree_size_range = c(10, 100),
      num_points = 3,
      prob_on_island = 0.5,
      prob_endemic = 0.5,
      replicates = 1,
      extraction_method = c("min", "asr"),
      asr_method = c("parsimony", "mk"),
      tie_preference = "island",
      log_scale = TRUE,
      verbose = FALSE
    )
  )

  expect_s3_class(res, "data.frame")
  expect_identical(
    colnames(res),
    c("tree_size", "prob_on_island", "prob_endemic", "extraction_method",
      "asr_method", "tie_preference", "median_time")
  )
  expect_identical(nrow(res), 9L)
  expect_identical(res$tree_size, rep(c(10, 32, 100), 3))
  expect_identical(res$prob_on_island, rep(0.5, 9))
  expect_identical(res$prob_endemic, rep(0.5, 9))
  expect_identical(res$extraction_method, c(rep("min", 3), rep("asr", 6)))
  expect_identical(
    res$asr_method,
    c(rep(NA, 3), rep("parsimony", 3), rep("mk", 3))
  )
  expect_identical(res$tie_preference, c(rep(NA, 3), rep("island", 6)))
  expect_equal(
    res$median_time,
    c(2.100000e-11, 4.833333e-11, 1.480000e-10, 1.100000e-11, 3.200000e-11,
      3.533333e-11, 1.766667e-11, 4.633333e-11, 1.906667e-10),
    tolerance = 1e-5
  )
})
