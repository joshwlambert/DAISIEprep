#' Creates a name for a clade depending on whether all the species of the clade
#' have the same genus name or whether the clade is composed of multiple genera,
#' in which case it will create a unique clade name by concatinating the genus
#' names
#'
#' @inheritParams default_params_doc
#'
#' @return Character
extract_clade_name <- function(endemic_clade) {

  # get the names of the species in the clade
  species_names <- names(endemic_clade)

  # extract only the genus names
  split_species_names <- strsplit(x = species_names, split = "_")
  genus_names <- sapply(split_species_names, "[[", 1)

  # if all genus names match return the genus name else return combined name
  if (length(unique(genus_names)) == 1) {
    unique(genus_names)
  } else {
    paste(unique(genus_names), collapse = "_")
  }
}
