test_that("1 nonendemic, different colonist", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_colonist <- extract_nonendemic(
    phylod = phylod,
    species_label = "bird_b"
  )
  island_tbl <- island_tbl()
  island_colonist_df <- data.frame(
    clade_name = "bird_z",
    status = "nonendemic",
    missing_species = 0,
    branching_times = I(list(0.5)),
    min_age = NA
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  expect_false(
    is_duplicate_colonist(
      island_colonist = island_colonist,
      island_tbl = island_tbl
    )
  )
})

test_that("1 endemic, different colonist", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_colonist <- extract_endemic_singleton(
    phylod = phylod,
    species_label = "bird_b"
  )
  island_tbl <- island_tbl()
  island_colonist_df <- data.frame(
    clade_name = "bird_z",
    status = "nonendemic",
    missing_species = 0,
    branching_times = I(list(0.5)),
    min_age = NA
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  expect_false(
    is_duplicate_colonist(
      island_colonist = island_colonist,
      island_tbl = island_tbl
    )
  )
})

test_that("2 endemics, different colonist", {
  phylod <- create_test_phylod(test_scenario = 14)
  island_colonist <- extract_endemic_clade(
    phylod = phylod,
    species_label = "bird_a",
    unique_clade_name = TRUE
  )
  island_tbl <- island_tbl()
  island_colonist_df <- data.frame(
    clade_name = "bird_z",
    status = "nonendemic",
    missing_species = 0,
    branching_times = I(list(0.5)),
    min_age = NA
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  expect_false(
    is_duplicate_colonist(
      island_colonist = island_colonist,
      island_tbl = island_tbl
    )
  )
})

test_that("2 tips nonendemic, different colonist", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("nonendemic", "nonendemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_colonist <- extract_multi_tip_species(
    phylod = phylod,
    species_label = "bird_a_1",
    species_endemicity = "nonendemic"
  )
  island_tbl <- island_tbl()
  island_colonist_df <- data.frame(
    clade_name = "bird_z",
    status = "nonendemic",
    missing_species = 0,
    branching_times = I(list(0.5)),
    min_age = NA
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  expect_false(
    is_duplicate_colonist(
      island_colonist = island_colonist,
      island_tbl = island_tbl
    )
  )
})

test_that("2 tips endemic, different colonist", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_colonist <- extract_multi_tip_species(
    phylod = phylod,
    species_label = "bird_a_1",
    species_endemicity = "endemic"
  )
  island_tbl <- island_tbl()
  island_colonist_df <- data.frame(
    clade_name = "bird_z",
    status = "nonendemic",
    missing_species = 0,
    branching_times = I(list(0.5)),
    min_age = NA
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  expect_false(
    is_duplicate_colonist(
      island_colonist = island_colonist,
      island_tbl = island_tbl
    )
  )
})

test_that("1 nonendemic, same colonist", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_colonist <- extract_nonendemic(
    phylod = phylod,
    species_label = "bird_b"
  )
  island_tbl <- island_tbl()
  island_colonist_df <- data.frame(
    clade_name = "bird_b",
    status = "nonendemic",
    missing_species = 0,
    branching_times = I(list(0.755181833128)),
    min_age = NA
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  expect_true(
    is_duplicate_colonist(
      island_colonist = island_colonist,
      island_tbl = island_tbl
    )
  )
})

test_that("1 endemic, same colonist", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_colonist <- extract_endemic_singleton(
    phylod = phylod,
    species_label = "bird_b"
  )
  island_tbl <- island_tbl()
  island_colonist_df <- data.frame(
    clade_name = "bird_b",
    status = "endemic",
    missing_species = 0,
    branching_times = I(list(0.755181833128 )),
    min_age = NA
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  expect_true(
    is_duplicate_colonist(
      island_colonist = island_colonist,
      island_tbl = island_tbl
    )
  )
})

test_that("2 endemics, same colonist", {
  phylod <- create_test_phylod(test_scenario = 14)
  island_colonist <- extract_endemic_clade(
    phylod = phylod,
    species_label = "bird_a",
    unique_clade_name = TRUE
  )
  island_tbl <- island_tbl()
  island_colonist_df <- data.frame(
    clade_name = "bird_a",
    status = "endemic",
    missing_species = 0,
    branching_times = I(list(c(1.43337005682, 0.25173))),
    min_age = NA
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  expect_true(
    is_duplicate_colonist(
      island_colonist = island_colonist,
      island_tbl = island_tbl
    )
  )
})

test_that("2 tips nonendemic, same colonist", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("nonendemic", "nonendemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_colonist <- extract_multi_tip_species(
    phylod = phylod,
    species_label = "bird_a_1",
    species_endemicity = "nonendemic"
  )
  island_tbl <- island_tbl()
  island_colonist_df <- data.frame(
    clade_name = "bird_a",
    status = "nonendemic",
    missing_species = 0,
    branching_times = I(list(1.43337005682)),
    min_age = 0.251727277709
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  expect_true(
    is_duplicate_colonist(
      island_colonist = island_colonist,
      island_tbl = island_tbl
    )
  )
})

test_that("2 tips endemic, same colonist", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_colonist <- extract_multi_tip_species(
    phylod = phylod,
    species_label = "bird_a_1",
    species_endemicity = "endemic"
  )
  island_tbl <- island_tbl()
  island_colonist_df <- data.frame(
    clade_name = "bird_a",
    status = "endemic",
    missing_species = 0,
    branching_times = I(list(1.43337005682)),
    min_age = 0.251727277709
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  expect_true(
    is_duplicate_colonist(
      island_colonist = island_colonist,
      island_tbl = island_tbl
    )
  )
})
