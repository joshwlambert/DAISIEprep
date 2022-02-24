#' Checks whether all species given in the descendants vector are the same
#' species.
#'
#' @inheritParams default_params_doc
#'
#' @return Boolean
#' @export
#'
#' @examples
#' # Example where species are not conspecific
#' descendants <- c("bird_a", "bird_b", "bird_c")
#' all_descendants_conspecific(descendants = descendants)
#'
#' # Example where species are conspecific
#' descendants <- c("bird_a_1", "bird_a_2", "bird_a_3")
#' all_descendants_conspecific(descendants = descendants)
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
