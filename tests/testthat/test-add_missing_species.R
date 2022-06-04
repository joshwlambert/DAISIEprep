test_that("add_missing_species works for species on island", {
  missing_species <- data.frame(clade_name = "bird_c", missing_species = 1)
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
  island_tbl <- add_missing_species(island_tbl, missing_species)
  expect_equal(island_tbl@island_tbl$missing_species, 1)
})

test_that("add_missing_species works for species not on island", {
  missing_species <- data.frame(clade_name = "bird_a", missing_species = 1)
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
  island_tbl <- add_missing_species(island_tbl, missing_species)
  expect_equal(island_tbl@island_tbl$missing_species, 0)
})

test_that("add_missing_species works when only genus name is given", {
  missing_species <- data.frame(clade_name = "bird", missing_species = 1)
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
  island_tbl <- add_missing_species(island_tbl, missing_species)
  expect_equal(island_tbl@island_tbl$missing_species, 1)
})

test_that("add_missing_species given warning when genus matches multiple", {
  missing_species <- data.frame(clade_name = "bird", missing_species = 1)
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
    island_tbl,
    missing_species
  ))
  expect_equal(island_tbl@island_tbl$missing_species, c(1, 1))
})

test_that("add_missing_species works for multiple colonists", {
  missing_species <- data.frame(clade_name = "bird_c", missing_species = 1)
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
  island_tbl <- add_missing_species(island_tbl, missing_species)
  expect_equal(island_tbl@island_tbl$missing_species, c(1, 0))
})
