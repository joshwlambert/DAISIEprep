setGeneric("summary")

setMethod("summary", signature(object = "Multi_island_tbl"),
          function(object) {
            num_col <- sapply(object, function(y) nrow(y@island_tbl))
            mean_num_col <- mean(num_col)
            sd_num_col <- stats::sd(num_col)
            percent_endemic <- unlist(lapply(object, function(y) y@island_tbl$status))
            if (length(percent_endemic) == 0) {
              percent_endemic <- NA
            } else {
              percent_endemic <- sum(percent_endemic == "endemic") /
                sum(percent_endemic != "endemic")
            }
            status <- sapply(object, function(y) y@island_tbl$status)
            cat("Multi_island_tbl: ", "\n")
            cat("  Mean number of colonists: ", mean_num_col, "\n")
            cat("  Standard deviation of number of colonists: ", sd_num_col, "\n")
            cat("  Percent of island colonists endemic: ", percent_endemic, "\n")
})
