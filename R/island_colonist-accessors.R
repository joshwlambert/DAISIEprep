#' @include island_colonist-class.R
NULL

setGeneric("get_clade_name", function(x) standardGeneric("get_clade_name"))

#' @export
setMethod("get_clade_name", "Island_colonist", function(x) slot(x, "clade_name"))


setGeneric("set_clade_name<-", function(x, value) standardGeneric("set_clade_name<-"))

#' @export
setMethod("set_clade_name<-", "Island_colonist", function(x, value) {
  slot(x, "clade_name") <- value
  x
})

setGeneric("get_status", function(x) standardGeneric("get_status"))


#' @export
setMethod("get_status", "Island_colonist", function(x) x@status)

setGeneric("set_status<-", function(x, value) standardGeneric("set_status<-"))

#' @export
setMethod("set_status<-", "Island_colonist", function(x, value) {
  slot(x, "status") <- value
  x
})

setGeneric("get_missing_species", function(x) standardGeneric("get_missing_species"))

#' @export
setMethod("get_missing_species", "Island_colonist", function(x) x@missing_species)

setGeneric("set_missing_species<-", function(x, value) standardGeneric("set_missing_species<-"))

#' @export
setMethod("set_missing_species<-", "Island_colonist", function(x, value) {
  x@missing_species <- value
  x
})

setGeneric("get_branching_times", function(x) standardGeneric("get_branching_times"))

#' @export
setMethod("get_branching_times", "Island_colonist", function(x) x@branching_times)

setGeneric("set_branching_times<-", function(x, value) standardGeneric("set_branching_times<-"))

#' @export
setMethod("set_branching_times<-", "Island_colonist", function(x, value) {
  x@branching_times <- value
  x
})

