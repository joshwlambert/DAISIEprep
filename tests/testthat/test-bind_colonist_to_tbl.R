test_that("1 nonendemic, empty tbl", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_colonist <- extract_nonendemic(
    phylod = phylod,
    species_label = "bird_b"
  )
  island_tbl <- bind_colonist_to_tbl(
    island_colonist = island_colonist,
    island_tbl = island_tbl()
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "nonendemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(get_island_tbl(island_tbl)$col_time, 0.755181833128)
  expect_false(get_island_tbl(island_tbl)$col_max_age, FALSE)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(NA_real_))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
  expect_equal(get_island_tbl(island_tbl)$species, I(list("bird_b")))
  expect_equal(get_island_tbl(island_tbl)$clade_type, 1)
})

test_that("1 endemic, empty tbl", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_colonist <- extract_endemic_singleton(
    phylod = phylod,
    species_label = "bird_b"
  )
  island_tbl <- bind_colonist_to_tbl(
    island_colonist = island_colonist,
    island_tbl = island_tbl()
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(get_island_tbl(island_tbl)$col_time, 0.755181833128)
  expect_false(get_island_tbl(island_tbl)$col_max_age)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(NA_real_)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
  expect_equal(get_island_tbl(island_tbl)$species, I(list("bird_b")))
  expect_equal(get_island_tbl(island_tbl)$clade_type, 1)
})

test_that("2 endemics, empty tbl", {
  phylod <- create_test_phylod(test_scenario = 14)
  island_colonist <- extract_endemic_clade(
    phylod = phylod,
    species_label = "bird_a",
    unique_clade_name = TRUE
  )
  island_tbl <- bind_colonist_to_tbl(
    island_colonist = island_colonist,
    island_tbl = island_tbl()
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_a")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(get_island_tbl(island_tbl)$col_time, 1.433370056817)
  expect_false(get_island_tbl(island_tbl)$col_max_age)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(0.251727277709))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
  expect_equal(
    get_island_tbl(island_tbl)$species,
    I(list(c("bird_a", "bird_b")))
  )
  expect_equal(get_island_tbl(island_tbl)$clade_type, 1)
})

test_that("2 tips nonendemic, empty tbl", {
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
  island_tbl <- bind_colonist_to_tbl(
    island_colonist = island_colonist,
    island_tbl = island_tbl()
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_a")
  expect_equal(get_island_tbl(island_tbl)$status, "nonendemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(get_island_tbl(island_tbl)$col_time, 1.43337005682)
  expect_true(get_island_tbl(island_tbl)$col_max_age)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(NA_real_))
  )
  expect_equal(get_island_tbl(island_tbl)$min_age, 0.251727277709)
  expect_equal(
    get_island_tbl(island_tbl)$species,
    I(list(c("bird_a_1", "bird_a_2")))
  )
  expect_equal(get_island_tbl(island_tbl)$clade_type, 1)
})

test_that("2 tips endemic, empty_tbl", {
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
  island_tbl <- bind_colonist_to_tbl(
    island_colonist = island_colonist,
    island_tbl = island_tbl()
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_a")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(get_island_tbl(island_tbl)$col_time, 1.43337005682)
  expect_true(get_island_tbl(island_tbl)$col_max_age)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(NA_real_))
  )
  expect_equal(get_island_tbl(island_tbl)$min_age, 0.251727277709)
  expect_equal(
    get_island_tbl(island_tbl)$species,
    I(list(c("bird_a_1", "bird_a_2")))
  )
  expect_equal(get_island_tbl(island_tbl)$clade_type, 1)
})

test_that("1 nonendemic, non-empty tbl", {
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
    col_time = 0.5,
    col_max_age = FALSE,
    branching_times = I(list(NA_real_)),
    min_age = NA_real_,
    species = I(list("bird_z")),
    clade_type = 1
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  island_tbl <- bind_colonist_to_tbl(
    island_colonist = island_colonist,
    island_tbl = island_tbl
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, c("bird_z", "bird_b"))
  expect_equal(get_island_tbl(island_tbl)$status, c("nonendemic", "nonendemic"))
  expect_equal(get_island_tbl(island_tbl)$missing_species, c(0, 0))
  expect_equal(get_island_tbl(island_tbl)$col_time, c(0.5, 0.755181833128))
  expect_equal(get_island_tbl(island_tbl)$col_max_age, c(FALSE, FALSE))
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(NA_real_, NA_real_))
  )
  expect_equal(get_island_tbl(island_tbl)$min_age, c(NA_real_, NA_real_))
  expect_equal(get_island_tbl(island_tbl)$species, I(list("bird_z", "bird_b")))
  expect_equal(get_island_tbl(island_tbl)$clade_type, c(1, 1))
})

