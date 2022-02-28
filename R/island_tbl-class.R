#' Checks the validity of the Island_tbl class
#'
#' @param object Instance of the Island_tbl class
#'
#' @return Boolean or errors
#' @export
#'
#' @examples
#' island_tbl <- island_tbl()
#' check_island_tbl(island_tbl)
check_island_tbl <- function(object) {
  errors <- character()
  num_col <- ncol(object@island_tbl)
  if (num_col != 5) {
    msg <- paste("island_tbl has ", num_col, ". Should have 5", sep = "")
    errors <- c(errors, msg)
  }

  col_names <- names(object@island_tbl)
  match_col_names <- identical(
    col_names,
    c("clade_name", "status", "missing_species", "branching_times", "min_age")
  )
  if (isFALSE(match_col_names)) {
    msg <- paste(
      "Names of island_tbl are ", col_names, ". Should be 'clade_name',
      'status', 'missing_species', 'branching_times', 'min_age'",
      sep = ""
    )
    errors <- c(errors, msg)
  }

  if (length(errors) == 0) {
    TRUE
  } else {
    errors
  }
}

#' Defines the `island_tbl` class which is used when extracting information
#' from the phylogenetic and island data to be used for constructing a
#' `daisie_data_tbl`
#'
#' @slot island_tbl data frame.
setClass(
  # name of the class
  Class = "Island_tbl",

  # define the types of the class
  slots = c(
    island_tbl = "data.frame"
  ),

  # define the default values of the slots
  prototype = list(
    island_tbl = data.frame(
      clade_name = character(),
      status = character(),
      missing_species = numeric(),
      branching_times = numeric(),
      min_age = numeric()
    )
  ),

  # check validity of class
  validity = check_island_tbl
)

#' Constructor function for `Island_tbl` class
#'
#' @export
island_tbl <- function() {
  methods::new("Island_tbl")
}

