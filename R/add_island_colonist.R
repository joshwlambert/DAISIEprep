#' Adds an island colonists (can be either a singleton lineage or an island
#' clade) to the island community (island_tbl).
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `Island_tbl` class
#' @export
#'
#' @examples
#' # create an empty island_tbl to add to
#' island_tbl <- island_tbl()
#'
#' # add a new island colonist
#' island_tbl <- add_island_colonist(
#'   island_tbl,
#'   clade_name = "new_clade",
#'   status = "endemic",
#'   missing_species = 0,
#'   branching_times = 1,
#'   min_age = NA,
#'   species = "new_clade"
#' )
add_island_colonist <- function(island_tbl,
                                clade_name,
                                status,
                                missing_species,
                                branching_times,
                                min_age,
                                species) {

  # group island_colonist data into data frame
  # I(list(c(...))) keeps vector together
  island_colonist_df <- data.frame(
    clade_name = clade_name,
    status = status,
    missing_species = missing_species,
    branching_times = I(list(branching_times)),
    min_age = min_age,
    species = I(list(species))
  )

  # combine island colonist data frame with island tbl data frame
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)

  # put new island tbl data frame into island_tbl class
  set_island_tbl(island_tbl) <- new_tbl

  # return the class
  island_tbl
}

