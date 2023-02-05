test_that("get_island_tbl works for one colonist", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  island_tbl_df <- get_island_tbl(island_tbl)

  expect_true(is.data.frame(island_tbl_df))
  expect_equal(
    colnames(island_tbl_df),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
    "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(nrow(island_tbl_df), 1)
})

test_that("get_island_tbl works for two colonists", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  phylod <- create_test_phylod(test_scenario = 2)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
    island_tbl = island_tbl
  ))
  island_tbl_df <- get_island_tbl(island_tbl)

  expect_true(is.data.frame(island_tbl_df))
  expect_equal(
    colnames(island_tbl_df),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(nrow(island_tbl_df), 2)
})

test_that("set_island_tbl works", {
  new_island_tbl <- data.frame(
    clade_name = "bird_b",
    status = "nonendemic",
    missing_species = 0,
    col_time = 0.755181833128,
    col_max_age = FALSE,
    branching_times = I(list(NA_real_)),
    min_age = NA_real_,
    species = I(list("bird_b")),
    clade_type = 1
  )
  island_tbl <- island_tbl()
  set_island_tbl(island_tbl) <- new_island_tbl

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
  expect_false(get_island_tbl(island_tbl)$col_max_age)
  expect_true(is.na(get_island_tbl(island_tbl)$branching_times))
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
  expect_equal(get_island_tbl(island_tbl)$species, I(list("bird_b")))
  expect_equal(get_island_tbl(island_tbl)$clade_type, 1)
})

test_that("get_extracted_species works", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  extracted_species <- get_extracted_species(island_tbl)

  expect_true(is.na(extracted_species))
})

test_that("set_extracted_species works", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  set_extracted_species(island_tbl) <- "bird_b"

  expect_equal(island_tbl@metadata$extracted_species, "bird_b")
})

test_that("get_num_phylo_used works", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  num_phylo_used <- get_num_phylo_used(island_tbl)

  expect_true(is.na(num_phylo_used))
})

test_that("set_num_phylo_used works", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- suppressWarnings(extract_island_species(
    phylod = phylod,
    extraction_method = "asr",
  ))
  set_num_phylo_used(island_tbl) <- 1

  expect_equal(island_tbl@metadata$num_phylo_used, 1)
})
