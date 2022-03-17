#' This is a wrapper function for DAISIE::DAISIE_dataprep(). It allows the
#' final DAISIE data structure to be produced from within DAISIEprep. For
#' detailed documentation see the help documentation in the DAISIE package
#' (?DAISIE::DAISIE_dataprep).
#'
#' @inheritParams default_params_doc
#'
#' @return DAISIE data list
#' @export
#'
#' @examples
#' \dontrun{
#' island_tbl <- extract_island_specie()
#' daisie_datatable <- as_daisie_datatable(island_tbl)
#' daisie_data_list <- create_daisie_data(
#'   daisie_datatable = daisie_datatable,
#'   island_age = 1,
#'   num_mainland_species = 1000,
#'   num_clade_types = 1,
#'   list_type2_clades = NA,
#'   prop_type2_pool = NA,
#'   epss = 1e-5,
#'   verbose = FALSE
#' )
#' }
create_daisie_data <- function(daisie_datatable,
                               island_age,
                               num_mainland_species,
                               num_clade_types = 1,
                               list_type2_clades = NA,
                               prop_type2_pool = "proportional",
                               epss = 1e-5,
                               verbose = FALSE) {

  DAISIE::DAISIE_dataprep(
    datatable = daisie_datatable,
    island_age = island_age,
    M = num_mainland_species,
    number_clade_types = num_clade_types,
    list_type2_clades = list_type2_clades,
    prop_type2_pool = prop_type2_pool,
    epss = epss,
    verbose = verbose)

}
