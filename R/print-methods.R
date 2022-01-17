setGeneric("print")

setMethod("print", signature(x = "island_colonist"),
          function(x) {
            cat("Clade name: ", x@clade_name, "\n")
            cat("Status: ", x@status, "\n")
            cat("Missing species: ", x@missing_species, "\n")
            cat("Branching times: ", x@branching_times, "\n")
          }
)

setMethod("print", signature(x = "island_tbl"),
          function(x) {
            print(x@island_tbl)
          }
)
