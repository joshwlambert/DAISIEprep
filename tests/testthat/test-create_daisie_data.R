test_that("endemic singleton", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 1.0,
    precise_col_time = TRUE
  )
  daisie_data <- create_daisie_data(
    data = daisie_datatable,
    island_age = 1.0,
    num_mainland_species = 100)

  expect_true(is.list(daisie_data))
  expect_length(daisie_data, 2)
  list_names <- lapply(daisie_data, names)
  expect_equal(list_names[[1]], c("island_age", "not_present"))
  expect_equal(
    list_names[[2]],
    c("colonist_name", "branching_times", "stac", "missing_species", "type1or2")
  )
  expect_equal(daisie_data[[1]]$island_age, 1)
  expect_equal(daisie_data[[1]]$not_present, 99)
  expect_equal(daisie_data[[2]]$colonist_name, "bird_b")
  expect_equal(daisie_data[[2]]$branching_times, c(1.0, 0.755181833128))
  expect_equal(daisie_data[[2]]$stac, 2)
  expect_equal(daisie_data[[2]]$missing_species, 0)
  expect_equal(daisie_data[[2]]$type1or2, 1)
})

test_that("nonendemic singleton", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 1.0,
    precise_col_time = TRUE
  )
  daisie_data <- create_daisie_data(
    data = daisie_datatable,
    island_age = 1.0,
    num_mainland_species = 100)

  expect_true(is.list(daisie_data))
  expect_length(daisie_data, 2)
  list_names <- lapply(daisie_data, names)
  expect_equal(list_names[[1]], c("island_age", "not_present"))
  expect_equal(
    list_names[[2]],
    c("colonist_name", "branching_times", "stac", "missing_species", "type1or2")
  )
  expect_equal(daisie_data[[1]]$island_age, 1)
  expect_equal(daisie_data[[1]]$not_present, 99)
  expect_equal(daisie_data[[2]]$colonist_name, "bird_b")
  expect_equal(daisie_data[[2]]$branching_times, c(1.0, 0.755181833128))
  expect_equal(daisie_data[[2]]$stac, 4)
  expect_equal(daisie_data[[2]]$missing_species, 0)
  expect_equal(daisie_data[[2]]$type1or2, 1)
})

test_that("endemic clade", {
  phylod <- create_test_phylod(test_scenario = 14)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 3.0,
    precise_col_time = TRUE
  )
  daisie_data <- create_daisie_data(
    data = daisie_datatable,
    island_age = 3.0,
    num_mainland_species = 100)

  expect_true(is.list(daisie_data))
  expect_length(daisie_data, 2)
  list_names <- lapply(daisie_data, names)
  expect_equal(list_names[[1]], c("island_age", "not_present"))
  expect_equal(
    list_names[[2]],
    c("colonist_name", "branching_times", "stac", "missing_species", "type1or2")
  )
  expect_equal(daisie_data[[1]]$island_age, 3)
  expect_equal(daisie_data[[1]]$not_present, 99)
  expect_equal(daisie_data[[2]]$colonist_name, "bird_a")
  expect_equal(
    daisie_data[[2]]$branching_times,
    c(3.0, 1.433370056817, 0.251727277709)
  )
  expect_equal(daisie_data[[2]]$stac, 2)
  expect_equal(daisie_data[[2]]$missing_species, 0)
  expect_equal(daisie_data[[2]]$type1or2, 1)
})

test_that("nonendemic singleton max age", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 0.5,
    precise_col_time = TRUE
  )
  daisie_data <- create_daisie_data(
    data = daisie_datatable,
    island_age = 0.5,
    num_mainland_species = 100)

  expect_true(is.list(daisie_data))
  expect_length(daisie_data, 2)
  list_names <- lapply(daisie_data, names)
  expect_equal(list_names[[1]], c("island_age", "not_present"))
  expect_equal(
    list_names[[2]],
    c("colonist_name", "branching_times", "stac", "missing_species", "type1or2")
  )
  expect_equal(daisie_data[[1]]$island_age, 0.5)
  expect_equal(daisie_data[[1]]$not_present, 99)
  expect_equal(daisie_data[[2]]$colonist_name, "bird_b")
  expect_equal(daisie_data[[2]]$branching_times, c(0.5, 0.49999))
  expect_equal(daisie_data[[2]]$stac, 1)
  expect_equal(daisie_data[[2]]$missing_species, 0)
  expect_equal(daisie_data[[2]]$type1or2, 1)
})

