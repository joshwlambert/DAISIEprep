test_that("0 nonendemic, 2 species tree, min algorithm", {
  phylod <- create_test_phylod(test_scenario = 0)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "nonendemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.755181833128)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("nonendemic singleton, 2 species tree, min algorithm", {
  phylod <- create_test_phylod(test_scenario = 1)
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "nonendemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.755181833128)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("nonendemic singleton, 2 species tree, asr algorithm", {
  set.seed(1)
  phylo <- ape::rcoal(2)
  phylo$tip.label <- c("bird_a", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "nonendemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "asr"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "nonendemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.755181833128)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("nonendemic singleton, 3 species tree, min algorithm, outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "not_present", "nonendemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_c")
  expect_equal(get_island_tbl(island_tbl)$status, "nonendemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(1.43337005682)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("nonendemic singleton, 3 species tree, asr algorithm, outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "not_present", "nonendemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "asr"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_c")
  expect_equal(get_island_tbl(island_tbl)$status, "nonendemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(1.43337005682)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("nonendemic singleton, 3 species tree, min algorithm, non-outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "nonendemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "nonendemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.251727277709)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("nonendemic singleton, 3 species tree, asr algorithm, non-outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "nonendemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "asr"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "nonendemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.251727277709)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("nonendemic singleton, 4 species tree, min algorithm, outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("nonendemic", "not_present","not_present",
                         "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_a")
  expect_equal(get_island_tbl(island_tbl)$status, "nonendemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.665451291928)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("nonendemic singleton, 4 species tree, asr algorithm, outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("nonendemic", "not_present", "not_present",
                         "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "asr"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_a")
  expect_equal(get_island_tbl(island_tbl)$status, "nonendemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.665451291928)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("nonendemic singleton, 4 species tree, min algorithm, non-outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "nonendemic", "not_present",
                         "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "nonendemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.519744565224)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("nonendemic singleton, 4 species tree, asr algorithm, non-outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "nonendemic", "not_present",
                         "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "asr"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "nonendemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.519744565224)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("endemic singleton, 2 species tree, min algorithm", {
  set.seed(1)
  phylo <- ape::rcoal(2)
  phylo$tip.label <- c("bird_a", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "endemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.755181833128)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("endemic singleton, 2 species tree, asr algorithm", {
  set.seed(1)
  phylo <- ape::rcoal(2)
  phylo$tip.label <- c("bird_a", "bird_b")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "endemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "asr"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.755181833128)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("endemic singleton, 3 species tree, min algorithm, outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "not_present", "endemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_c")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(1.43337005682)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("endemic singleton, 3 species tree, asr algorithm, outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "not_present", "endemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "asr"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_c")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(1.43337005682)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("endemic singleton, 3 species tree, min algorithm, non-outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.251727277709)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("endemic singleton, 3 species tree, asr algorithm, non-outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "asr"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.251727277709)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("endemic singleton, 4 species tree, min algorithm, outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "not_present","not_present",
                         "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_a")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.665451291928)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("endemic singleton, 4 species tree, asr algorithm, outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "not_present", "not_present",
                         "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "asr"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_a")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.665451291928)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("endemic singleton, 4 species tree, min algorithm, non-outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "endemic", "not_present",
                         "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.519744565224)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("endemic singleton, 4 species tree, asr algorithm, non-outgroup", {
  set.seed(1)
  phylo <- ape::rcoal(4)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("not_present", "endemic", "not_present",
                         "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "asr"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(0.519744565224)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("2 endemics, 3 species tree, min algorithm, sister species", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "min"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_a")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(1.433370056817, 0.251727277709)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

test_that("2 endemics, 3 species tree, asr algorithm, sister species", {
  set.seed(1)
  phylo <- ape::rcoal(3)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "endemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  island_tbl <- extract_island_species(
    phylod = phylod,
    extraction_method = "asr"
  )

  expect_s4_class(island_tbl, "Island_tbl")
  expect_true(is.data.frame(get_island_tbl(island_tbl)))
  expect_equal(
    colnames(get_island_tbl(island_tbl)),
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_a")
  expect_equal(get_island_tbl(island_tbl)$status, "endemic")
  expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
  expect_equal(
    get_island_tbl(island_tbl)$branching_times,
    I(list(c(1.433370056817, 0.251727277709)))
  )
  expect_true(is.na(get_island_tbl(island_tbl)$min_age))
})

#
# test_that("endemic singleton, 4 species tree, min algorithm, outgroup", {
#   set.seed(1)
#   phylo <- ape::rcoal(4)
#   phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
#   phylo <- phylobase::phylo4(phylo)
#   endemicity_status <- c("endemic", "not_present","not_present",
#                          "not_present")
#   phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#   island_tbl <- extract_island_species(
#     phylod = phylod,
#     extraction_method = "min"
#   )
#
#   expect_s4_class(island_tbl, "Island_tbl")
#   expect_true(is.data.frame(get_island_tbl(island_tbl)))
#   expect_equal(
#     colnames(get_island_tbl(island_tbl)),
#     c("clade_name", "status", "missing_species", "branching_times", "min_age")
#   )
#   expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_a")
#   expect_equal(get_island_tbl(island_tbl)$status, "endemic")
#   expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
#   expect_equal(
#     get_island_tbl(island_tbl)$branching_times,
#     I(list(c(0.665451291928)))
#   )
#   expect_true(is.na(get_island_tbl(island_tbl)$min_age))
# })
#
# test_that("endemic singleton, 4 species tree, asr algorithm, outgroup", {
#   set.seed(1)
#   phylo <- ape::rcoal(4)
#   phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
#   phylo <- phylobase::phylo4(phylo)
#   endemicity_status <- c("endemic", "not_present", "not_present",
#                          "not_present")
#   phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#   phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
#   island_tbl <- extract_island_species(
#     phylod = phylod,
#     extraction_method = "asr"
#   )
#
#   expect_s4_class(island_tbl, "Island_tbl")
#   expect_true(is.data.frame(get_island_tbl(island_tbl)))
#   expect_equal(
#     colnames(get_island_tbl(island_tbl)),
#     c("clade_name", "status", "missing_species", "branching_times", "min_age")
#   )
#   expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_a")
#   expect_equal(get_island_tbl(island_tbl)$status, "endemic")
#   expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
#   expect_equal(
#     get_island_tbl(island_tbl)$branching_times,
#     I(list(c(0.665451291928)))
#   )
#   expect_true(is.na(get_island_tbl(island_tbl)$min_age))
# })
#
# test_that("endemic singleton, 4 species tree, min algorithm, non-outgroup", {
#   set.seed(
#     1,
#     kind = "Mersenne-Twister",
#     normal.kind = "Inversion",
#     sample.kind = "Rejection"
#   )
#   phylo <- ape::rcoal(4)
#   phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
#   phylo <- phylobase::phylo4(phylo)
#   endemicity_status <- c("not_present", "endemic", "not_present",
#                          "not_present")
#   phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#   island_tbl <- extract_island_species(
#     phylod = phylod,
#     extraction_method = "min"
#   )
#
#   expect_s4_class(island_tbl, "Island_tbl")
#   expect_true(is.data.frame(get_island_tbl(island_tbl)))
#   expect_equal(
#     colnames(get_island_tbl(island_tbl)),
#     c("clade_name", "status", "missing_species", "branching_times", "min_age")
#   )
#   expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
#   expect_equal(get_island_tbl(island_tbl)$status, "endemic")
#   expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
#   expect_equal(
#     get_island_tbl(island_tbl)$branching_times,
#     I(list(c(0.519744565224)))
#   )
#   expect_true(is.na(get_island_tbl(island_tbl)$min_age))
# })
#
# test_that("endemic singleton, 4 species tree, asr algorithm, non-outgroup", {
#   set.seed(
#     1,
#     kind = "Mersenne-Twister",
#     normal.kind = "Inversion",
#     sample.kind = "Rejection"
#   )
#   phylo <- ape::rcoal(4)
#   phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
#   phylo <- phylobase::phylo4(phylo)
#   endemicity_status <- c("not_present", "endemic", "not_present",
#                          "not_present")
#   phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#   phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
#   island_tbl <- extract_island_species(
#     phylod = phylod,
#     extraction_method = "asr"
#   )
#
#   expect_s4_class(island_tbl, "Island_tbl")
#   expect_true(is.data.frame(get_island_tbl(island_tbl)))
#   expect_equal(
#     colnames(get_island_tbl(island_tbl)),
#     c("clade_name", "status", "missing_species", "branching_times", "min_age")
#   )
#   expect_equal(get_island_tbl(island_tbl)$clade_name, "bird_b")
#   expect_equal(get_island_tbl(island_tbl)$status, "endemic")
#   expect_equal(get_island_tbl(island_tbl)$missing_species, 0)
#   expect_equal(
#     get_island_tbl(island_tbl)$branching_times,
#     I(list(c(0.519744565224)))
#   )
#   expect_true(is.na(get_island_tbl(island_tbl)$min_age))
# })
#

