test_that("sensitivity works as expected for min", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rphylo(n = 100, birth = 1, death = 0)
  phylo$tip.label <- gsub(
    pattern = "^t", replacement = "t_", x = phylo$tip.label
  )
  island_species <- data.frame(
    tip_labels = sample(x = phylo$tip.label, size = 20, replace = FALSE),
    tip_endemicity_status = sample(
      x = c("nonendemic", "endemic"), size = 20, replace = TRUE
    )
  )
  phylo <- add_outgroup(phylo)
  sens <- sensitivity(
    phylo = phylo,
    island_species = island_species,
    extraction_method = "min",
    asr_method = NA,
    tie_preference = NA,
    island_age = 1,
    num_mainland_species = 100
  )

  expect_type(sens, "list")
  expect_identical(dim(sens), c(5L, 5L))
  expect_identical(
    colnames(sens),
    c("extraction_method", "asr_method", "tie_preference",
      "parameter", "rates")
  )
})

test_that("sensitivity works as expected for asr", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rphylo(n = 100, birth = 1, death = 0)
  phylo$tip.label <- gsub(
    pattern = "^t", replacement = "t_", x = phylo$tip.label
  )
  island_species <- data.frame(
    tip_labels = sample(x = phylo$tip.label, size = 20, replace = FALSE),
    tip_endemicity_status = sample(
      x = c("nonendemic", "endemic"), size = 20, replace = TRUE
    )
  )
  phylo <- add_outgroup(phylo)
  sens <- sensitivity(
    phylo = phylo,
    island_species = island_species,
    extraction_method = "asr",
    asr_method = "parsimony",
    tie_preference = "island",
    island_age = 1,
    num_mainland_species = 100
  )

  expect_type(sens, "list")
  expect_identical(dim(sens), c(5L, 5L))
  expect_identical(
    colnames(sens),
    c("extraction_method", "asr_method", "tie_preference",
      "parameter", "rates")
  )
})

test_that("sensitivity works as expected for multiple parameter settings", {
  skip_if(Sys.getenv("CI") == "", message = "Run only on CI")
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rphylo(n = 100, birth = 1, death = 0)
  phylo$tip.label <- gsub(
    pattern = "^t", replacement = "t_", x = phylo$tip.label
  )
  island_species <- data.frame(
    tip_labels = sample(x = phylo$tip.label, size = 20, replace = FALSE),
    tip_endemicity_status = sample(
      x = c("nonendemic", "endemic"), size = 20, replace = TRUE
    )
  )
  phylo <- add_outgroup(phylo)
  sens <- sensitivity(
    phylo = phylo,
    island_species = island_species,
    extraction_method = c("min", "asr"),
    asr_method = c("parsimony"),
    tie_preference = c("island"),
    island_age = 1,
    num_mainland_species = 100
  )

  expect_type(sens, "list")
  expect_identical(dim(sens), c(10L, 5L))
  expect_identical(
    colnames(sens),
    c("extraction_method", "asr_method", "tie_preference",
      "parameter", "rates")
  )
})
