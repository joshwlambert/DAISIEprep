## code to prepare `coccyzus_phylod` dataset goes here

coccyzus_tree <- ape::read.nexus(
  file = system.file("extdata", "Coccyzus.tre", package = "DAISIEprep")
)

coccyzus_tree <- as(coccyzus_tree, "phylo4")

coccyzus_endemicity_status <- data.frame(
  endemicity_status = c(
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "not_present", "not_present", "not_present", "not_present",
    "not_present", "not_present", "not_present", "nonendemic", "nonendemic"
  )
)
rownames(coccyzus_endemicity_status) <- c(
  "Coccyzus_americanus_AF204993",
  "Coccyzus_americanus_AY509696",
  "Coccyzus_americanus_HE793186",
  "Coccyzus_americanus_Mexico_AY046908",
  "Coccyzus_americanus_Mexico_AY046909",
  "Coccyzus_americanus_NewMexico_AY046905",
  "Coccyzus_americanus_U09265__CAU09265_",
  "Coccyzus_americanus_americanus_AY046910",
  "Coccyzus_americanus_americanus_Minnesota_AF249270",
  "Coccyzus_americanus_americanus_Minnesota_AF249271",
  "Coccyzus_americanus_occidentalis_Alaska_AF249268",
  "Coccyzus_americanus_occidentalis_Alaska_AF249269",
  "Coccyzus_americanus_occidentalis_NewMexico_AY046906",
  "Coccyzus_americanus_occidentalis_NewMexico_AY046907",
  "Coccyzus_erythropthalmus_AF082048",
  "Coccyzus_erythropthalmus_U09266__CEU09266_",
  "Coccyzus_erythropthalmus__Minnesota_AF249272",
  "Coccyzus_melacoryphus_Brasil_AF204994",
  "Coccyzus_melacoryphus_GALAPAGOS_L569A",
  "Coccyzus_melacoryphus_GALAPAGOS_L571A"
)

coccyzus_phylod <- phylobase::phylo4d(coccyzus_tree, coccyzus_endemicity_status)


saveRDS(coccyzus_phylod, file = "inst/extdata/coccyzus_phylod.rds")
