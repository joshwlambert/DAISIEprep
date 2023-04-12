#' Creates phylod objects.
#'
#' @description A helper function that is useful in tests and examples to
#' easily create `phylod` objects (i.e. phylogenetic trees with data).
#'
#' @inheritParams default_params_doc
#'
#' @return A `phylo4d` object
#' @export
#'
#' @examples
#' create_test_phylod(test_scenario = 1)
create_test_phylod <- function(test_scenario) {
  set.seed(
    1,
    kind = "Mersenne-Twister",
    normal.kind = "Inversion",
    sample.kind = "Rejection"
  )

  if (test_scenario == 0) {
    # no species on island, 2 species tree
    phylo <- ape::rcoal(2)
    phylo$tip.label <- c("bird_a", "bird_b")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "not_present")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
  }

  if (test_scenario == 1) {
    # 1 nonendemic, 2 species tree
    phylo <- ape::rcoal(2)
    phylo$tip.label <- c("bird_a", "bird_b")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "nonendemic")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 2) {
    # 1 nonendemic, 3 species tree, outgroup
    phylo <- ape::rcoal(3)
    phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "not_present", "nonendemic")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 3) {
    # 1 nonendemic, 3 species tree, non-outgroup
    phylo <- ape::rcoal(3)
    phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "nonendemic", "not_present")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 4) {
    # 1 nonendemic, 4 species tree, outgroup
    phylo <- ape::rcoal(4)
    phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("nonendemic", "not_present", "not_present",
                           "not_present")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 5) {
    # 1 nonendemic, 4 species tree, non-outgroup
    phylo <- ape::rcoal(4)
    phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "nonendemic", "not_present",
                           "not_present")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 6) {
    # 1 endemic, 2 species tree
    phylo <- ape::rcoal(2)
    phylo$tip.label <- c("bird_a", "bird_b")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "endemic")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 7) {
    # 1 endemic, 3 species tree, outgroup
    phylo <- ape::rcoal(3)
    phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "not_present", "endemic")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 8) {
    # 1 endemic, 3 species tree, non-outgroup
    phylo <- ape::rcoal(3)
    phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "endemic", "not_present")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 9) {
    # 1 endemic, 4 species tree, outgroup
    phylo <- ape::rcoal(4)
    phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("endemic", "not_present", "not_present",
                           "not_present")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 10) {
    # 1 endemic, 4 species tree, non-outgroup
    phylo <- ape::rcoal(4)
    phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "endemic", "not_present",
                           "not_present")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 11) {
    # 2 nonendemics, 3 species tree, sisters
    phylo <- ape::rcoal(3)
    phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("nonendemic", "nonendemic", "not_present")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 12) {
    # 2 nonendemics, 4 species tree, sisters
    phylo <- ape::rcoal(4)
    phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "not_present", "nonendemic",
                           "nonendemic")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 13) {
    # 2 nonendemics, 4 species tree, non-sisters
    phylo <- ape::rcoal(4)
    phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "nonendemic", "not_present",
                           "nonendemic")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 14) {
    # 2 endemics, 3 species tree, sisters
    phylo <- ape::rcoal(3)
    phylo$tip.label <- c("bird_a", "bird_b", "bird_c")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("endemic", "endemic", "not_present")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 15) {
    # 2 endemics, 4 species tree, sisters
    phylo <- ape::rcoal(4)
    phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "not_present", "endemic",
                           "endemic")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  if (test_scenario == 16) {
    # 2 endemics, 4 species tree, non-sisters
    phylo <- ape::rcoal(4)
    phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d")
    phylo <- phylobase::phylo4(phylo)
    endemicity_status <- c("not_present", "endemic", "not_present",
                           "endemic")
    phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
    phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
  }

  # return phylod
  phylod
}
