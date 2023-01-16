test_that("any_outgroup correctly identifies multi-species outgroup", {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(10)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                       "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "nonendemic", "not_present", "not_present",
                         "not_present", "not_present", "not_present",
                         "not_present", "not_present", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  expect_true(any_outgroup(phylod))
})

test_that("any_outgroup correctly identifies single species outgroup", {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(10)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                       "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "nonendemic", "nonendemic", "nonendemic",
                         "nonendemic", "nonendemic", "nonendemic",
                         "nonendemic", "nonendemic", "not_present")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  expect_true(any_outgroup(phylod))
})

test_that("any_outgroup correctly finds no outgroup", {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )
  phylo <- ape::rcoal(10)
  phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                       "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
  phylo <- phylobase::phylo4(phylo)
  endemicity_status <- c("endemic", "not_present", "nonendemic", "nonendemic",
                         "nonendemic", "not_present", "nonendemic",
                         "nonendemic", "nonendemic", "endemic")
  phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  expect_false(any_outgroup(phylod))
})
