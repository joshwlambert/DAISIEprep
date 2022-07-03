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
#' # with empty island_tbl
#' island_colonist <- island_colonist(
#'   clade_name = "bird",
#'   status = "endemic",
#'   missing_species = 0,
#'   col_time = 1.0,
#'   col_max_age = FALSE,
#'   branching_times = 0.5,
#'   species = "bird_a",
#'   clade_type = 1
#' )
#' island_tbl <- island_tbl()
#' is_duplicate_colonist(
#'   island_colonist = island_colonist,
#'   island_tbl = island_tbl
#' )
#'
#' # with non-empty island_tbl
#' island_colonist <- island_colonist(
#'   clade_name = "bird",
#'   status = "endemic",
#'   missing_species = 0,
#'   col_time = 1.0,
#'   col_max_age = FALSE,
#'   branching_times = 0.5,
#'   species = c("bird_a", "bird_b"),
#'   clade_type = 1
#' )
#' island_tbl <- island_tbl()
#' island_tbl <- bind_colonist_to_tbl(
#'   island_colonist = island_colonist,
#'   island_tbl = island_tbl
#' )
#' island_colonist <- island_colonist(
#'   clade_name = "bird",
#'   status = "endemic",
#'   missing_species = 0,
#'   col_time = 1.0,
#'   col_max_age = FALSE,
#'   branching_times = 0.5,
#'   species = c("bird_a", "bird_b"),
#'   clade_type = 1
#' )
#' is_duplicate_colonist(
#'   island_colonist = island_colonist,
#'   island_tbl = island_tbl
#' )
is_duplicate_colonist <- function(island_colonist,
                                  island_tbl) {

  # if island_tbl is empty colonist cannot be a duplicate
  if (nrow(get_island_tbl(island_tbl)) == 0) {
    return(FALSE)
  }

  # extract data from island_colonist class
  colonist_clade_name <- get_clade_name(island_colonist)
  colonist_status <- get_status(island_colonist)
  colonist_col_time <- get_col_time(island_colonist)
  colonist_branching_times <- get_branching_times(island_colonist)
  colonist_species <- get_species(island_colonist)

  # extract data frame from island_tbl class
  island_tbl <- get_island_tbl(island_tbl)

  # check if the endemicity statuses are duplicates
  status_duplicate <- island_tbl$status == colonist_status

  # combine colonisation and branching times for checking
  colonist_event_times <- c(colonist_col_time, colonist_branching_times)
  colonist_event_times <- colonist_event_times[!is.na(colonist_event_times)]

  # combine colonisation and branching times for checking
  island_tbl_event_times <- mapply(
    c,
    as.list(island_tbl$col_time),
    island_tbl$branching_times,
    SIMPLIFY = FALSE
  )

  # remove any NAs from branching times
  island_tbl_event_times <- lapply(
    island_tbl_event_times,
    stats::na.omit
  )

  # check if the event times are duplicates
  event_times_duplicate <- unlist(
    lapply(island_tbl_event_times, function(x) {
      if (length(x) == length(colonist_event_times)) {
        all(is.infinite(x) == is.infinite(colonist_event_times))
        finite_event_times <-
          colonist_event_times[which(is.finite(colonist_event_times))]
        all(abs(x[which(is.finite(x))] - finite_event_times) < 1e-10)
      } else {
        FALSE
      }
    })
  )

  # vectorised check of status and branching times for each colonist
  is_duplicate <- any(status_duplicate & event_times_duplicate)

  # check whether it is a nonendemic from the same node
  is_nonendemic <- identical(colonist_status, "nonendemic")

  # endemic colonist cannot have the same branching times and endemicity status
  # non-endemic colonist cannot have the same clade name, branching times and
  # endemicity status
  if (isTRUE(is_nonendemic)) {
    clade_name_duplicate <- any(island_tbl$clade_name == colonist_clade_name)
    is_duplicate <- clade_name_duplicate && is_duplicate
  }

  # return is_duplicate
  isTRUE(is_duplicate)
}
