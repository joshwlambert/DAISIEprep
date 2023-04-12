#' @include island_tbl-class.R
NULL

#' Accessor functions for the data (slots) in objects of the
#' \code{\linkS4class{Island_tbl}} class
#'
#' @inheritParams default_params_doc
#' @author Joshua W. Lambert
#' @rdname Island_tbl-accessors
#' @return Getter function (get_*) returns a data frame, the setter function
#' (set_*) returns the modified Island_tbl class.
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

#' @rdname Island_tbl-accessors
setGeneric("get_extracted_species", function(x) standardGeneric("get_extracted_species"))

#' @rdname Island_tbl-accessors
#' @export
setMethod("get_extracted_species", "Island_tbl", function(x) x@metadata$extracted_species)

#' @rdname Island_tbl-accessors
setGeneric("set_extracted_species<-", function(x, value) standardGeneric("set_extracted_species<-"))

#' @rdname Island_tbl-accessors
#' @export
setMethod("set_extracted_species<-", "Island_tbl", function(x, value) {
  x@metadata$extracted_species <- value
  x
})

#' @rdname Island_tbl-accessors
setGeneric("get_num_phylo_used", function(x) standardGeneric("get_num_phylo_used"))

#' @rdname Island_tbl-accessors
#' @export
setMethod("get_num_phylo_used", "Island_tbl", function(x) x@metadata$num_phylo_used)

#' @rdname Island_tbl-accessors
setGeneric("set_num_phylo_used<-", function(x, value) standardGeneric("set_num_phylo_used<-"))

#' @rdname Island_tbl-accessors
#' @export
setMethod("set_num_phylo_used<-", "Island_tbl", function(x, value) {
  x@metadata$num_phylo_used <- value
  x
})
