#' Calculates the number of missing species to be assigned to each island clade
#' in the island_tbl object and assigns the missing species to them. In the case
#' that multiple genera are in an island clade and each have missing species
#' the number of missing species is summed. Currently the missing species
#' are assigned to the genus that first matches with the missing species table,
#' however a more biologically or stochastic assignment is in development.
#'
#' @inheritParams default_params_doc
#'
#' @return Object of Island_tbl class
#' @export
#'
#' @examples
#' \dontrun{
#'   #WIP
#' }
add_multi_missing_species <- function(missing_species,
                                      missing_genus,
                                      island_tbl) {

  for (i in seq_along(missing_genus)) {
    which_species <- which(
      missing_species$clade_name %in% missing_genus[[i]]
    )

    # if that clade contains a genus that has missing species then add missing
    # species to island_tbl
    if (length(which_species) > 0) {
      phylo_missing_species <- missing_species[which_species, ]

      # check if the species is endemic, if not do not add missing species
      if (island_tbl@island_tbl$status[i] == "endemic") {
        # add the number of missing species to the island tbl for those that
        # have been extracted already, sum up number of missing species if
        # there are multiple genera in a clade
        island_tbl <- add_missing_species(
          island_tbl = island_tbl,
          num_missing_species = sum(phylo_missing_species$missing_species),
          species_name = island_tbl@island_tbl$clade_name[i]
        )
      }
    }
  }

  # return island_tbl
  island_tbl
}
