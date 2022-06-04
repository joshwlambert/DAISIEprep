setGeneric("print")

setMethod("print", signature(x = "Island_colonist"),
          function(x) {
            cat("Class: ", methods::is(x), "\n")
            cat("  Clade name: ", x@clade_name, "\n")
            cat("  Status: ", x@status, "\n")
            cat("  Missing species: ", x@missing_species, "\n")
            cat("  Branching times: ", x@branching_times, "\n")
            cat("  Min age: ", x@min_age, "\n")
            cat("  Species: ", x@species, "\n")
          }
)

setMethod("print", signature(x = "Island_tbl"),
          function(x) {
            cat("Class: ", methods::is(x), "\n")
            print(x@island_tbl)
          }
)

setMethod("print", signature(x = "Multi_island_tbl"),
          function(x) {
            cat("Class: ", methods::is(x), "\n")
            cat(length(x), "Island_tbls")
          }
)

setMethod("show", signature(object = "Island_colonist"),
          function(object) {
            print(object)
          }
)

setMethod("show", signature(object = "Island_tbl"),
          function(object) {
            print(object)
          }
)

setMethod("show", signature(object = "Multi_island_tbl"),
          function(object) {
            print(object)
          }
)
