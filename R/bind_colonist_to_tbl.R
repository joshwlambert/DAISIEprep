#' Takes an existing instance of an `Island_tbl` class and bind the information
#' from the instance of an `Island_colonist` class to it
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `Island_tbl` class
#' @export
#'
#' @examples
#' island_colonist <- DAISIEprep::island_colonist(
#'   clade_name = "bird",
#'   status = "endemic",
#'   missing_species = 0,
#'   col_time = 1,
#'   col_max_age = FALSE,
#'   branching_times = 0.5,
#'   species = "bird_a",
#'   clade_type = 1
#' )
#' island_tbl <- island_tbl()
#' bind_colonist_to_tbl(
#'   island_colonist = island_colonist,
#'   island_tbl = island_tbl
#' )
bind_colonist_to_tbl <- function(island_colonist,
                                 island_tbl) {

  # group island_colonist data into data frame
  # I(list(c(...))) keeps vector together
  island_colonist_df <- data.frame(
    clade_name = get_clade_name(island_colonist),
    status = get_status(island_colonist),
    missing_species = get_missing_species(island_colonist),
    col_time = get_col_time(island_colonist),
    col_max_age = get_col_max_age(island_colonist),
    branching_times = I(list(get_branching_times(island_colonist))),
    min_age = get_min_age(island_colonist),
    species = I(list(get_species(island_colonist))),
    clade_type = get_clade_type(island_colonist)
  )

  # combine island colonist data frame with island tbl data frame
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)

  # put new island tbl data frame into island_tbl class
  set_island_tbl(island_tbl) <- new_tbl

  # return the class
  island_tbl
}
