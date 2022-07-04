test_that("count_missing_species works", {
  mock_checklist <- data.frame(
    species_names = c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                      "bird_f","bird_g", "bird_h", "bird_i", "bird_j"),
    sampled = c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE),
    endemicity_status = c("endemic", "endemic", "endemic", "nonendemic",
                          "endemic", "nonendemic", "endemic", "endemic",
                          "endemic", "endemic"),
    remove_species = (rep(FALSE, 10))
  )

  missing_species <- count_missing_species(
    checklist = mock_checklist,
    phylo_name_col = "species_names",
    in_phylo_col = "sampled",
    endemicity_status_col = "endemicity_status",
    rm_species_col = NULL
  )
  expect_true(is.data.frame(missing_species))
  expect_equal(ncol(missing_species), 3)
  expect_equal(nrow(missing_species), 2)
  expect_equal(
    colnames(missing_species),
    c("clade_name", "missing_species", "endemicity_status")
  )
  expect_equal(missing_species$clade_name, c("bird", "bird"))
  expect_equal(missing_species$missing_species, c(2, 1))
  expect_equal(missing_species$endemicity_status, c("endemic", "nonendemic"))
})

test_that("count_missing_species works with removing endemic species", {
  mock_checklist <- data.frame(
    species_names = c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                      "bird_f","bird_g", "bird_h", "bird_i", "bird_j"),
    sampled = c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE),
    endemicity_status = c("endemic", "endemic", "endemic", "nonendemic",
                          "endemic", "nonendemic", "endemic", "endemic",
                          "endemic", "endemic"),
    remove_species = (c(rep(FALSE, 9), TRUE))
  )

  missing_species <- count_missing_species(
    checklist = mock_checklist,
    phylo_name_col = "species_names",
    in_phylo_col = "sampled",
    endemicity_status_col = "endemicity_status",
    rm_species_col = "remove_species"
  )
  expect_true(is.data.frame(missing_species))
  expect_equal(ncol(missing_species), 3)
  expect_equal(nrow(missing_species), 2)
  expect_equal(
    colnames(missing_species),
    c("clade_name", "missing_species", "endemicity_status")
  )
  expect_equal(missing_species$clade_name, c("bird", "bird"))
  expect_equal(missing_species$missing_species, c(1, 1))
  expect_equal(missing_species$endemicity_status, c("endemic", "nonendemic"))
})

test_that("count_missing_species works with removing nonendemic species", {
  mock_checklist <- data.frame(
    species_names = c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                      "bird_f","bird_g", "bird_h", "bird_i", "bird_j"),
    sampled = c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE),
    endemicity_status = c("endemic", "endemic", "endemic", "nonendemic",
                          "endemic", "nonendemic", "endemic", "endemic",
                          "endemic", "endemic"),
    remove_species = (c(rep(FALSE, 5), TRUE, rep(FALSE, 4)))
  )

  missing_species <- count_missing_species(
    checklist = mock_checklist,
    phylo_name_col = "species_names",
    in_phylo_col = "sampled",
    endemicity_status_col = "endemicity_status",
    rm_species_col = "remove_species"
  )
  expect_true(is.data.frame(missing_species))
  expect_equal(ncol(missing_species), 3)
  expect_equal(nrow(missing_species), 1)
  expect_equal(
    colnames(missing_species),
    c("clade_name", "missing_species", "endemicity_status")
  )
  expect_equal(missing_species$clade_name, "bird")
  expect_equal(missing_species$missing_species, 2)
  expect_equal(missing_species$endemicity_status, "endemic")
})

test_that("count_missing_species fails correctly", {
  mock_checklist <- data.frame(
    species_names = c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                      "bird_f","bird_g", "bird_h", "bird_i", "bird_j"),
    sampled = c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE),
    endemicity_status = c("endemic", "endemic", "endemic", "nonendemic",
                          "endemic", "nonendemic", "endemic", "endemic",
                          "endemic", "endemic"),
    remove_species = (c(rep(FALSE, 5), TRUE, rep(FALSE, 4)))
  )

  expect_error(count_missing_species(
    checklist = list(),
    phylo_name_col = "species_names",
    in_phylo_col = "sampled",
    endemicity_status_col = "endemicity_status",
    rm_species_col = "remove_species"
  ))

  expect_error(count_missing_species(
    checklist = mock_checklist,
    phylo_name_col = c(),
    in_phylo_col = "sampled",
    endemicity_status_col = "endemicity_status",
    rm_species_col = "remove_species"
  ))

  expect_error(count_missing_species(
    checklist = mock_checklist,
    phylo_name_col = "species_names",
    in_phylo_col = c(),
    endemicity_status_col = "endemicity_status",
    rm_species_col = "remove_species"
  ))

  expect_error(count_missing_species(
    checklist = mock_checklist,
    phylo_name_col = "species_names",
    in_phylo_col = "sampled",
    endemicity_status_col = c(),
    rm_species_col = "remove_species"
  ))

  expect_error(count_missing_species(
    checklist = mock_checklist,
    phylo_name_col = "species_names",
    in_phylo_col = "sampled",
    endemicity_status_col = "endemicity_status",
    rm_species_col = list()
  ))
})
