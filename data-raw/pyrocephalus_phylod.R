## code to prepare `pyrocephalus_phylod` dataset goes here

pyrocephalus_tree <- ape::read.nexus(
  file = system.file("extdata", "Pyrocephalus.tre", package = "DAISIEprep")
)

pyrocephalus_tree <- methods::as(pyrocephalus_tree, "phylo4")

pyrocephalus_endemicity_status <- data.frame(
  endemicity_status = c(
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "not_present", "not_present", "endemic", "endemic",
    "endemic", "not_present", "not_present", "not_present", "endemic",
    "endemic", "endemic", "endemic", "endemic", "endemic", "endemic"
  )
)
rownames(pyrocephalus_endemicity_status) <- c(
  "Pyrocephalus_rubinus_rubinus_Argentina_B01",
  "Pyrocephalus_rubinus_rubinus_Argentina_B02",
  "Pyrocephalus_rubinus_rubinus_Argentina_B03",
  "Pyrocephalus_rubinus_rubinus_Bolivia_B04",
  "Pyrocephalus_rubinus_rubinus_Bolivia_B05",
  "Pyrocephalus_rubinus_B06_B09_S15_S16",
  "Pyrocephalus_rubinus_flammeus_Arizona_B07",
  "Pyrocephalus_rubinus_flammeus_Arizona_B08",
  "Pyrocephalus_rubinus_flammeus_Arizona_B10",
  "Pyrocephalus_rubinus_flammeus_Arizona_B11",
  "Fluvicola_pica_B12_Y5",
  "Gubernetes_yetapa_B13_Gy",
  "Pyrocephalus_rubinus_saturatus_Venezuela_C1",
  "Pyrocephalus_rubinus_ardens_Peru_F1_F2",
  "Pyrocephalus_rubinus_ardens_Peru_F3",
  "Pyrocephalus_rubinus_obscurus_Peru_M01_M04",
  "Pyrocephalus_rubinus_obscurus_Peru_M02",
  "Pyrocephalus_rubinus_obscurus_Peru_M03",
  "Pyrocephalus_rubinus_obscurus_Peru_M05",
  "Pyrocephalus_rubinus_obscurus_Peru_M06",
  "Pyrocephalus_rubinus_M07_M12_M14_M21",
  "Pyrocephalus_rubinus_piurae_Peru_M08",
  "Pyrocephalus_rubinus_piurae_Peru_M09",
  "Pyrocephalus_rubinus_piurae_Peru_M10",
  "Pyrocephalus_rubinus_piurae_Peru_M11",
  "Pyrocephalus_rubinus_Peru_M13",
  "Pyrocephalus_rubinus_flammeus_NewMexico_M15_M16",
  "Pyrocephalus_rubinus_flammeus_NewMexico_M18",
  "Pyrocephalus_rubinus_flammeus_NewMexico_M19",
  "Pyrocephalus_rubinus_obscurus_Peru_M20",
  "Pyrocephalus_rubinus_piurae_Peru_M22",
  "Pyrocephalus_rubinus_cocachacrae_Peru_M23",
  "Pyrocephalus_rubinus_cocachacrae_Peru_M24",
  "Pyrocephalus_rubinus_cocachacrae_Peru_M25",
  "Pyrocephalus_rubinus_rubinus_Peru_M26",
  "Pyrocephalus_rubinus_rubinus_Peru_M27",
  "Pyrocephalus_rubinus_rubinus_Argentina_S01",
  "Pyrocephalus_rubinus_rubinus_Uruguay_S02",
  "Pyrocephalus_rubinus_rubinus_Uruguay_S03",
  "Pyrocephalus_rubinus_saturatus_S04_S06_S09_S11",
  "Pyrocephalus_rubinus_saturatus_Guyana_S05",
  "Pyrocephalus_rubinus_saturatus_Guyana_S07",
  "Pyrocephalus_rubinus_saturatus_Guyana_S08",
  "Pyrocephalus_rubinus_saturatus_Guyana_S10",
  "Pyrocephalus_rubinus_rubinus_Uruguay_S12",
  "Pyrocephalus_rubinus_rubinus_Guyana_S13",
  "Pyrocephalus_rubinus_S14",
  "Arundinicola_leucocephala_Suriname_Y1",
  "Arundinicola_leucocephala_Suriname_Y2",
  "Arundinicola_leucocephala_Suriname_Y3",
  "Arundinicola_leucocephala_Suriname_Y4",
  "Pyrocephalus_rubinus_rubinus_Uruguay_Y6",
  "Pyrocephalus_rubinus_rubinus_Uruguay_Y7",
  "Pyrocephalus_rubinus_dubius_Galapagos_cas01",
  "Pyrocephalus_rubinus_nanus_Galapagos_cas02_cas09_cas21",
  "Pyrocephalus_rubinus_nanus_Galapagos_cas03",
  "Pyrocephalus_rubinus_mexicanus_Mexico_cas04",
  "Pyrocephalus_rubinus_mexicanus_Mexico_cas05",
  "Pyrocephalus_rubinus_mexicanus_Mexico_cas10_M17",
  "Pyrocephalus_rubinus_dubius_Galapagos_cas13",
  "Pyrocephalus_rubinus_nanus_Galapagos_cas14",
  "Pyrocephalus_rubinus_nanus_Galapagos_cas15",
  "Pyrocephalus_rubinus_nanus_Galapagos_cas16_cas17_cas23",
  "Pyrocephalus_rubinus_nanus_Galapagos_cas19",
  "Pyrocephalus_rubinus_nanus_Galapagos_cas20",
  "Pyrocephalus_rubinus_nanus_Galapagos_cas22"
)

# write code that removes the rubinus from the middle of pyrocephalus tip labels
# this is in order to treat subspecies as full species

pyrocephalus_phylod <- phylobase::phylo4d(
  pyrocephalus_tree, pyrocephalus_endemicity_status
)

island_tbl_before <- extract_island_species(phylod = pyrocephalus_phylod)

phylobase::tipLabels(pyrocephalus_phylod) <- gsub(
  pattern = "rubinus_",
  replacement = "",
  x = phylobase::tipLabels(pyrocephalus_phylod)
)

island_tbl_after <- extract_island_species(phylod = pyrocephalus_phylod)

ggtree::ggtree(pyrocephalus_phylod) +
  ggtree::geom_tippoint(
    ggplot2::aes(colour = endemicity_status),
    size = 3
  )

saveRDS(pyrocephalus_phylod, file = "inst/extdata/pyrocephalus_phylod.rds")
