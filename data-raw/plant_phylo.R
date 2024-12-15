## code to prepare `plant_phylo` dataset goes here

plant_phylo <- readRDS(
  file = system.file("extdata", "plant_phylo.rds", package = "DAISIEprep")
)
usethis::use_data(plant_phylo, overwrite = TRUE)
