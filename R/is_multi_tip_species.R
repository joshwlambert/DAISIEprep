is_multi_tip_species <- function(phylod, species_label) {

  # get the species name (genus_species) from the focal species
  focal_split_species_names <- strsplit(x = species_label, split = "_")
  focal_genus_name <- sapply(focal_split_species_names, "[[", 1)
  focal_species_name <- sapply(focal_split_species_names, "[[", 2)
  focal_genus_species_name <- paste(
    focal_genus_name, focal_species_name, sep = "_"
  )

  # get the species names (genus_species) for all species
  split_species_names <- strsplit(x = phylod@label, split = "_")
  genus_name <- sapply(split_species_names, "[[", 1)
  species_name <- sapply(split_species_names, "[[", 2)
  genus_species_name <- paste(genus_name, species_name, sep = "_")

  # count number of matches for species name
  num_species_tip <- sum(focal_genus_species_name == genus_species_name)

  # if number of matches is greater than 1 (it will match with itself)
  if (num_species_tip > 1) {
    TRUE
  } else {
    FALSE
  }
}
