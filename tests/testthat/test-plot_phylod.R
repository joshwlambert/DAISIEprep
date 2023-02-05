test_that("plot_phylod runs silent without error", {
  phylod <- create_test_phylod(test_scenario = 1)
  expect_silent(plot_phylod(phylod = phylod, node_pies = FALSE))
})

test_that("plot_phylod runs silent without error", {
  phylod <- create_test_phylod(test_scenario = 2)
  expect_silent(plot_phylod(phylod = phylod, node_pies = FALSE))
})

test_that("plot_phylod runs silent without error", {
  phylod <- create_test_phylod(test_scenario = 1)
  expect_silent(plot_phylod(phylod = phylod, node_pies = TRUE))
})

test_that("plot_phylod runs silent without error", {
  phylod <- create_test_phylod(test_scenario = 2)
  expect_silent(plot_phylod(phylod = phylod, node_pies = TRUE))
})

test_that("plot_phylod fails correctly without node data", {
  phylod <- create_test_phylod(test_scenario = 1)
  phylobase::tdata(phylod) <- data.frame(
    endemicity_status = phylobase::tdata(phylod)[, 1]
  )
  expect_error(
    object = plot_phylod(phylod = phylod, node_pies = TRUE),
    regexp = "To plot probabilities in at the nodes they must be in phylod"
  )
})
