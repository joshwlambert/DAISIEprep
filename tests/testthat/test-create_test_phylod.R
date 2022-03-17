test_that("create_test_phylod produces correct output for scenario 0", {
  phylod <- create_test_phylod(test_scenario = 0)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_false(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 1", {
  phylod <- create_test_phylod(test_scenario = 1)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 2", {
  phylod <- create_test_phylod(test_scenario = 2)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 3", {
  phylod <- create_test_phylod(test_scenario = 3)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 4", {
  phylod <- create_test_phylod(test_scenario = 4)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 5", {
  phylod <- create_test_phylod(test_scenario = 5)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 6", {
  phylod <- create_test_phylod(test_scenario = 6)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 7", {
  phylod <- create_test_phylod(test_scenario = 7)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 8", {
  phylod <- create_test_phylod(test_scenario = 8)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 9", {
  phylod <- create_test_phylod(test_scenario = 9)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 10", {
  phylod <- create_test_phylod(test_scenario = 10)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 11", {
  phylod <- create_test_phylod(test_scenario = 11)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 12", {
  phylod <- create_test_phylod(test_scenario = 12)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 13", {
  phylod <- create_test_phylod(test_scenario = 13)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 14", {
  phylod <- create_test_phylod(test_scenario = 14)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 15", {
  phylod <- create_test_phylod(test_scenario = 15)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})

test_that("create_test_phylod produces correct output for scenario 16", {
  phylod <- create_test_phylod(test_scenario = 16)
  expect_s4_class(phylod, "phylo4d")
  expect_true(phylobase::hasTipData(phylod))
  expect_true(phylobase::hasNodeData(phylod))
})
