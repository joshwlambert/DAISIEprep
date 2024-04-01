test_that("add_missing_species works for species on island", {
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
  island_tbl <- extract_island_species(phylod, extraction_method = "min")
  island_tbl <- add_missing_species(
    island_tbl = island_tbl,
    num_missing_species =  1,
    species_to_add_to = "bird_c"
  )
  expect_equal(island_tbl@island_tbl$missing_species, 1)
})

test_that("add_missing_species errors for species not on island", {
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
  island_tbl <- extract_island_species(phylod, extraction_method = "min")
  expect_error(
    add_missing_species(
      island_tbl = island_tbl,
      num_missing_species = 1,
      species_to_add_to = "bird_a"
    ),
    regexp = "(You are adding species)*(However, in species_to_add_to)"
  )
})

test_that("add_missing_species works when only genus name is given", {
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
  island_tbl <- extract_island_species(phylod, extraction_method = "min")
  island_tbl <- add_missing_species(
    island_tbl = island_tbl,
    num_missing_species = 1,
    species_to_add_to = "bird"
  )
  expect_equal(island_tbl@island_tbl$missing_species, 1)
})

test_that("add_missing_species given warning when genus matches multiple", {
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
    "not_present", "not_present", "endemic", "not_present", "endemic"
  )
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_tbl <- extract_island_species(phylod, extraction_method = "min")
  expect_warning(island_tbl <- add_missing_species(
    island_tbl = island_tbl,
    num_missing_species = 1,
    species_to_add_to = "bird"
  ))
  expect_equal(island_tbl@island_tbl$missing_species, c(1, 1))
})

test_that("add_missing_species works for multiple colonists", {
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
    "not_present", "not_present", "endemic", "not_present", "endemic"
  )
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_tbl <- extract_island_species(phylod, extraction_method = "min")
  island_tbl <- add_missing_species(
    island_tbl = island_tbl,
    num_missing_species = 1,
    species_to_add_to = "bird_c"
  )
  expect_equal(island_tbl@island_tbl$missing_species, c(1, 0))
})
