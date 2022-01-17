#' Check if colonist has already been stored in island_tbl class
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
#' island_tbl <- methods::new("island_tbl")
#' check_duplicate_colonist(
#'   island_colonist = island_col,
#'   island_tbl = island_tbl
#' )
check_duplicate_colonist <- function(island_colonist,
                                     island_tbl) {

  # extract data from island_colonist class
  colonist_clade_name <- get_clade_name(island_colonist)
  colonist_status <- get_status(island_colonist)
  colonist_missing_species <- get_missing_species(island_colonist)
  colonist_branching_times <- get_branching_times(island_colonist)

  # extract data frame from island_tbl class
  island_tbl <- get_island_tbl(island_tbl)

  # check if the clade name or braching times are duplicates
  status_duplicate <- any(island_tbl$status == colonist_status)
  branching_times_duplicate <- unlist(
    lapply(island_tbl$branching_times, function(x) {
      identical(x, colonist_branching_times)
    })
  )
  branching_times_duplicate <- any(branching_times_duplicate)

  # colonist cannot have the same branching times and endemicity status
  if (status_duplicate && branching_times_duplicate) {
    TRUE
  } else {
    FALSE
  }
}
