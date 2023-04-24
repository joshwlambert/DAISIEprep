#' Checks the validity of the Multi_island_tbl class
#'
#' @param object Instance of the Multi_island_tbl class
#'
#' @return Boolean or errors
#' @export
#'
#' @examples
#' multi_island_tbl <- multi_island_tbl()
#' check_multi_island_tbl(multi_island_tbl)
check_multi_island_tbl <- function(object) {
  if (isFALSE(is.list(object))) {
    return("Multi_island_tbl should be a list of Island_tbl elements")
  }
  #check whether every element of the Multi_island_tbl is an Island_tbl
  valid_island_tbls <- lapply(object, check_island_tbl)
  if (all(unlist(valid_island_tbls))) {
    TRUE
  } else {
    "Multi_island_tbl should be a list of Island_tbl elements"
  }
}

#' Defines the `Multi_island_tbl` class which is multiple `Island_tbl`s.
#'
#' @slot .Data a list of `Island_tbl`.
#'
#' @export
setClass(
  # name of the class
  Class = "Multi_island_tbl",

  # define the types of the class
  contains = "list",

  # define the default values of the slots
  prototype = list(
    list()
  ),

  # check validity of class
  validity = check_multi_island_tbl
)

#' Constructor function for `Multi_island_tbl` class
#'
#' @return A Multi_island_tbl object.
#'
#' @export
multi_island_tbl <- function() {
  multi_island_tbl <- methods::new("Multi_island_tbl")
  multi_island_tbl[[1]] <- island_tbl()
  multi_island_tbl
}
