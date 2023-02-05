## code to prepare `pyrocephalus_phylod` dataset goes here

pyrocephalus_tree <- ape::read.nexus(
  file = system.file("extdata", "Pyrocephalus.tre", package = "DAISIEprep")
)

pyrocephalus_tree <- phylobase::phylo4(pyrocephalus_tree)

pyrocephalus_island_species <- data.frame(
  tip_labels = c(
    "Pyrocephalus_rubinus_dubius_Galapagos_cas01",
    "Pyrocephalus_rubinus_dubius_Galapagos_cas13",
    "Pyrocephalus_rubinus_nanus_Galapagos_cas02_cas09_cas21",
    "Pyrocephalus_rubinus_nanus_Galapagos_cas03",
    "Pyrocephalus_rubinus_nanus_Galapagos_cas14",
    "Pyrocephalus_rubinus_nanus_Galapagos_cas15",
    "Pyrocephalus_rubinus_nanus_Galapagos_cas16_cas17_cas23",
    "Pyrocephalus_rubinus_nanus_Galapagos_cas19",
    "Pyrocephalus_rubinus_nanus_Galapagos_cas20",
    "Pyrocephalus_rubinus_nanus_Galapagos_cas22"
  ),
  tip_endemicity_status = c(
    "endemic", "endemic", "endemic", "endemic", "endemic", "endemic",
    "endemic", "endemic", "endemic", "endemic"
  )
)

pyrocephalus_endemicity_status <- create_endemicity_status(
  phylo = pyrocephalus_tree,
  island_species = pyrocephalus_island_species
)

pyrocephalus_phylod <- phylobase::phylo4d(
  pyrocephalus_tree, pyrocephalus_endemicity_status
)

# remove rubinus from pyrocephalus tip labels to treat subspecies as
# full species
phylobase::tipLabels(pyrocephalus_phylod) <- gsub(
  pattern = "rubinus_nanus",
  replacement = "nanus",
  x = phylobase::tipLabels(pyrocephalus_phylod)
)

phylobase::tipLabels(pyrocephalus_phylod) <- gsub(
  pattern = "rubinus_dubius",
  replacement = "dubius",
  x = phylobase::tipLabels(pyrocephalus_phylod)
)

pyrocephalus_phylod <- add_asr_node_states(
  phylod = pyrocephalus_phylod,
  asr_method = "parsimony",
  tie_preference = "mainland"
)

saveRDS(pyrocephalus_phylod, file = "inst/extdata/pyrocephalus_phylod.rds")
