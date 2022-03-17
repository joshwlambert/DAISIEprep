test_that("2 nonendemics, 3 species tree, sisters", {
  phylod <- create_test_phylod(test_scenario = 11)
  clade <- c(3, 1, 2)
  names(clade) <- c("bird_c", "bird_a", "bird_b")
  island_colonist <- extract_asr_clade(
    phylod = phylod,
    species_label = "bird_a",
    clade = clade,
    include_not_present = FALSE
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_a")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(
    get_branching_times(island_colonist),
    c(1.433370056817, 0.251727277709)
  )
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("2 nonendemics, 4 species tree, sister", {
  phylod <- create_test_phylod(test_scenario = 12)
  clade <- c(3, 4)
  names(clade) <- c("bird_c", "bird_d")
  island_colonist <- extract_asr_clade(
    phylod = phylod,
    species_label = "bird_c",
    clade = clade,
    include_not_present = FALSE
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_c")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(
    get_branching_times(island_colonist),
    c(0.665451291928, 0.125863638855)
  )
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("2 nonendemics, 4 species tree, non-sisters", {
  phylod <- create_test_phylod(test_scenario = 13)
  clade <- c(1, 2, 3, 4)
  names(clade) <- c("bird_a", "bird_b", "bird_c", "bird_d")
  island_colonist <- extract_asr_clade(
    phylod = phylod,
    species_label = "bird_b",
    clade = clade,
    include_not_present = FALSE
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_b")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(
    get_branching_times(island_colonist),
    c(0.665451291928, 0.519744565224)
  )
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("2 endemics, 3 species tree, sisters", {
  phylod <- create_test_phylod(test_scenario = 14)
  clade <- c(3, 1, 2)
  names(clade) <- c("bird_c", "bird_a", "bird_b")
  island_colonist <- extract_asr_clade(
    phylod = phylod,
    species_label = "bird_a",
    clade = clade,
    include_not_present = FALSE
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_a")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(
    get_branching_times(island_colonist),
    c(1.433370056817, 0.251727277709)
  )
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("2 endemics, 4 species tree, sisters", {
  phylod <- create_test_phylod(test_scenario = 15)
  clade <- c(3, 4)
  names(clade) <- c("bird_c", "bird_d")
  island_colonist <- extract_asr_clade(
    phylod = phylod,
    species_label = "bird_c",
    clade = clade,
    include_not_present = FALSE
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_c")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(
    get_branching_times(island_colonist),
    c(0.665451291928, 0.125863638855)
  )
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("2 endemics, 4 species tree, non-sisters", {
  phylod <- create_test_phylod(test_scenario = 16)
  clade <- c(1, 2, 3, 4)
  names(clade) <- c("bird_a", "bird_b", "bird_c", "bird_d")
  island_colonist <- extract_asr_clade(
    phylod = phylod,
    species_label = "bird_b",
    clade = clade,
    include_not_present = FALSE
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_b")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(
    get_branching_times(island_colonist),
    c(0.665451291928, 0.519744565224)
  )
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("2 nonendemics, 3 species tree, sisters, include_not_present", {
  phylod <- create_test_phylod(test_scenario = 11)
  clade <- c(3, 1, 2)
  names(clade) <- c("bird_c", "bird_a", "bird_b")
  island_colonist <- extract_asr_clade(
    phylod = phylod,
    species_label = "bird_a",
    clade = clade,
    include_not_present = TRUE
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_a")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(
    get_branching_times(island_colonist),
    c(1.433370056817, 0.251727277709)
  )
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("2 nonendemics, 4 species tree, sister, include_not_present", {
  phylod <- create_test_phylod(test_scenario = 12)
  clade <- c(3, 4)
  names(clade) <- c("bird_c", "bird_d")
  island_colonist <- extract_asr_clade(
    phylod = phylod,
    species_label = "bird_c",
    clade = clade,
    include_not_present = TRUE
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_c")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(
    get_branching_times(island_colonist),
    c(0.665451291928, 0.125863638855)
  )
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("2 nonendemics, 4 species tree, non-sisters, include_not_present", {
  phylod <- create_test_phylod(test_scenario = 13)
  clade <- c(1, 2, 3, 4)
  names(clade) <- c("bird_a", "bird_b", "bird_c", "bird_d")
  island_colonist <- extract_asr_clade(
    phylod = phylod,
    species_label = "bird_b",
    clade = clade,
    include_not_present = TRUE
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_b")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(
    get_branching_times(island_colonist),
    c(0.665451291928, 0.519744565224, 0.125863638855)
  )
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("2 endemics, 3 species tree, sisters, include_not_present", {
  phylod <- create_test_phylod(test_scenario = 14)
  clade <- c(3, 1, 2)
  names(clade) <- c("bird_c", "bird_a", "bird_b")
  island_colonist <- extract_asr_clade(
    phylod = phylod,
    species_label = "bird_a",
    clade = clade,
    include_not_present = TRUE
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_a")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(
    get_branching_times(island_colonist),
    c(1.433370056817, 0.251727277709)
  )
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("2 endemics, 4 species tree, sisters, include_not_present", {
  phylod <- create_test_phylod(test_scenario = 15)
  clade <- c(3, 4)
  names(clade) <- c("bird_c", "bird_d")
  island_colonist <- extract_asr_clade(
    phylod = phylod,
    species_label = "bird_c",
    clade = clade,
    include_not_present = TRUE
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_c")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(
    get_branching_times(island_colonist),
    c(0.665451291928, 0.125863638855)
  )
  expect_true(is.na(get_min_age(island_colonist)))
})

test_that("2 endemics, 4 species tree, non-sisters, include_not_present", {
  phylod <- create_test_phylod(test_scenario = 16)
  clade <- c(1, 2, 3, 4)
  names(clade) <- c("bird_a", "bird_b", "bird_c", "bird_d")
  island_colonist <- extract_asr_clade(
    phylod = phylod,
    species_label = "bird_b",
    clade = clade,
    include_not_present = TRUE
  )

  expect_s4_class(island_colonist, "Island_colonist")
  expect_equal(get_clade_name(island_colonist), "bird_b")
  expect_equal(get_status(island_colonist), "endemic")
  expect_equal(get_missing_species(island_colonist), 0)
  expect_equal(
    get_branching_times(island_colonist),
    c(0.665451291928, 0.519744565224, 0.125863638855)
  )
  expect_true(is.na(get_min_age(island_colonist)))
})
