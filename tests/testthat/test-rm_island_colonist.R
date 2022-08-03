test_that("rm_island_colonist works for removing the only colonist", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )
  island_tbl <- rm_island_colonist(
    island_tbl = island_tbl,
    clade_name = "bird_b"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, character(0))
  expect_equal(get_island_tbl(island_tbl)$status, character(0))
  expect_equal(get_island_tbl(island_tbl)$missing_species, numeric(0))
  expect_equal(get_island_tbl(island_tbl)$col_time, numeric(0))
  expect_equal(get_island_tbl(island_tbl)$col_max_age, logical(0))
  expect_equal(get_island_tbl(island_tbl)$branching_times, I(list()))
  expect_equal(get_island_tbl(island_tbl)$min_age, numeric(0))
  expect_equal(get_island_tbl(island_tbl)$species, I(list()))
  expect_equal(get_island_tbl(island_tbl)$clade_type, numeric(0))
})

test_that("rm_island_colonist works for removing one of the colonists", {
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

  island_tbl <- rm_island_colonist(
    island_tbl = island_tbl,
    clade_name = "bird_b"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_c")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(get_island_tbl(island_tbl)$col_time, 1.43337005681655)
  expect_equal(get_island_tbl(island_tbl)$col_max_age, FALSE)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(NA_real_))
  )
  expect_equal(get_island_tbl(island_tbl)$min_age, NA_real_)
  expect_equal(
    get_island_tbl(island_tbl)$species,
    I(list("bird_c"))
  )
  expect_equal(get_island_tbl(island_tbl)$clade_type, 1)
})
