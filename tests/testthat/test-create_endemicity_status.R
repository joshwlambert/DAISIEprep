test_that("create_endemicity_status runs correctly for coccyzus", {
  coccyzus_tree <- ape::read.nexus(
    file = system.file("extdata", "Coccyzus.tre", package = "DAISIEprep")
  )
  island_species <- data.frame(
    tip_labels = c("Coccyzus_melacoryphus_GALAPAGOS_L569A",
                   "Coccyzus_melacoryphus_GALAPAGOS_L571A"),
    tip_endemicity_status = c("nonendemic", "nonendemic")
  )
  endemicity_status <- create_endemicity_status(
    phylo = coccyzus_tree,
    island_species = island_species
  )
  expected_endemicity <- c(rep("not_present", 18), rep("nonendemic", 2))
  expect_equal(endemicity_status$endemicity_status, expected_endemicity)
  expect_equal(rownames(endemicity_status), coccyzus_tree$tip.label)
})

test_that("create_endemicity_status runs correctly for finches", {
  finches_tree <- ape::read.nexus(
    file = system.file("extdata", "Finches.tre", package = "DAISIEprep")
  )
  finches_tree <- ape::drop.tip(phy = finches_tree, tip = "P_ino")
  island_species <- data.frame(
    tip_labels = c(
      "C_fus", "C_hel", "C_oliv", "C_pal", "C_par", "C_pau", "C_psi", "G_con",
      "G_diff", "G_for", "G_ful", "G_mag", "G_scan", "G_sep", "P_cras"
    ),
    tip_endemicity_status = c(
      "endemic", "endemic", "endemic", "endemic", "endemic", "endemic",
      "endemic", "endemic", "endemic", "endemic", "endemic", "endemic",
      "endemic", "endemic", "endemic"
    )
  )
  endemicity_status <- create_endemicity_status(
    phylo = finches_tree,
    island_species = island_species
  )
  expected_endemicity <- c(rep("endemic", 15), "not_present")
  expect_equal(endemicity_status$endemicity_status, expected_endemicity)
  expect_equal(rownames(endemicity_status), finches_tree$tip.label)
})

test_that("create_endemicity_status warns with species not in phylo", {
  coccyzus_tree <- ape::read.nexus(
    file = system.file("extdata", "Coccyzus.tre", package = "DAISIEprep")
  )
  island_species <- data.frame(
    tip_labels = c("Coccyzus_melacoryphus_GALAPAGOS_L569A",
                   "Coccyzus_melacoryphus_GALAPAGOS_L571A",
                   "Galapagos_species"),
    tip_endemicity_status = c("nonendemic", "nonendemic", "endemic")
  )
  expect_warning(
    endemicity_status <- create_endemicity_status(
      phylo = coccyzus_tree,
      island_species = island_species
    ),
    regexp = "(Species)*(not in phylo)*(Galapagos_species)*(not be included)"
  )

  expect_false("Galapagos_species" %in% row.names(endemicity_status))
})

test_that("create_endemicity_status fails correctly with incorrect phylo", {
  finches_tree <- list()
  island_species <- data.frame(
    tip_labels = c(
      "C_fus", "C_hel", "C_oliv", "C_pal", "C_par", "C_pau", "C_psi", "G_con",
      "G_diff", "G_for", "G_ful", "G_mag", "G_scan", "G_sep", "P_cras"
    ),
    tip_endemicity_status = c(
      "endemic", "endemic", "endemic", "endemic", "endemic", "endemic",
      "endemic", "endemic", "endemic", "endemic", "endemic", "endemic",
      "endemic", "endemic", "endemic"
    )
  )
  expect_error(
    object = create_endemicity_status(
    phylo = finches_tree,
    island_species = island_species
  ), regexp = "The phylo object should be a 'phylo' or 'phylo4' object"
  )
})

test_that("create_endemicity_status fails correctly with incorrect island_species", {
  finches_tree <- ape::read.nexus(
    file = system.file("extdata", "Finches.tre", package = "DAISIEprep")
  )
  island_species <- data.frame()
  expect_error(
    object = create_endemicity_status(
      phylo = finches_tree,
      island_species = island_species
    )
  )
})
