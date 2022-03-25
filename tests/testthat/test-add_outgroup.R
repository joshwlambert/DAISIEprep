test_that("add_outgroup adds species correctly", {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(10)
  root_depth <- max(ape::node.depth.edgelength(phylo))
  num_species <- ape::Ntip(phylo)
  outgroup_phylo <- add_outgroup(phylo = phylo)
  outgroup_root_depth <- max(ape::node.depth.edgelength(outgroup_phylo))
  outgroup_num_species <- ape::Ntip(outgroup_phylo)

  expect_equal(outgroup_root_depth, root_depth + 1)
  expect_equal(outgroup_num_species, num_species + 1)
  expect_true(ape::is.ultrametric(outgroup_phylo))
})

test_that("add_outgroup fails correctly", {
  phylo <- list()
  expect_error(
    object = add_outgroup(phylo = phylo),
    regexp = "The phylo object should be a 'phylo' or 'phylo4' object"
  )
})
