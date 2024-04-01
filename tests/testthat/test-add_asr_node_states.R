test_that("add_asr_node_states works for parsimony", {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(5)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c(
    "not_present", "not_present", "endemic", "not_present", "not_present"
  )
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  has_node_island_status <- "island_status" %in% names(phylobase::nodeData(phylod))
  expect_true(has_node_island_status)
})

test_that("add_asr_node_states warns for Mk without rate_model", {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(5)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c(
    "not_present", "not_present", "endemic", "not_present", "not_present"
  )
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  expect_warning(
    add_asr_node_states(phylod = phylod, asr_method = "mk"),
    regexp = "(Mk asr method selected but rate model not supplied)"
  )
})

test_that("add_asr_node_states errors if rate_model given for non-Mk", {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(5)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c(
    "not_present", "not_present", "endemic", "not_present", "not_present"
  )
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  expect_error(
    add_asr_node_states(phylod = phylod, asr_method = "parsimony", rate_model = "ER"),
    regexp = "(rate_method specified by asr_method is not Mk)"
  )
})

test_that("add_asr_node_states works with rate_model given for Mk", {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(5)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c(
    "not_present", "not_present", "endemic", "not_present", "not_present"
  )
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "mk", rate_model = "ARD")
  has_node_island_status <- "island_status" %in% names(phylobase::nodeData(phylod))
  expect_true(has_node_island_status)
})


test_that("add_asr_node_states gives different node states for rate models", {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(5)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c(
    "not_present", "not_present", "endemic", "not_present", "not_present"
  )
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod_er <- add_asr_node_states(phylod = phylod, asr_method = "mk", rate_model = "ER")
  phylod_srd <- add_asr_node_states(phylod = phylod, asr_method = "mk", rate_model = "SRD")
  expect_false(identical(phylod_er, phylod_srd))
})
