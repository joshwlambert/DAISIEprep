#' This is a wrapper function for DAISIE::DAISIE_dataprep(). It allows the
#' final DAISIE data structure to be produced from within DAISIEprep. For
#' detailed documentation see the help documentation in the DAISIE package
#' (?DAISIE::DAISIE_dataprep).
#'
#' @param island_tbl
#' @param island_age
#' @param num_mainland_species
#' @param num_clade_types
#' @param list_type2_clades
#' @param prop_type2_pool
#' @param epss
#' @param verbose
#'
#' @return DAISIE data list
#' @export
#'
#' @examples
create_daisie_data <- function(island_tbl,
                               island_age,
                               num_mainland_species,
                               num_clade_types,
                               list_type2_clades,
                               prop_type2_pool,
                               epss,
                               verbose) {
  DAISIE::DAISIE_dataprep(
    datatable = datatable,
    island_age = island_age,
    M = num_mainland_species,
    number_clade_types = num_clade_types,
    list_type2_clades = list_type2_caldes,
    prop_type2_pool = prop_type2_pool,
    epss = epss,
    verbose = verbose)
}
