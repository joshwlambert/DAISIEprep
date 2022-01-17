#' Methods to get and set the elements of the `island_tbl` class.
#'
#' @inheritParams default_params_doc
#'
#' @rdname island_tbl-accessors
#' @return Data frame
#' @export
setGeneric("get_island_tbl", function(x) standardGeneric("get_island_tbl"))

#' @rdname island_tbl-accessors
setMethod("get_island_tbl", "island_tbl", function(x) x@island_tbl)


#' Sets value for `island_tbl` class.
#'
#' @inheritParams default_params_doc
#'
#' @return Nothing
#' @export
setGeneric("set_island_tbl<-", function(x, value) standardGeneric("set_island_tbl<-"))

#' @rdname island_tbl-accessors
setMethod("set_island_tbl<-", "island_tbl", function(x, value) {
  x@island_tbl <- value
  x
})

