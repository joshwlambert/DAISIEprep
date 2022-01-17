setGeneric("get_clade_name", function(x) standardGeneric("get_clade_name"))
setMethod("get_clade_name", "island_colonist", function(x) x@clade_name)


setGeneric("set_clade_name<-", function(x, value) standardGeneric("set_clade_name<-"))
setMethod("set_clade_name<-", "island_colonist", function(x, value) {
  x@clade_name <- value
  x
})

setGeneric("get_status", function(x) standardGeneric("get_status"))
setMethod("get_status", "island_colonist", function(x) x@status)

setGeneric("set_status<-", function(x, value) standardGeneric("set_status<-"))
setMethod("set_status<-", "island_colonist", function(x, value) {
  x@status <- value
  x
})

setGeneric("get_missing_species", function(x) standardGeneric("get_missing_species"))
setMethod("get_missing_species", "island_colonist", function(x) x@missing_species)

setGeneric("set_missing_species<-", function(x, value) standardGeneric("set_missing_species<-"))
setMethod("set_missing_species<-", "island_colonist", function(x, value) {
  x@missing_species <- value
  x
})

setGeneric("get_branching_times", function(x) standardGeneric("get_branching_times"))
setMethod("get_branching_times", "island_colonist", function(x) x@branching_times)

setGeneric("set_branching_times<-", function(x, value) standardGeneric("set_branching_times<-"))
setMethod("set_branching_times<-", "island_colonist", function(x, value) {
  x@branching_times <- value
  x
})

