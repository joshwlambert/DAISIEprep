extract_island_species <- function(phylod) {

  tbl <- methods::new("island_tbl")


  for (i in seq_len(nrow(phylod@data))) {

    # if no species are on the island
    if (all(identical(phylod@data$endemicity_status, "not_present"))) {
      return(tbl)
    }

    # extract any nonendemic and endemic species is on the island
    if (identical(phylod@data$endemicity_status[i], "nonendemic")) {
      island_colonist <- extract_nonendemic(
        phylod = phylod,
        species_label = as.character(phylod@label[i])
      )
      tbl <- bind_colonist_to_tbl(
        island_colonist = island_colonist,
        island_tbl = tbl
      )
    } else if (identical(phylod@data$endemicity_status[i], "endemic")) {
      island_colonist <- extract_endemic(
        phylod = phylod,
        species_label = as.character(phylod@label[i])
      )

      # check if colonist has already been stored in island_tbl class
      duplicate_colonist <- check_duplicate_colonist(
        island_colonist = island_colonist,
        island_tbl = tbl
      )

      if (!duplicate_colonist) {
        # bind data from island_colonist class into island_tbl class
        tbl <- bind_colonist_to_tbl(
          island_colonist = island_colonist,
          island_tbl = tbl
        )
      }
    }
  }

  # return island_tbl class
  tbl
}
