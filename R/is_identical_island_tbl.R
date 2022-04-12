#' Checks whether two `Island_tbl` objects are identical. If they are different
#' comparisons are made to report which components of the `Island_tbls` are
#' different.
#'
#' @param island_tbl_1 stub
#' @param island_tbl_2 stub
#'
#' @return Either TRUE or a character string with the differences
#' @export
#'
#' @examples
is_identical_island_tbl <- function(island_tbl_1, island_tbl_2) {
  if (identical(island_tbl_1, island_tbl_2)) {
    return(TRUE)
  } else {

    # locate and store differences

    # test differences for: number of colonists, colonisation time, branching
    # times, endemicity, clade name, min age

  }
}
