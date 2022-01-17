#' Gets clade name from object of `island_colonist` class.
#'
#' @inheritParams default_params_doc
#'
#' @rdname island_colonist-accessors
#' @return Character string
#' @export
setGeneric("get_clade_name", function(x) standardGeneric("get_clade_name"))

#' @rdname island_colonist-accessors
setMethod("get_clade_name", "island_colonist", function(x) x@clade_name)


#' Sts clade name of object of `island_colonist` class.
#'
#' @inheritParams default_params_doc
#'
#' @return Nothing
#' @export
setGeneric("set_clade_name<-", function(x, value) standardGeneric("set_clade_name<-"))

#' Title
#'
#' @param island_colonist
#'
#' @return
#' @export
#'
#' @examples
setMethod("set_clade_name<-", "island_colonist", function(x, value) {
  x@clade_name <- value
  x
})

#' Title
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
setGeneric("get_status", function(x) standardGeneric("get_status"))

#' Title
#'
#' @param island_colonist
#'
#' @return
#' @export
#'
#' @examples
setMethod("get_status", "island_colonist", function(x) x@status)

#' Title
#'
#' @param x
#' @param value
#'
#' @return
#' @export
#'
#' @examples
setGeneric("set_status<-", function(x, value) standardGeneric("set_status<-"))

#' Title
#'
#' @param island_colonist
#'
#' @return
#' @export
#'
#' @examples
setMethod("set_status<-", "island_colonist", function(x, value) {
  x@status <- value
  x
})

#' Title
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
setGeneric("get_missing_species", function(x) standardGeneric("get_missing_species"))

#' Title
#'
#' @param island_colonist
#'
#' @return
#' @export
#'
#' @examples
setMethod("get_missing_species", "island_colonist", function(x) x@missing_species)

#' Title
#'
#' @param x
#' @param value
#'
#' @return
#' @export
#'
#' @examples
setGeneric("set_missing_species<-", function(x, value) standardGeneric("set_missing_species<-"))

#' Title
#'
#' @param island_colonist
#'
#' @return
#' @export
#'
#' @examples
setMethod("set_missing_species<-", "island_colonist", function(x, value) {
  x@missing_species <- value
  x
})

#' Title
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
setGeneric("get_branching_times", function(x) standardGeneric("get_branching_times"))

#' Title
#'
#' @param island_colonist
#'
#' @return
#' @export
#'
#' @examples
setMethod("get_branching_times", "island_colonist", function(x) x@branching_times)

#' Title
#'
#' @param x
#' @param value
#'
#' @return
#' @export
#'
#' @examples
setGeneric("set_branching_times<-", function(x, value) standardGeneric("set_branching_times<-"))

#' Title
#'
#' @param island_colonist
#'
#' @return
#' @export
#'
#' @examples
setMethod("set_branching_times<-", "island_colonist", function(x, value) {
  x@branching_times <- value
  x
})

