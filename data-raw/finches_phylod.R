## code to prepare `finches_phylod` dataset goes here

finches_tree <- ape::read.nexus(
  file = system.file("extdata", "Finches.tre", package = "DAISIEprep")
)

finches_tree <- phylobase::phylo4(finches_tree)

# remove the Cocos finch, Pinaroloxias inornata (P_ino) as it is not on the
# Galapagos
finches_tree <- phylobase::subset(x = finches_tree, tips.exclude = "P_ino")

finches_island_species <- data.frame(
  tip_labels = c(
    "C_fus", "C_hel", "C_oliv", "C_pal", "C_par", "C_pau", "C_psi", "G_con",
    "G_diff", "G_for", "G_ful", "G_mag", "G_scan", "G_sep", "P_cras"
  ),
  tip_endemicity_status = c(
    "endemic", "endemic", "endemic", "endemic", "endemic", "endemic", "endemic",
    "endemic", "endemic", "endemic", "endemic", "endemic", "endemic", "endemic",
    "endemic"
  )
)

finches_endemicity_status <- create_endemicity_status(
  phylo = finches_tree,
  island_species = finches_island_species
)

finches_phylod <- phylobase::phylo4d(finches_tree, finches_endemicity_status)

saveRDS(coccyzus_phylod, file = "inst/extdata/finches_phylod.rds")
