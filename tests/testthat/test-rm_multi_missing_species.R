test_that("rm_multi_missing_species removes assigned species", {
  missing_species <- data.frame(
    clade_name = "bird",
    missing_species = 1,
    endemicity_status = "endemic"
  )
  missing_genus <- list("bird", character(0))
  rm_missing_species <- rm_multi_missing_species(
    missing_species = missing_species,
    missing_genus = missing_genus
  )

  expect_equal(nrow(rm_missing_species), 0)
  expect_equal(ncol(rm_missing_species), 3)
  expect_equal(
    colnames(rm_missing_species),
    c("clade_name", "missing_species", "endemicity_status")
  )
})

test_that("rm_multi_missing_species does not remove unassigned species", {
  missing_species <- data.frame(
    clade_name = "bird",
    missing_species = 1,
    endemicity_status = "endemic"
  )
  missing_genus <- list("mammal", character(0))
  rm_missing_species <- rm_multi_missing_species(
    missing_species = missing_species,
    missing_genus = missing_genus
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
