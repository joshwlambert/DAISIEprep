#' Checks the validity of the Island_colonist class
#'
#' @param object Instance of the island_colonist class
#'
#' @return Boolean or errors
#' @export
#'
#' @examples
#' island_col <- island_colonist()
#' check_island_colonist(island_col)
check_island_colonist <- function(object) {
  errors <- character()
  length_clade_name <- length(object@clade_name)
  if (length_clade_name != 1) {
    msg <- paste("clade_name is length ", length_clade_name, ". Should be 1",
                 sep = "")
    errors <- c(errors, msg)
  }

  length_status <- length(object@status)
  if (length_status != 1) {
    msg <- paste("status is length ", length_status, ". Should be 1", sep = "")
    errors <- c(errors, msg)
  }

  length_missing_species <- length(object@missing_species)
  if (length_missing_species != 1) {
    msg <- paste(
      "missing_species is length ", length_missing_species, ". Should be 1",
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
setClass(
  # name of the class
  Class = "Island_colonist",

  # define the types of the class
  slots = c(
    clade_name = "character",
    status = "character",
    missing_species = "numeric",
    branching_times = "numeric"
  ),

  # define the default values of the slots
  prototype = list(
    clade_name = NA_character_,
    status = NA_character_,
    missing_species = NA_real_,
    branching_times = NA_real_
  ),

  # check validity of class
  validity = check_island_colonist
)

# Constructor for Island_colonist
island_colonist <- function() {
  methods::new("Island_colonist")
}
