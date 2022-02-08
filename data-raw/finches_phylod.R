## code to prepare `finches_phylod` dataset goes here

finches_tree <- ape::read.nexus(
  file = system.file("extdata", "Finches.tre", package = "DAISIEprep")
)

finches_tree <- as(finches_tree, "phylo4")

# remove the Cocos finch, Pinaroloxias inornata (P_ino) as it is not on the
# Galapagos
finches_tree <- phylobase::subset(x = finches_tree, tips.exclude = "P_ino")

finches_endemicity_status <- data.frame(
  endemicity_status = c(
    "endemic", "endemic", "endemic", "endemic", "endemic", "endemic", "endemic",
    "endemic", "endemic", "endemic", "endemic", "endemic", "endemic", "endemic",
    "endemic", "endemic"
  )
)
rownames(finches_endemicity_status) <- c(
  "C_fus", "C_hel", "C_oliv", "C_pal", "C_par", "C_pau", "C_psi", "G_con",
  "G_diff", "G_for", "G_ful", "G_mag", "G_scan", "G_sep", "P_cras", "T_bi"
)

finches_phylod <- phylobase::phylo4d(finches_tree, finches_endemicity_status)

island_tbl <- extract_island_species(phylod = finches_phylod)

saveRDS(coccyzus_phylod, file = "inst/extdata/coccyzus_phylod.rds")
