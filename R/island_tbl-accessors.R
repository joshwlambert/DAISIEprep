#' @include island_tbl-class.R
NULL

setGeneric("get_island_tbl", function(x) standardGeneric("get_island_tbl"))

#' @export
setMethod("get_island_tbl", "Island_tbl", function(x) x@island_tbl)

setGeneric("set_island_tbl<-", function(x, value) standardGeneric("set_island_tbl<-"))

#' @export
setMethod("set_island_tbl<-", "Island_tbl", function(x, value) {
  x@island_tbl <- value
  x
})

