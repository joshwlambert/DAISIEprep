setGeneric("get_island_tbl", function(x) standardGeneric("get_island_tbl"))
setMethod("get_island_tbl", "island_tbl", function(x) x@island_tbl)


setGeneric("set_island_tbl<-", function(x, value) standardGeneric("set_island_tbl<-"))
setMethod("set_island_tbl<-", "island_tbl", function(x, value) {
  x@island_tbl <- value
  x
})

