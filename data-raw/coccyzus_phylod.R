## code to prepare `coccyzus_phylod` dataset goes here

coccyzus_tree <- ape::read.nexus(
  file = system.file("extdata", "Coccyzus.tre", package = "DAISIEprep")
)

coccyzus_tree <- phylobase::phylo4(coccyzus_tree)

coccyzus_island_species <- data.frame(
  tip_labels = c("Coccyzus_melacoryphus_GALAPAGOS_L569A",
                 "Coccyzus_melacoryphus_GALAPAGOS_L571A"),
  tip_endemicity_status = c("nonendemic", "nonendemic")
)

coccyzus_endemicity_status <- create_endemicity_status(
  phylo = coccyzus_tree,
  island_species = coccyzus_island_species
)

coccyzus_phylod <- phylobase::phylo4d(coccyzus_tree, coccyzus_endemicity_status)

coccyzus_phylod <- add_asr_node_states(
  phylod = coccyzus_phylod,
  asr_method = "parsimony",
  tie_preference = "mainland"
)

usethis::use_data(coccyzus_phylod)
