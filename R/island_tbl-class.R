#' Checks the validity of the island_tbl class
#'
#' @param object Instance of the island_tbl class
#'
#' @return Boolean or errors
#' @export
#'
#' @examples
#' tbl <- methods::new("island_tbl")
#' check_island_tbl(tbl)
check_island_tbl <- function(object) {
  errors <- character()
  num_col <- ncol(object@island_tbl)
  if (num_col != 4) {
    msg <- paste("island_tbl has ", num_col, ". Should have 4", sep = "")
    errors <- c(errors, msg)
  }

  col_names <- names(object@island_tbl)
  if (col_names !=
      c("clade_name", "status", "missing_species", "branching_times")) {
    msg <- paste(
      "Names of island_tbl are ", col_names, ". Should be 'clade_name',
      'status', 'missing_species', 'branching_times'",
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
#' @slot clade_name character.
#' @slot status character.
#' @slot missing_species character.
#' @slot branching_times numeric.
#'
#' @export
island_tbl <- setClass(
  # name of the class
  Class = "island_tbl",

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
      branching_times = numeric()
    )
  )
)
