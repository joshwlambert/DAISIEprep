test_that("is_back_colonisation works correctly without back-colonisation", {
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
  expect_silent(is_back_col <- is_back_colonisation(
    phylod = phylod,
    node_label = 2
  ))
  expect_false(is_back_col)
})

test_that("is_back_colonisation works correctly with back-colonisation", {
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
  expect_silent(is_back_col <- is_back_colonisation(
    phylod = phylod,
    node_label = 3
  ))
  expect_equal(is_back_col, "8 -> 3")
})

test_that("is_back_colonisation returns FALSE from root", {
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
  expect_silent(is_back_col <- is_back_colonisation(
    phylod = phylod,
    node_label = 6
  ))
  expect_false(is_back_col)
})

test_that("is_back_colonisation works correctly for internal nodes", {
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
  expect_silent(is_back_col <- is_back_colonisation(
    phylod = phylod,
    node_label = 8
  ))
  expect_false(is_back_col)
})
