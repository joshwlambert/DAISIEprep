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
  expect_equal(daisie_datatable$Branching_times, I(list(c(0.49999))))
})

test_that("1 nonendemic, max col time before island age", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 0.5,
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
  expect_equal(daisie_datatable$Branching_times, I(list(c(0.49999))))
})

test_that("1 nonendemic, min col time before island age", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 0.5,
    col_uncertainty = "min"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_b")
  expect_equal(daisie_datatable$Status, "nonendemic_MaxAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(daisie_datatable$Branching_times, I(list(c(0.49999))))
})

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

test_that("1 endemic, precise col time before island age", {
  phylod <- create_test_phylod(test_scenario = 6)
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
  expect_equal(daisie_datatable$Status, "endemic_MaxAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(daisie_datatable$Branching_times, I(list(c(0.49999))))
})

test_that("1 endemic, max col time before island age", {
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

test_that("1 endemic, min col time before island age", {
  phylod <- create_test_phylod(test_scenario = 6)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 0.5,
    col_uncertainty = "min"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_b")
  expect_equal(daisie_datatable$Status, "endemic_MaxAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(daisie_datatable$Branching_times, I(list(c(0.49999))))
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
  expect_equal(
    daisie_datatable$Status,
    c("nonendemic_MaxAge", "nonendemic_MaxAge")
  )
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

test_that("2 nonendemics, precise col time before island age", {
  phylod <- create_test_phylod(test_scenario = 11)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 0.1,
    col_uncertainty = "none"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, c("bird_a", "bird_b"))
  expect_equal(
    daisie_datatable$Status,
    c("nonendemic_MaxAge", "nonendemic_MaxAge")
  )
  expect_equal(daisie_datatable$Missing_species, c(0, 0))
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.09999), c(0.09999)))
  )
})

test_that("2 nonendemics, max col time before island age", {
  phylod <- create_test_phylod(test_scenario = 11)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 0.1,
    col_uncertainty = "max"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, c("bird_a", "bird_b"))
  expect_equal(
    daisie_datatable$Status,
    c("nonendemic_MaxAge", "nonendemic_MaxAge")
  )
  expect_equal(daisie_datatable$Missing_species, c(0, 0))
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.09999), c(0.09999)))
  )
})

test_that("2 nonendemics, min col time before island age", {
  phylod <- create_test_phylod(test_scenario = 11)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 0.1,
    col_uncertainty = "min"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, c("bird_a", "bird_b"))
  expect_equal(
    daisie_datatable$Status,
    c("nonendemic_MaxAge", "nonendemic_MaxAge")
  )
  expect_equal(daisie_datatable$Missing_species, c(0, 0))
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.09999), c(0.09999)))
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

test_that("2 endemics, precise col time before island age", {
  phylod <- create_test_phylod(test_scenario = 14)
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
  expect_equal(daisie_datatable$Clade_name, "bird_a")
  expect_equal(daisie_datatable$Status, "endemic_MaxAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.99999, 0.251727277709)))
  )
})

test_that("2 endemics, max col time before island age", {
  phylod <- create_test_phylod(test_scenario = 14)
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
  expect_equal(daisie_datatable$Clade_name, "bird_a")
  expect_equal(daisie_datatable$Status, "endemic_MaxAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.99999, 0.251727277709)))
  )
})

test_that("2 endemics, min col time before island age", {
  phylod <- create_test_phylod(test_scenario = 14)
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
  expect_equal(daisie_datatable$Clade_name, "bird_a")
  expect_equal(daisie_datatable$Status, "endemic_MaxAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.99999, 0.251727277709)))
  )
})

test_that("2 endemics, precise col time and brts before island age", {
  phylod <- create_test_phylod(test_scenario = 14)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 0.1,
    col_uncertainty = "none"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_a")
  expect_equal(daisie_datatable$Status, "endemic_MaxAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(daisie_datatable$Branching_times, I(list(c(0.09999))))
})

test_that("2 endemics, max col time and brts before island age", {
  phylod <- create_test_phylod(test_scenario = 14)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 0.1,
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
  expect_equal(daisie_datatable$Branching_times, I(list(c(0.09999))))
})

test_that("2 endemics, min col time and brts before island age", {
  phylod <- create_test_phylod(test_scenario = 14)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = 0.1,
    col_uncertainty = "min"
  )

  expect_true(is.data.frame(daisie_datatable))
  expect_equal(
    colnames(daisie_datatable),
    c("Clade_name", "Status", "Missing_species", "Branching_times")
  )
  expect_equal(daisie_datatable$Clade_name, "bird_a")
  expect_equal(daisie_datatable$Status, "endemic_MaxAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(daisie_datatable$Branching_times, I(list(c(0.09999))))
})

test_that("2 tips nonendemic, precise col time after island age", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("nonendemic", "nonendemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
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
  expect_equal(daisie_datatable$Status, "nonendemic")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(1.43337005682)))
  )
})

test_that("2 tips nonendemic, max col time after island age", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("nonendemic", "nonendemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
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
  expect_equal(daisie_datatable$Status, "nonendemic_MaxAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(1.43337005682)))
  )
})

test_that("2 tips nonendemic, min col time after island age", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("nonendemic", "nonendemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
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
  expect_equal(daisie_datatable$Status, "nonendemic_MaxAgeMinAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(1.433370056817, 0.251727277709)))
  )
})

test_that("2 tips nonendemic, precise col time before island age", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("nonendemic", "nonendemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
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
  expect_equal(daisie_datatable$Clade_name, "bird_a")
  expect_equal(daisie_datatable$Status, "nonendemic_MaxAgeMinAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.999990000000, 0.251727277709)))
  )
})

test_that("2 tips nonendemic, max col time before island age", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("nonendemic", "nonendemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
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
  expect_equal(daisie_datatable$Clade_name, "bird_a")
  expect_equal(daisie_datatable$Status, "nonendemic_MaxAgeMinAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.999990000000, 0.251727277709)))
  )
})

test_that("2 tips nonendemic, min col time before island age", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("nonendemic", "nonendemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
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
  expect_equal(daisie_datatable$Clade_name, "bird_a")
  expect_equal(daisie_datatable$Status, "nonendemic_MaxAgeMinAge")
  expect_equal(daisie_datatable$Missing_species, 0)
  expect_equal(
    daisie_datatable$Branching_times,
    I(list(c(0.999990000000, 0.251727277709)))
  )
})
