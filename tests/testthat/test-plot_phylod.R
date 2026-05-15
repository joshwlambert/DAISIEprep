test_that("plot_phylod runs silent without error", {
  skip("Temporary skip while fixing issue on R devel")
  phylod <- create_test_phylod(test_scenario = 1)
  # warning due to ggtree since ggplot2 v4.0.0 see
  # https://github.com/YuLab-SMU/ggtree/issues/656
  suppressWarnings(expect_warning(
    tree <- plot_phylod(phylod = phylod, node_pies = FALSE),
    regexp = "Arguments in `...` must be used.",
  ))
  expect_s3_class(tree, class = "ggtree")
})

test_that("plot_phylod runs silent without error", {
  skip("Temporary skip while fixing issue on R devel")
  phylod <- create_test_phylod(test_scenario = 2)
  # warning due to ggtree since ggplot2 v4.0.0 see
  # https://github.com/YuLab-SMU/ggtree/issues/656
  suppressWarnings(expect_warning(
    tree <- plot_phylod(phylod = phylod, node_pies = FALSE),
    regexp = "Arguments in `...` must be used.",
  ))
  expect_s3_class(tree, class = "ggtree")
})

test_that("plot_phylod runs silent without error", {
  skip("Temporary skip while fixing issue on R devel")
  phylod <- create_test_phylod(test_scenario = 1)
  # warning due to ggtree since ggplot2 v4.0.0 see
  # https://github.com/YuLab-SMU/ggtree/issues/656
  suppressWarnings(expect_warning(
    tree <- plot_phylod(phylod = phylod, node_pies = TRUE),
    regexp = "Arguments in `...` must be used.",
  ))
  expect_s3_class(tree, class = "ggtree")
})

test_that("plot_phylod runs silent without error", {
  skip("Temporary skip while fixing issue on R devel")
  phylod <- create_test_phylod(test_scenario = 2)
  # warning due to ggtree since ggplot2 v4.0.0 see
  # https://github.com/YuLab-SMU/ggtree/issues/656
  suppressWarnings(expect_warning(
    tree <- plot_phylod(phylod = phylod, node_pies = TRUE),
    regexp = "Arguments in `...` must be used.",
  ))
  expect_s3_class(tree, class = "ggtree")
})

test_that("plot_phylod fails correctly without node data", {
  skip("Temporary skip while fixing issue on R devel")
  phylod <- create_test_phylod(test_scenario = 1)
  phylobase::tdata(phylod) <- data.frame(
    endemicity_status = phylobase::tdata(phylod)[, 1]
  )
  expect_error(
    object = plot_phylod(phylod = phylod, node_pies = TRUE),
    regexp = "To plot probabilities in at the nodes they must be in phylod"
  )
})
