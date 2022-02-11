## code to prepare `setophaga_phylod` dataset goes here

setophaga_tree <- ape::read.nexus(
  file = system.file("extdata", "Setophaga.tre", package = "DAISIEprep")
)

setophaga_tree <- methods::as(setophaga_tree, "phylo4")

# the names do not conform to the format required as there are also a couple of
# species that have the molecular marker before the species name so this needs
# to be reversed
phylobase::tipLabels(setophaga_tree) <- gsub(
  pattern = "([A-z]+)_([0-9]+)_+(.+)$",
  replacement = "\\1_\\3_\\2",
  x =  phylobase::tipLabels(setophaga_tree)
)


setophaga_island_species <- data.frame(
  tip_labels = c(
    "D_petechia_Galapagos_sancris",
    "D_petechia_Galapagos_santacruz"
  ),
  tip_endemicity_status = c("nonendemic", "nonendemic")
)


setophaga_endemicity_status <- create_endemicity_status(
  phylo = setophaga_tree,
  island_species = setophaga_island_species
)

setophaga_phylod <- phylobase::phylo4d(
  setophaga_tree, setophaga_endemicity_status
)

saveRDS(myiarchus_phylod, file = "inst/extdata/setophaga_phylod.rds")
