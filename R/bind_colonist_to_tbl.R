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
#'   branching_times = c(1, 0.5)
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
    branching_times = I(list(get_branching_times(island_colonist))),
    min_age = get_min_age(island_colonist)
  )

  # combine island colonist data frame with island tbl data frame
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)

  # put new island tbl data frame into island_tbl class
  set_island_tbl(island_tbl) <- new_tbl

  # return the class
  island_tbl
}
