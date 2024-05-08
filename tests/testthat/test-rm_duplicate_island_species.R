test_that("rm_duplicate_island_species works as expected with split", {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(6)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                       "bird_f")
  phylo <- add_outgroup(phylo = phylo)
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c(
    "not_present", "endemic", "not_present","nonendemic", rep("endemic", 2),
    "not_present"
  )
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(
    phylod = phylod,
    asr_method = "mk",
    rate_model = matrix(
      data = c(
        0, 1, 0,
        2, 0, 3,
        0, 0, 0
      ),
      nrow = 3,
      byrow = TRUE
    )
  )
  # augment node state of bird a ancestor to not present to reproduce bug
  phylod@data$island_status[11] <- "not_present"
  it <- extract_island_species(phylod, extraction_method = "asr")
  expect_identical(anyDuplicated(unlist(it@island_tbl$species)), 0L)
  expect_identical(nrow(it@island_tbl), 2L)
  expect_identical(it@island_tbl$clade_name, c("bird_a", "bird_c"))
})

test_that("rm_duplicate_island_species works as expected with group", {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(6)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                       "bird_f")
  phylo <- add_outgroup(phylo = phylo)
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c(
    "not_present", "endemic", "not_present","nonendemic", rep("endemic", 2),
    "not_present"
  )
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(
    phylod = phylod,
    asr_method = "mk",
    rate_model = matrix(
      data = c(
        0, 1, 0,
        2, 0, 3,
        0, 0, 0
      ),
      nrow = 3,
      byrow = TRUE
    )
  )
  # augment node state of bird a ancestor to not present to reproduce bug
  phylod@data$island_status[11] <- "not_present"
  it <- extract_island_species(
    phylod,
    extraction_method = "asr",
    nested_asr_species = "group"
  )
  expect_identical(anyDuplicated(unlist(it@island_tbl$species)), 0L)
  expect_identical(nrow(it@island_tbl), 1L)
  expect_identical(it@island_tbl$clade_name, "bird_c")
  expect_identical(
    it@island_tbl$species,
    I(list(c("bird_a", "bird_c", "bird_d", "bird_e")))
  )
})

test_that("rm_duplicate_island_species works for multiple nested clades", {
  set.seed(
    2,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(6)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                       "bird_f")
  phylo <- add_outgroup(phylo = phylo)
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c(
    "not_present", "endemic", "not_present", "endemic", "not_present", "endemic",
    "endemic"
  )
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(
    phylod = phylod,
    asr_method = "mk",
    rate_model = matrix(
      data = c(
        0, 1, 0,
        2, 0, 3,
        0, 0, 0
      ),
      nrow = 3,
      byrow = TRUE
    )
  )
  # augment node state of bird a ancestor to not present to reproduce bug
  phylod@data$island_status[9] <- "nonendemic"
  phylod@data$island_status[10] <- "not_present"
  phylod@data$island_status[11] <- "nonendemic"
  phylod@data$island_status[12] <- "not_present"
  it <- extract_island_species(phylod, extraction_method = "asr")
  expect_identical(anyDuplicated(unlist(it@island_tbl$species)), 0L)
  expect_identical(nrow(it@island_tbl), 3L)
  expect_identical(it@island_tbl$clade_name, c("bird_a", "bird_c", "bird_e"))
})

test_that("rm_duplicate_island_species for multiple nested clades with group", {
  set.seed(
    2,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(6)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                       "bird_f")
  phylo <- add_outgroup(phylo = phylo)
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c(
    "not_present", "endemic", "not_present", "endemic", "not_present", "endemic",
    "endemic"
  )
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(
    phylod = phylod,
    asr_method = "mk",
    rate_model = matrix(
      data = c(
        0, 1, 0,
        2, 0, 3,
        0, 0, 0
      ),
      nrow = 3,
      byrow = TRUE
    )
  )
  # augment node state of bird a ancestor to not present to reproduce bug
  phylod@data$island_status[9] <- "nonendemic"
  phylod@data$island_status[10] <- "not_present"
  phylod@data$island_status[11] <- "nonendemic"
  phylod@data$island_status[12] <- "not_present"
  it <- extract_island_species(
    phylod,
    extraction_method = "asr",
    nested_asr_species = "group"
  )
  expect_identical(anyDuplicated(unlist(it@island_tbl$species)), 0L)
  expect_identical(nrow(it@island_tbl), 1L)
  expect_identical(it@island_tbl$clade_name, "bird_e")
  expect_identical(
    it@island_tbl$species,
    I(list(c("bird_a", "bird_c", "bird_e", "bird_f")))
  )
})

test_that("rm_duplicate_island_species works replacing clade with singleton", {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(6)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                       "bird_f")
  phylo <- add_outgroup(phylo = phylo)
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c(
    "not_present", "endemic", "not_present","not_present", "not_present",
    "not_present", "endemic"
  )
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(
    phylod = phylod,
    asr_method = "mk",
    rate_model = matrix(
      data = c(
        0, 1, 0,
        2, 0, 3,
        0, 0, 0
      ),
      nrow = 3,
      byrow = TRUE
    )
  )
  # augment node state of bird a ancestor to not present to reproduce bug
  phylod@data$island_status[9] <- "nonendemic"
  phylod@data$island_status[11] <- "not_present"
  it <- extract_island_species(phylod, extraction_method = "asr")
  expect_identical(anyDuplicated(unlist(it@island_tbl$species)), 0L)
  expect_identical(nrow(it@island_tbl), 2L)
  expect_identical(it@island_tbl$clade_name, c("bird_a", "bird_f"))
})

test_that("rm_duplicate_island_species works replacing clade with singleton group", {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(6)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                       "bird_f")
  phylo <- add_outgroup(phylo = phylo)
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c(
    "not_present", "endemic", "not_present","not_present", "not_present",
    "not_present", "endemic"
  )
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(
    phylod = phylod,
    asr_method = "mk",
    rate_model = matrix(
      data = c(
        0, 1, 0,
        2, 0, 3,
        0, 0, 0
      ),
      nrow = 3,
      byrow = TRUE
    )
  )
  # augment node state of bird a ancestor to not present to reproduce bug
  phylod@data$island_status[9] <- "nonendemic"
  phylod@data$island_status[11] <- "not_present"
  it <- extract_island_species(phylod, extraction_method = "asr", nested_asr_species = "group")
  expect_identical(anyDuplicated(unlist(it@island_tbl$species)), 0L)
  expect_identical(nrow(it@island_tbl), 1L)
  expect_identical(it@island_tbl$clade_name, "bird_f")
  expect_identical(
    it@island_tbl$species,
    I(list(c("bird_f", "bird_a")))
  )
})
