test_that("rm_multi_missing_species removes assigned species", {

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
  rm_missing_species <- rm_multi_missing_species(
    missing_species = missing_species,
    missing_genus = missing_genus,
    island_tbl = island_tbl
  )

  expect_equal(nrow(rm_missing_species), 0)
  expect_equal(ncol(rm_missing_species), 3)
  expect_equal(
    colnames(rm_missing_species),
    c("clade_name", "missing_species", "endemicity_status")
  )
})

test_that("rm_multi_missing_species does not remove unassigned species", {

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
  missing_genus <- list("mammal", character(0))
  rm_missing_species <- rm_multi_missing_species(
    missing_species = missing_species,
    missing_genus = missing_genus,
    island_tbl = island_tbl
  )

  expect_equal(nrow(rm_missing_species), 1)
  expect_equal(ncol(rm_missing_species), 3)
  expect_equal(
    colnames(rm_missing_species),
    c("clade_name", "missing_species", "endemicity_status")
  )
  expect_equal(rm_missing_species$clade_name, "bird")
  expect_equal(rm_missing_species$missing_species, 1)
  expect_equal(rm_missing_species$endemicity_status, "endemic")
})

test_that("rm_multi_missing_species does not remove missing nonendemic", {
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
    endemicity_status = c("endemic", "endemic", "nonendemic")
  )

  missing_genus <- list(c("bird", "mammal", "squamate"), character(0))

  rm_missing_species <- rm_multi_missing_species(
    missing_species = missing_species,
    missing_genus = missing_genus,
    island_tbl = island_tbl
  )

  expect_equal(nrow(rm_missing_species), 1)
  expect_equal(ncol(rm_missing_species), 3)
  expect_equal(
    colnames(rm_missing_species),
    c("clade_name", "missing_species", "endemicity_status")
  )
})
