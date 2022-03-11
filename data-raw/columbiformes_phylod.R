## code to prepare `columbiformes_phylod` dataset goes here

columbiformes_tree <- ape::read.nexus(
  file = system.file("extdata", "Columbiformes.tre", package = "DAISIEprep")
)

columbiformes_tree <- phylobase::phylo4(columbiformes_tree)

columbiformes_island_species <- data.frame(
  tip_labels = c("Zenaida_galapagoensis_GALAPAGOS_AF251531",
                 "Zenaida_galapagoensis_GALAPAGOS_F182701"),
  tip_endemicity_status = c("endemic", "endemic")
)

columbiformes_endemicity_status <- create_endemicity_status(
  phylo = columbiformes_tree,
  island_species = columbiformes_island_species
)

columbiformes_phylod <- phylobase::phylo4d(
  columbiformes_tree,
  columbiformes_endemicity_status
)

saveRDS(columbiformes_phylod, file = "inst/extdata/columbiformes_phylod.rds")
