#' Removes an island colonist from an `Island_tbl` object
#'
#' @inheritParams default_params_doc
#'
#' @return Object of `Island_tbl` class
#' @export
#'
#' @examples
#' phylod <- DAISIEprep:::create_test_phylod(test_scenario = 1)
#' island_tbl <- extract_island_species(
#'   phylod = phylod,
#'   extraction_method = "min"
#' )
#' island_tbl <- rm_island_colonist(
#'   island_tbl = island_tbl,
#'   clade_name = "bird_b"
#' )
rm_island_colonist <- function(island_tbl,
                               clade_name) {

  # get the data frame from the island_tbl class
  island_tbl_df <- get_island_tbl(island_tbl)

  # remove the clade specified
  island_tbl_df <- island_tbl_df[-grep(clade_name, island_tbl_df$clade_name), ]

  # put new island tbl data frame into island_tbl class
  set_island_tbl(island_tbl) <- island_tbl_df

  # return the class
  island_tbl
}