test_that("endemic singleton max age", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 0.5,
    precise_col_time = TRUE
  )
  daisie_data <- create_daisie_data(
    data = daisie_datatable,
    island_age = 0.5,
    num_mainland_species = 100)

  expect_true(is.list(daisie_data))
  expect_length(daisie_data, 2)
  list_names <- lapply(daisie_data, names)
  expect_equal(list_names[[1]], c("island_age", "not_present"))
  expect_equal(
    list_names[[2]],
    c("colonist_name", "branching_times", "stac", "missing_species", "type1or2")
  )
  expect_equal(daisie_data[[1]]$island_age, 0.5)
  expect_equal(daisie_data[[1]]$not_present, 99)
  expect_equal(daisie_data[[2]]$colonist_name, "bird_b")
  expect_equal(daisie_data[[2]]$branching_times, c(0.50000, 0.49999))
  expect_equal(daisie_data[[2]]$stac, 5)
  expect_equal(daisie_data[[2]]$missing_species, 0)
  expect_equal(daisie_data[[2]]$type1or2, 1)
})

test_that("recolonisation", {

})

test_that("endemic singleton max age min age", {

})

test_that("nonendemic singleton max age min age", {

})

test_that("endemic singleton and nonendemic singleton", {

})

test_that("endemic singleton and endemic clade", {

})

test_that("endemic singleton and nonendemic max age", {

})

test_that("endemic singleton with missing species", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  island_tbl <- add_missing_species(
    island_tbl = island_tbl,
    num_missing_species = 1,
    species_to_add_to = "bird_b"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 1.0,
    precise_col_time = TRUE
  )
  daisie_data <- create_daisie_data(
    data = daisie_datatable,
    island_age = 1.0,
    num_mainland_species = 100)

  expect_true(is.list(daisie_data))
  expect_length(daisie_data, 2)
  list_names <- lapply(daisie_data, names)
  expect_equal(list_names[[1]], c("island_age", "not_present"))
  expect_equal(
    list_names[[2]],
    c("colonist_name", "branching_times", "stac", "missing_species", "type1or2")
  )
  expect_equal(daisie_data[[1]]$island_age, 1.0)
  expect_equal(daisie_data[[1]]$not_present, 99)
  expect_equal(daisie_data[[2]]$colonist_name, "bird_b")
  expect_equal(daisie_data[[2]]$branching_times, c(1.0, 0.755181833128))
  expect_equal(daisie_data[[2]]$stac, 2)
  expect_equal(daisie_data[[2]]$missing_species, 1)
  expect_equal(daisie_data[[2]]$type1or2, 1)
})

test_that("endemic clade with missing species", {

})

test_that("endemic singleton max age with missing species", {

})

test_that("endemic clade max age with missing species", {

})

test_that("endemic singleton and endemic clade with 2 type proportional", {

})

test_that("endemic singleton and endemic clade with 2 type non-proportional", {

})

test_that("endemic singleton from island_tbl", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_data <- create_daisie_data(
    data = island_tbl,
    island_age = 1.0,
    num_mainland_species = 100)

  expect_true(is.list(daisie_data))
  expect_length(daisie_data, 2)
  list_names <- lapply(daisie_data, names)
  expect_equal(list_names[[1]], c("island_age", "not_present"))
  expect_equal(
    list_names[[2]],
    c("colonist_name", "branching_times", "stac", "missing_species", "type1or2")
  )
  expect_equal(daisie_data[[1]]$island_age, 1)
  expect_equal(daisie_data[[1]]$not_present, 99)
  expect_equal(daisie_data[[2]]$colonist_name, "bird_b")
  expect_equal(daisie_data[[2]]$branching_times, c(1.0, 0.755181833128))
  expect_equal(daisie_data[[2]]$stac, 2)
  expect_equal(daisie_data[[2]]$missing_species, 0)
  expect_equal(daisie_data[[2]]$type1or2, 1)
})

