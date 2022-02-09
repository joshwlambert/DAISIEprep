#' Determines if colonist has already been stored in `Island_tbl` class. This is
#' used to stop endemic clades from being stored multiple times in the island
#' table by checking if the endemicity status and branching times are identical.
#'
#' @inheritParams default_params_doc
#'
#' @return Boolean
#' @export
#'
#' @examples
#' island_col <- island_colonist(
#'   clade_name = "bird",
#'   status = "endemic",
#'   missing_species = 0,
#'   branching_times = c(1.0, 0.5)
#' )
#' island_tbl <- island_tbl()
#' is_duplicate_colonist(
#'   island_colonist = island_col,
#'   island_tbl = island_tbl
#' )
is_duplicate_colonist <- function(island_colonist,
                                     island_tbl) {

  # extract data from island_colonist class
  colonist_clade_name <- get_clade_name(island_colonist)
  colonist_status <- get_status(island_colonist)
  colonist_branching_times <- get_branching_times(island_colonist)

  # extract data frame from island_tbl class
  island_tbl <- get_island_tbl(island_tbl)

  # check if the endemicity statuses are duplicates
  status_duplicate <- island_tbl$status == colonist_status

  # check if the branching times are duplicates
  branching_times_duplicate <- unlist(
    lapply(island_tbl$branching_times, function(x) {
      identical(x, colonist_branching_times)
    })
  )

  # vectorised check of status and branching times for each colonist
  is_duplicate <- any(status_duplicate & branching_times_duplicate)

  # check whether it is a nonendemic from the same node
  is_nonendemic <- identical(colonist_status, "nonendemic")

  # endemic colonist cannot have the same branching times and endemicity status
  # non-endemic colonist cannot have the same clade name, branching times and
  # endemicity status
  if (isTRUE(is_nonendemic)) {
    clade_name_duplicate <- any(island_tbl$clade_name == colonist_clade_name)
    is_duplicate <- clade_name_duplicate && is_duplicate
  }

  if (isTRUE(is_duplicate)) {
    TRUE
  } else {
    FALSE
  }
}
