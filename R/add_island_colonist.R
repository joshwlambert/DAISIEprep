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
#'   col_time = 1,
#'   col_max_age = FALSE,
#'   branching_times = NA,
#'   min_age = NA,
#'   species = "new_clade",
#'   clade_type = 1
#' )
add_island_colonist <- function(island_tbl,
                                clade_name,
                                status,
                                missing_species,
                                col_time,
                                col_max_age,
                                branching_times,
                                min_age,
                                species,
                                clade_type) {

  status <- match.arg(status, choices = c("endemic", "nonendemic"))

  if (status == "nonendemic" && missing_species > 0) {
    warning("When adding a non-endemic lineage (status = 'nonendemic'), ",
            "the number of missing species should be zero (this is already ",
            "taken into account by adding the lineage)")
  }
  if (status == "nonendemic" && !anyNA(branching_times)) {
    warning("When adding a non-endemic lineage (status = 'nonendemic'), ",
            "there should be no branching times added (these are not ",
            "considered in the DAISIE model for non-endemic species)\n.",
            "If you would like to use a branching time as a minimum time ",
            "of colonisation, please use the min_age argument instead.")
  }

  if (!anyNA(min_age) && isFALSE(col_max_age)) {
    warning("Adding a min_age is inconsistent with setting colonisation ",
            "time to be precise (col_max_age = FALSE). So in this case the ",
            "min_age is ignored.")
  }

  if (!is.na(min_age) && !anyNA(branching_times) &&
      min_age < max(branching_times)) {
    warning("You have added a min_age that is younger than the oldest ",
            "branching time.\n This min_age will be treated as a ",
            "branching time and the oldest branching time will be treated ",
            "as the minimum age of colonisation.")
  }

  if (!is.na(min_age) && !is.na(col_time) && min_age > col_time) {
    stop("The min_age cannot be older than the col_time.")
  }

  # group island_colonist data into data frame
  # I(list(c(...))) keeps vector together
  island_colonist_df <- data.frame(
    clade_name = clade_name,
    status = status,
    missing_species = missing_species,
    col_time = col_time,
    col_max_age = col_max_age,
    branching_times = I(list(branching_times)),
    min_age = min_age,
    species = I(list(species)),
    clade_type = clade_type
  )

  # combine island colonist data frame with island tbl data frame
  new_tbl <- rbind(get_island_tbl(island_tbl), island_colonist_df)

  # put new island tbl data frame into island_tbl class
  set_island_tbl(island_tbl) <- new_tbl

  # return the class
  island_tbl
}