test_that("nonendemic singleton from island_tbl", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_data <- create_daisie_data(
    data = island_tbl,
    island_age = 1.0,
    num_mainland_species = 100)

  expect_true(is.list(daisie_data))
  expect_length(daisie_data, 2)
  list_names <- lapply(daisie_data, names)
  expect_equal(list_names[[1]], c("island_age", "not_present"))
  expect_equal(
    list_names[[2]],
    c("colonist_name", "branching_times", "stac", "missing_species", "type1or2")
  )
  expect_equal(daisie_data[[1]]$island_age, 1)
  expect_equal(daisie_data[[1]]$not_present, 99)
  expect_equal(daisie_data[[2]]$colonist_name, "bird_b")
  expect_equal(daisie_data[[2]]$branching_times, c(1.0, 0.755181833128))
  expect_equal(daisie_data[[2]]$stac, 4)
  expect_equal(daisie_data[[2]]$missing_species, 0)
  expect_equal(daisie_data[[2]]$type1or2, 1)
})

test_that("endemic clade from island_tbl", {
  phylod <- create_test_phylod(test_scenario = 14)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_data <- create_daisie_data(
    data = island_tbl,
    island_age = 3.0,
    num_mainland_species = 100)

  expect_true(is.list(daisie_data))
  expect_length(daisie_data, 2)
  list_names <- lapply(daisie_data, names)
  expect_equal(list_names[[1]], c("island_age", "not_present"))
  expect_equal(
    list_names[[2]],
    c("colonist_name", "branching_times", "stac", "missing_species", "type1or2")
  )
  expect_equal(daisie_data[[1]]$island_age, 3)
  expect_equal(daisie_data[[1]]$not_present, 99)
  expect_equal(daisie_data[[2]]$colonist_name, "bird_a")
  expect_equal(
    daisie_data[[2]]$branching_times,
    c(3.0, 1.433370056817, 0.251727277709)
  )
  expect_equal(daisie_data[[2]]$stac, 2)
  expect_equal(daisie_data[[2]]$missing_species, 0)
  expect_equal(daisie_data[[2]]$type1or2, 1)
})

test_that("nonendemic singleton max age from island_tbl", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_data <- create_daisie_data(
    data = island_tbl,
    island_age = 0.5,
    num_mainland_species = 100)

  expect_true(is.list(daisie_data))
  expect_length(daisie_data, 2)
  list_names <- lapply(daisie_data, names)
  expect_equal(list_names[[1]], c("island_age", "not_present"))
  expect_equal(
    list_names[[2]],
    c("colonist_name", "branching_times", "stac", "missing_species", "type1or2")
  )
  expect_equal(daisie_data[[1]]$island_age, 0.5)
  expect_equal(daisie_data[[1]]$not_present, 99)
  expect_equal(daisie_data[[2]]$colonist_name, "bird_b")
  expect_equal(daisie_data[[2]]$branching_times, c(0.5, 0.49999))
  expect_equal(daisie_data[[2]]$stac, 1)
  expect_equal(daisie_data[[2]]$missing_species, 0)
  expect_equal(daisie_data[[2]]$type1or2, 1)
})

test_that("endemic singleton max age from island_tbl", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_data <- create_daisie_data(
    data = island_tbl,
    island_age = 0.5,
    num_mainland_species = 100)

  expect_true(is.list(daisie_data))
  expect_length(daisie_data, 2)
  list_names <- lapply(daisie_data, names)
  expect_equal(list_names[[1]], c("island_age", "not_present"))
  expect_equal(
    list_names[[2]],
    c("colonist_name", "branching_times", "stac", "missing_species", "type1or2")
  )
  expect_equal(daisie_data[[1]]$island_age, 0.5)
  expect_equal(daisie_data[[1]]$not_present, 99)
  expect_equal(daisie_data[[2]]$colonist_name, "bird_b")
  expect_equal(daisie_data[[2]]$branching_times, c(0.50000, 0.49999))
  expect_equal(daisie_data[[2]]$stac, 5)
  expect_equal(daisie_data[[2]]$missing_species, 0)
  expect_equal(daisie_data[[2]]$type1or2, 1)
})