test_that("1 endemic, non-empty tbl", {
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
    col_time = 0.5,
    col_max_age = FALSE,
    branching_times = I(list(NA_real_)),
    min_age = NA_real_,
    species = I(list("bird_z")),
    clade_type = 1
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  island_tbl <- bind_colonist_to_tbl(
    island_colonist = island_colonist,
    island_tbl = island_tbl
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, c("bird_z", "bird_b"))
  expect_equal(get_island_tbl(island_tbl)$status, c("nonendemic", "endemic"))
  expect_equal(get_island_tbl(island_tbl)$missing_species, c(0, 0))
  expect_equal(get_island_tbl(island_tbl)$col_time, c(0.5, 0.755181833128))
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(NA_real_, NA_real_))
  )
  expect_equal(get_island_tbl(island_tbl)$min_age, c(NA_real_, NA_real_))
  expect_equal(get_island_tbl(island_tbl)$species, I(list("bird_z", "bird_b")))
  expect_equal(get_island_tbl(island_tbl)$clade_type, c(1, 1))
})

test_that("2 endemics, empty tbl", {
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
    col_time = 0.5,
    col_max_age = FALSE,
    branching_times = I(list(NA_real_)),
    min_age = NA_real_,
    species = I(list("bird_z")),
    clade_type = 1
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  island_tbl <- bind_colonist_to_tbl(
    island_colonist = island_colonist,
    island_tbl = island_tbl
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, c("bird_z", "bird_a"))
  expect_equal(get_island_tbl(island_tbl)$status, c("nonendemic", "endemic"))
  expect_equal(get_island_tbl(island_tbl)$missing_species, c(0, 0))
  expect_equal(get_island_tbl(island_tbl)$col_time, c(0.5, 1.433370056817))
  expect_equal(get_island_tbl(island_tbl)$col_max_age, c(FALSE, FALSE))
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(NA_real_, 0.251727277709))
  )
  expect_equal(get_island_tbl(island_tbl)$min_age, c(NA_real_, NA_real_))
  expect_equal(
    get_island_tbl(island_tbl)$species,
    I(list("bird_z", c("bird_a", "bird_b")))
  )
  expect_equal(get_island_tbl(island_tbl)$clade_type, c(1, 1))
})

test_that("2 tips nonendemic, empty tbl", {
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
    col_time = 0.5,
    col_max_age = FALSE,
    branching_times = I(list(NA_real_)),
    min_age = NA_real_,
    species = I(list("bird_z")),
    clade_type = 1
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  island_tbl <- bind_colonist_to_tbl(
    island_colonist = island_colonist,
    island_tbl = island_tbl
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, c("bird_z", "bird_a"))
  expect_equal(get_island_tbl(island_tbl)$status, c("nonendemic", "nonendemic"))
  expect_equal(get_island_tbl(island_tbl)$missing_species, c(0, 0))
  expect_equal(get_island_tbl(island_tbl)$col_time, c(0.5, 1.43337005682))
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(NA_real_, NA_real_))
  )
  expect_equal(get_island_tbl(island_tbl)$min_age, c(NA_real_, 0.251727277709))
  expect_equal(
    get_island_tbl(island_tbl)$species,
    I(list("bird_z", c("bird_a_1", "bird_a_2")))
  )
  expect_equal(get_island_tbl(island_tbl)$clade_type, c(1, 1))
})

test_that("2 tips endemic, empty_tbl", {
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
    col_time = 0.5,
    col_max_age = FALSE,
    branching_times = I(list(NA_real_)),
    min_age = NA_real_,
    species = I(list("bird_z")),
    clade_type = 1
  )
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)
  set_island_tbl(island_tbl) <- new_tbl
  island_tbl <- bind_colonist_to_tbl(
    island_colonist = island_colonist,
    island_tbl = island_tbl
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, c("bird_z", "bird_a"))
  expect_equal(get_island_tbl(island_tbl)$status, c("nonendemic", "endemic"))
  expect_equal(get_island_tbl(island_tbl)$missing_species, c(0, 0))
  expect_equal(get_island_tbl(island_tbl)$col_time, c(0.5, 1.43337005682))
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(NA_real_, NA_real_))
  )
  expect_equal(get_island_tbl(island_tbl)$min_age, c(NA_real_, 0.251727277709))
  expect_equal(
    get_island_tbl(island_tbl)$species,
    I(list("bird_z", c("bird_a_1", "bird_a_2")))
  )
  expect_equal(get_island_tbl(island_tbl)$clade_type, c(1, 1))
})
