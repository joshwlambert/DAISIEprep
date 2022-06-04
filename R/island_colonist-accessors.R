#' @include island_colonist-class.R
NULL

#' Accessor functions for the data (slots) in objects of the
#' \code{\linkS4class{Island_colonist}} class
#'
#' @inheritParams default_params_doc
#' @author Joshua W. Lambert
#' @rdname Island_colonist-accessors
#' @export
#' @examples
#'   colonist <- island_colonist()
#'   get_clade_name(colonist)
#'   set_clade_name(colonist) <- "abc"
#'   get_status(colonist)
#'   set_status(colonist) <- "abc"
#'   get_missing_species(colonist)
#'   set_missing_species(colonist) <- 0
#'   get_branching_times(colonist)
#'   set_branching_times(colonist) <- 0
setGeneric("get_clade_name", function(x) standardGeneric("get_clade_name"))

#' @rdname Island_colonist-accessors
#' @aliases get_clade_name,Island_colonist-method
#' @export
setMethod("get_clade_name", "Island_colonist", function(x) methods::slot(x, "clade_name"))

#' @rdname Island_colonist-accessors
setGeneric("set_clade_name<-", function(x, value) standardGeneric("set_clade_name<-"))

#' @rdname Island_colonist-accessors
#' @export
setMethod("set_clade_name<-", "Island_colonist", function(x, value) {
  methods::slot(x, "clade_name") <- value
  x
})

#' @rdname Island_colonist-accessors
setGeneric("get_status", function(x) standardGeneric("get_status"))

#' @rdname Island_colonist-accessors
#' @export
setMethod("get_status", "Island_colonist", function(x) x@status)

#' @rdname Island_colonist-accessors
setGeneric("set_status<-", function(x, value) standardGeneric("set_status<-"))

#' @rdname Island_colonist-accessors
#' @export
setMethod("set_status<-", "Island_colonist", function(x, value) {
  methods::slot(x, "status") <- value
  x
})

#' @rdname Island_colonist-accessors
setGeneric("get_missing_species", function(x) standardGeneric("get_missing_species"))

#' @rdname Island_colonist-accessors
#' @export
setMethod("get_missing_species", "Island_colonist", function(x) x@missing_species)

#' @rdname Island_colonist-accessors
setGeneric("set_missing_species<-", function(x, value) standardGeneric("set_missing_species<-"))

#' @rdname Island_colonist-accessors
#' @export
setMethod("set_missing_species<-", "Island_colonist", function(x, value) {
  x@missing_species <- value
  x
})

#' @rdname Island_colonist-accessors
setGeneric("get_branching_times", function(x) standardGeneric("get_branching_times"))

#' @rdname Island_colonist-accessors
#' @export
setMethod("get_branching_times", "Island_colonist", function(x) x@branching_times)

#' @rdname Island_colonist-accessors
setGeneric("set_branching_times<-", function(x, value) standardGeneric("set_branching_times<-"))

#' @rdname Island_colonist-accessors
#' @export
setMethod("set_branching_times<-", "Island_colonist", function(x, value) {
  x@branching_times <- value
  x
})

#' @rdname Island_colonist-accessors
setGeneric("get_min_age", function(x) standardGeneric("get_min_age"))

#' @rdname Island_colonist-accessors
#' @export
setMethod("get_min_age", "Island_colonist", function(x) x@min_age)

#' @rdname Island_colonist-accessors
setGeneric("set_min_age<-", function(x, value) standardGeneric("set_min_age<-"))

#' @rdname Island_colonist-accessors
#' @export
setMethod("set_min_age<-", "Island_colonist", function(x, value) {
  x@min_age <- value
  x
})

#' @rdname Island_colonist-accessors
setGeneric("get_species", function(x) standardGeneric("get_species"))

#' @rdname Island_colonist-accessors
#' @export
setMethod("get_species", "Island_colonist", function(x) x@species)

#' @rdname Island_colonist-accessors
setGeneric("set_species<-", function(x, value) standardGeneric("set_species<-"))

#' @rdname Island_colonist-accessors
#' @export
setMethod("set_species<-", "Island_colonist", function(x, value) {
  x@species <- value
  x
})

