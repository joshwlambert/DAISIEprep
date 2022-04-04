test_that("any_back_colonisation works correctly without back-colonisation", {
  set.seed(
    3,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(5)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "endemic", "not_present",
                         "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  expect_silent(any_back_col <- any_back_colonisation(
    phylod = phylod,
    only_tips = FALSE
  ))
  expect_equal(
    any_back_col,
    "No back-colonisation events found in the phylogeny"
  )
})

test_that("any_back_colonisation only tips works correctly without back-colonisation", {
  set.seed(
    3,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(5)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "endemic", "not_present",
                         "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  expect_silent(any_back_col <- any_back_colonisation(
    phylod = phylod,
    only_tips = TRUE
  ))
  expect_equal(
    any_back_col,
    "No back-colonisation events found in the phylogeny"
  )
})

test_that("any_back_colonisation works correctly with back-colonisation", {
  set.seed(
    3,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(5)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "endemic", "not_present",
                         "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  # aritificially modify data to produce back-colonisation
  phylobase::tdata(phylod)$island_status[8] <- "endemic"
  expect_silent(any_back_col <- any_back_colonisation(
    phylod = phylod,
    only_tips = FALSE
  ))
  expect_equal(any_back_col, "8 -> 3")
})

test_that("any_back_colonisation only tips works correctly with back-colonisation", {
  set.seed(
    3,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(5)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "endemic", "not_present",
                         "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  # aritificially modify data to produce back-colonisation
  phylobase::tdata(phylod)$island_status[8] <- "endemic"
  expect_silent(any_back_col <- any_back_colonisation(
    phylod = phylod,
    only_tips = TRUE
  ))
  expect_equal(any_back_col, "8 -> 3")
})

test_that("any_back_colonisation fails correctly", {
  set.seed(
    3,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(5)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "endemic", "not_present",
                         "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  expect_error(
    object = any_back_colonisation(
    phylod = phylod,
    only_tips = FALSE
  ),
  regexp = "This function requires ancestral state reconstruction data of the
         island presence at the nodes"
  )
})
