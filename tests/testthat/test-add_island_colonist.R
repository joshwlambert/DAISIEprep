test_that("add_island_colonist works for empty island_tbl", {
  island_tbl <- island_tbl()
  island_tbl <- add_island_colonist(
    island_tbl,
    clade_name = "new_clade",
    status = "endemic",
    missing_species = 0,
    branching_times = 1,
    min_age = NA,
    species = "new_clade"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age",
      "species")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "new_clade")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(1))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
  expect_equal(
    get_island_tbl(island_tbl)$species,
    I(list("new_clade"))
  )
})

test_that("add_island_colonist works for non-empty island_tbl", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  island_tbl <- add_island_colonist(
    island_tbl,
    clade_name = "bird_c",
    status = "endemic",
    missing_species = 0,
    branching_times = 1,
    min_age = NA,
    species = c("bird_c", "bird_d")
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age",
      "species")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, c("bird_b", "bird_c"))
  expect_equal(get_island_tbl(island_tbl)$status, c("nonendemic", "endemic"))
  expect_equal(get_island_tbl(island_tbl)$missing_species, c(0, 0))
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.755181833128), 1))
  )
  expect_equal(get_island_tbl(island_tbl)$min_age, c(NA_real_, NA_real_))
  expect_equal(
    get_island_tbl(island_tbl)$species,
    I(list("bird_b", c("bird_c", "bird_d")))
  )
})
