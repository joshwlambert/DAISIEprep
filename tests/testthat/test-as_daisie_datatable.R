test_that("1 nonendemic, precise col time after island age", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 1.0,
    col_uncertainty = "none"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_b")
  expect_equal(daisie_datatable$Status, "nonendemic")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.755181833128)))
  )
})

test_that("1 nonendemic, max col time after island age", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 1.0,
    col_uncertainty = "max"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_b")
  expect_equal(daisie_datatable$Status, "nonendemic_MaxAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.755181833128)))
  )
})

test_that("1 nonendemic, min col time after island age", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 1.0,
    col_uncertainty = "min"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_b")
  expect_equal(daisie_datatable$Status, "nonendemic")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.755181833128)))
  )
})

test_that("1 nonendemic, precise col time before island age", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 0.5,
    col_uncertainty = "none"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_b")
  expect_equal(daisie_datatable$Status, "nonendemic_MaxAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.755181833128)))
  )
})

test_that("1 nonendemic, max col time after island age", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 1.0,
    col_uncertainty = "max"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_b")
  expect_equal(daisie_datatable$Status, "nonendemic_MaxAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.755181833128)))
  )
})

test_that("1 nonendemic, min col time after island age", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 1.0,
    col_uncertainty = "min"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_b")
  expect_equal(daisie_datatable$Status, "nonendemic")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.755181833128)))
  )
})
######################## Continue from here

test_that("1 endemic, precise col time after island age", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 1.0,
    col_uncertainty = "none"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_b")
  expect_equal(daisie_datatable$Status, "endemic")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.755181833128)))
  )
})

test_that("1 endemic, max col time after island age", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 1.0,
    col_uncertainty = "max"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_b")
  expect_equal(daisie_datatable$Status, "endemic_MaxAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.755181833128)))
  )
})

test_that("1 endemic, min col time after island age", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 1.0,
    col_uncertainty = "min"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_b")
  expect_equal(daisie_datatable$Status, "endemic")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.755181833128)))
  )
})

test_that("2 nonendemics, precise col time after island age", {
  phylod <- create_test_phylod(test_scenario = 11)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 1.0,
    col_uncertainty = "none"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, c("bird_a", "bird_b"))
  expect_equal(daisie_datatable$Status, c("nonendemic", "nonendemic"))
  expect_equal(daisie_datatable$Missing_species, c(0, 0))
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.251727277709), c(0.251727277709)))
  )
})

test_that("2 nonendemics, max col time after island age", {
  phylod <- create_test_phylod(test_scenario = 11)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 1.0,
    col_uncertainty = "max"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, c("bird_a", "bird_b"))
  expect_equal(daisie_datatable$Status, c("nonendemic", "nonendemic"))
  expect_equal(daisie_datatable$Missing_species, c(0, 0))
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.251727277709), c(0.251727277709)))
  )
})

test_that("2 nonendemics, min col time after island age", {
  phylod <- create_test_phylod(test_scenario = 11)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 1.0,
    col_uncertainty = "min"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, c("bird_a", "bird_b"))
  expect_equal(daisie_datatable$Status, c("nonendemic", "nonendemic"))
  expect_equal(daisie_datatable$Missing_species, c(0, 0))
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.251727277709), c(0.251727277709)))
  )
})

test_that("2 endemics, precise col time after island age", {
  phylod <- create_test_phylod(test_scenario = 14)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 2.0,
    col_uncertainty = "none"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_a")
  expect_equal(daisie_datatable$Status, "endemic")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(1.433370056817, 0.251727277709)))
  )
})

test_that("2 endemics, max col time after island age", {
  phylod <- create_test_phylod(test_scenario = 14)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 2.0,
    col_uncertainty = "max"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_a")
  expect_equal(daisie_datatable$Status, "endemic_MaxAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(1.433370056817, 0.251727277709)))
  )
})

test_that("2 endemics, min col time after island age", {
  phylod <- create_test_phylod(test_scenario = 14)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 2.0,
    col_uncertainty = "min"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_a")
  expect_equal(daisie_datatable$Status, "endemic")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(1.433370056817, 0.251727277709)))
  )
})

