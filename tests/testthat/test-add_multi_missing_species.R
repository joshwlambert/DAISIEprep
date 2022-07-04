test_that("add_multi_missing_species works assigning first colonist", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  phylod <- create_test_phylod(test_scenario = 7)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
    island_tbl = island_tbl
  ))

  missing_species <- data.frame(
    clade_name = "bird",
    missing_species = 1,
    endemicity_status = "endemic"
  )

  missing_genus <- list("bird", character(0))

  island_tbl <- add_multi_missing_species(
    missing_species = missing_species,
    missing_genus = missing_genus,
    island_tbl = island_tbl
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, c("bird_b", "bird_c"))
  expect_equal(get_island_tbl(island_tbl)$status, c("endemic", "endemic"))
  expect_equal(get_island_tbl(island_tbl)$missing_species, c(1, 0))
  expect_equal(
    get_island_tbl(island_tbl)$col_time,
    c(0.755181833128, 1.433370056817)
  )
  expect_equal(get_island_tbl(island_tbl)$col_max_age, c(FALSE, FALSE))
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(NA_real_, NA_real_))
  )
  expect_equal(get_island_tbl(island_tbl)$min_age, c(NA_real_, NA_real_))
  expect_equal(
    get_island_tbl(island_tbl)$species,
    I(list("bird_b", "bird_c"))
  )
  expect_equal(get_island_tbl(island_tbl)$clade_type, c(1, 1))
})

test_that("add_multi_missing_species works assigning second colonist", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  phylod <- create_test_phylod(test_scenario = 7)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
    island_tbl = island_tbl
  ))

  missing_species <- data.frame(
    clade_name = "bird",
    missing_species = 1,
    endemicity_status = "endemic"
  )

  missing_genus <- list(character(0), "bird")

  island_tbl <- add_multi_missing_species(
    missing_species = missing_species,
    missing_genus = missing_genus,
    island_tbl = island_tbl
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, c("bird_b", "bird_c"))
  expect_equal(get_island_tbl(island_tbl)$status, c("endemic", "endemic"))
  expect_equal(get_island_tbl(island_tbl)$missing_species, c(0, 1))
  expect_equal(
    get_island_tbl(island_tbl)$col_time,
    c(0.755181833128, 1.433370056817)
  )
  expect_equal(get_island_tbl(island_tbl)$col_max_age, c(FALSE, FALSE))
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(NA_real_, NA_real_))
  )
  expect_equal(get_island_tbl(island_tbl)$min_age, c(NA_real_, NA_real_))
  expect_equal(
    get_island_tbl(island_tbl)$species,
    I(list("bird_b", "bird_c"))
  )
  expect_equal(get_island_tbl(island_tbl)$clade_type, c(1, 1))
})

test_that("add_multi_missing_species works assigning no colonist", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  phylod <- create_test_phylod(test_scenario = 7)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
    island_tbl = island_tbl
  ))

  missing_species <- data.frame(
    clade_name = "bird",
    missing_species = 1,
    endemicity_status = "endemic"
  )

  missing_genus <- list("mammal", "squamate")

  island_tbl <- add_multi_missing_species(
    missing_species = missing_species,
    missing_genus = missing_genus,
    island_tbl = island_tbl
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, c("bird_b", "bird_c"))
  expect_equal(get_island_tbl(island_tbl)$status, c("endemic", "endemic"))
  expect_equal(get_island_tbl(island_tbl)$missing_species, c(0, 0))
  expect_equal(
    get_island_tbl(island_tbl)$col_time,
    c(0.755181833128, 1.433370056817)
  )
  expect_equal(get_island_tbl(island_tbl)$col_max_age, c(FALSE, FALSE))
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(NA_real_, NA_real_))
  )
  expect_equal(get_island_tbl(island_tbl)$min_age, c(NA_real_, NA_real_))
  expect_equal(
    get_island_tbl(island_tbl)$species,
    I(list("bird_b", "bird_c"))
  )
  expect_equal(get_island_tbl(island_tbl)$clade_type, c(1, 1))
})

test_that("add_multi_missing_species works summing missing species", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  phylod <- create_test_phylod(test_scenario = 7)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
    island_tbl = island_tbl
  ))
  island_tbl@island_tbl$species[[1]] <- c("bird_b", "mammal_a", "squamate_a")

  missing_species <- data.frame(
    clade_name = c("bird", "mammal", "squamate"),
    missing_species = c(1, 2, 3),
    endemicity_status = c("endemic", "endemic", "endemic")
  )

  missing_genus <- list(c("bird", "mammal", "squamate"), character(0))

  island_tbl <- add_multi_missing_species(
    missing_species = missing_species,
    missing_genus = missing_genus,
    island_tbl = island_tbl
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, c("bird_b", "bird_c"))
  expect_equal(get_island_tbl(island_tbl)$status, c("endemic", "endemic"))
  expect_equal(get_island_tbl(island_tbl)$missing_species, c(6, 0))
  expect_equal(
    get_island_tbl(island_tbl)$col_time,
    c(0.755181833128, 1.433370056817)
  )
  expect_equal(get_island_tbl(island_tbl)$col_max_age, c(FALSE, FALSE))
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(NA_real_, NA_real_))
  )
  expect_equal(get_island_tbl(island_tbl)$min_age, c(NA_real_, NA_real_))
  expect_equal(
    get_island_tbl(island_tbl)$species,
    I(list(c("bird_b", "mammal_a", "squamate_a"), "bird_c"))
  )
  expect_equal(get_island_tbl(island_tbl)$clade_type, c(1, 1))
})

test_that("add_multi_missing_species does not assign to nonendemic", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  phylod <- create_test_phylod(test_scenario = 7)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
    island_tbl = island_tbl
  ))

  missing_species <- data.frame(
    clade_name = "bird",
    missing_species = 1,
    endemicity_status = "endemic"
  )

  missing_genus <- list("bird", character(0))

  island_tbl <- add_multi_missing_species(
    missing_species = missing_species,
    missing_genus = missing_genus,
    island_tbl = island_tbl
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, c("bird_b", "bird_c"))
  expect_equal(get_island_tbl(island_tbl)$status, c("nonendemic", "endemic"))
  expect_equal(get_island_tbl(island_tbl)$missing_species, c(0, 0))
  expect_equal(
    get_island_tbl(island_tbl)$col_time,
    c(0.755181833128, 1.433370056817)
  )
  expect_equal(get_island_tbl(island_tbl)$col_max_age, c(FALSE, FALSE))
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(NA_real_, NA_real_))
  )
  expect_equal(get_island_tbl(island_tbl)$min_age, c(NA_real_, NA_real_))
  expect_equal(
    get_island_tbl(island_tbl)$species,
    I(list("bird_b", "bird_c"))
  )
  expect_equal(get_island_tbl(island_tbl)$clade_type, c(1, 1))
})
