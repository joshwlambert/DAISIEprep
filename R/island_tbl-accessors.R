#' @include island_tbl-class.R
NULL

#' Accessor functions for the data (slots) in objects of the
#' \code{\linkS4class{Island_tbl}} class
#'
#' @inheritParams default_params_doc
#' @author Joshua W. Lambert
#' @rdname Island_tbl-accessors
#' @export
#' @examples
#' island_tbl <- island_tbl()
#' get_island_tbl(island_tbl)
#' set_island_tbl(island_tbl) <- data.frame(
#'   clade_name = "birds",
#'   status = "endemic",
#'   missing_species = 0,
#'   branching_times = I(list(c(1.0, 0.5)))
#' )

setGeneric("get_island_tbl", function(x) standardGeneric("get_island_tbl"))

#' @rdname Island_tbl-accessors
#' @export
setMethod("get_island_tbl", "Island_tbl", function(x) x@island_tbl)

#' @rdname Island_tbl-accessors
setGeneric("set_island_tbl<-", function(x, value) standardGeneric("set_island_tbl<-"))

#' @rdname Island_tbl-accessors
#' @export
setMethod("set_island_tbl<-", "Island_tbl", function(x, value) {
  x@island_tbl <- value
  x
})

