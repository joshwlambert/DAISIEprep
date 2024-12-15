## code to prepare `mimus_phylod` dataset goes here

mimus_tree <- ape::read.nexus(
  file = system.file("extdata", "Mimus.tre", package = "DAISIEprep")
)

mimus_tree <- phylobase::phylo4(mimus_tree)

mimus_island_species <- data.frame(
  tip_labels = c(
    "Mimus_macdonaldi_GALAPAGOS_KF411075",
    "Mimus_melanotis_GALAPAGOS_KF411072",
    "Mimus_parvulus_GALAPAGOS_KF411077",
    "Mimus_trifasciatus_GALAPAGOS_KF411070"
  ),
  tip_endemicity_status = c("endemic", "endemic", "endemic", "endemic")
)

mimus_endemicity_status <- create_endemicity_status(
  phylo = mimus_tree,
  island_species = mimus_island_species
)

mimus_phylod <- phylobase::phylo4d(
  mimus_tree, mimus_endemicity_status
)

mimus_phylod <- add_asr_node_states(
  phylod = mimus_phylod,
  asr_method = "parsimony",
  tie_preference = "mainland"
)

usethis::use_data(mimus_phylod)
