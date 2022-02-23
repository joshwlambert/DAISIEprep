#' Checks whether all species given in the descendants vector are the same
#' species.
#'
#' @inheritParams default_params_doc
#'
#' @return Boolean
#' @export
#'
#' @examples
all_descendants_conspecific <- function(descendants) {

  # get the species names (genus_species) for sister species
  split_species_names <- strsplit(x = descendants, split = "_")
  genus_name <- sapply(split_species_names, "[[", 1)
  species_name <- sapply(split_species_names, "[[", 2)
  genus_species_name <- paste(genus_name, species_name, sep = "_")
  all_descendants_conspecific <- length(unique(genus_species_name)) == 1

  # return all_descendants_conspecific
  all_descendants_conspecific
}
