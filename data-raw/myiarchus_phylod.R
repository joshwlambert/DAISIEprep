## code to prepare `myiarchus_phylod` dataset goes here

myiarchus_tree <- ape::read.nexus(
  file = system.file("extdata", "Myiarchus.tre", package = "DAISIEprep")
)

myiarchus_tree <- phylobase::phylo4(myiarchus_tree)

# the names do not conform to the format required as the molecular markers are
# not separated from the species name by an underscore so we insert an
# underscore
phylobase::tipLabels(myiarchus_tree) <- gsub(
  pattern = "magnirostris",
  replacement = "magnirostris_",
  x = phylobase::tipLabels(myiarchus_tree)
)

phylobase::tipLabels(myiarchus_tree) <- gsub(
  pattern = "tyrannulus",
  replacement = "tyrannulus_",
  x = phylobase::tipLabels(myiarchus_tree)
)

myiarchus_island_species <- data.frame(
  tip_labels = c("M_magnirostris_1", "M_magnirostris_2", "M_magnirostris_3",
                 "M_magnirostris_4", "M_magnirostris_5"),
  tip_endemicity_status = c("endemic", "endemic", "endemic", "endemic",
                            "endemic")
)

myiarchus_endemicity_status <- create_endemicity_status(
  phylo = myiarchus_tree,
  island_species = myiarchus_island_species
)

myiarchus_phylod <- phylobase::phylo4d(
  myiarchus_tree, myiarchus_endemicity_status
)

myiarchus_phylod <- add_asr_node_states(
  phylod = myiarchus_phylod,
  asr_method = "parsimony",
  tie_preference = "mainland"
)

usethis::use_data(myiarchus_phylod)
