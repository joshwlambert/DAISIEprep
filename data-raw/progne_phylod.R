## code to prepare `progne_phylod` dataset goes here

progne_tree <- ape::read.nexus(
  file = system.file("extdata", "Progne.tre", package = "DAISIEprep")
)

usethis::use_data(progne_tree)

progne_tree <- phylobase::phylo4(progne_tree)

progne_island_species <- data.frame(
  tip_labels = c("Progne_modesta_GALAPAGOS_L573A",
                 "Progne_modesta_GALAPAGOS_L574A"),
  tip_endemicity_status = c("endemic", "endemic")
)

progne_endemicity_status <- create_endemicity_status(
  phylo = progne_tree,
  island_species = progne_island_species
)

progne_phylod <- phylobase::phylo4d(progne_tree, progne_endemicity_status)

progne_phylod <- add_asr_node_states(
  phylod = progne_phylod,
  asr_method = "parsimony",
  tie_preference = "mainland"
)

usethis::use_data(progne_phylod)
