#' Loops through the genera that have missing species and removes the ones that
#' are found in the missing genus list which have phylogenetic data. This is
#' useful when wanting to know which missing species have not been assigned to
#' the island_tbl using `add_multi_missing_species()`.
#'
#' @inheritParams default_params_doc
#'
#' @return Data frame
#' @export
#'
#' @examples
#' \dontrun{
#'   #WIP
#' }
rm_multi_missing_species <- function(missing_species,
                                     missing_genus) {

  for (i in seq_along(missing_genus)) {
    which_species <- which(
      missing_species$clade_name %in% missing_genus[[i]]
    )

    # if that clade contains a genus that has missing species then add missing
    # species to island_tbl
    if (length(which_species) > 0) {

      # delete rows from missing_species
      missing_species <- missing_species[-which_species, ]
    }
  }

  # return missing_species
  missing_species
}
