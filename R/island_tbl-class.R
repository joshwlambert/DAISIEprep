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
  if (num_col != 9) {
    msg <- paste("island_tbl has ", num_col, ". Should have 9", sep = "")
    errors <- c(errors, msg)
  }

  col_names <- names(object@island_tbl)
  match_col_names <- identical(
    col_names,
    c("clade_name", "status", "missing_species", "col_time", "col_max_age",
      "branching_times", "min_age", "species", "clade_type")
  )
  if (isFALSE(match_col_names)) {
    msg <- paste(
      "Names of island_tbl are ", col_names, ". Should be 'clade_name',
      'status', 'missing_species', 'col_time', 'col_max_age', 'branching_times',
      'min_age', 'species', 'clade_type'",
      sep = ""
    )
    errors <- c(errors, msg)
  }

  if (!is.list(object@metadata)) {
    msg <- paste("metadata must be a list")
    errors <- c(errors, msg)
  }

  match_list_names <- all(
    c("extracted_species", "num_phylo_used") %in% names(object@metadata)
  )
  if (isFALSE(match_list_names)) {
    msg <- paste(
      "metadata must contain 'extracted_species' and 'num_phylo_used'"
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
#' @slot metadata list.
#'
#' @export
setClass(
  # name of the class
  Class = "Island_tbl",

  # define the types of the class
  slots = c(
    island_tbl = "data.frame",
    metadata = "list"
  ),

  # define the default values of the slots
  prototype = list(
    island_tbl = data.frame(
      clade_name = character(),
      status = character(),
      missing_species = numeric(),
      col_time = numeric(),
      col_max_age = logical(),
      branching_times = numeric(),
      min_age = numeric(),
      species = character(),
      clade_type = numeric()
    ),
    metadata = list(
      extracted_species = NA_integer_,
      num_phylo_used = NA_integer_
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
