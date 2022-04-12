setGeneric("summary")

setMethod("summary", signature(x = "Multi_island_tbl"),
          function(x) {

            mean_num_col <- mean(sapply(x, function(y) nrow(y@island_tbl)))
            cat("Multi_island_tbl: ", "\n")
            cat("  Mean number of colonists: ", mean_num_col, "\n")
          }
)
