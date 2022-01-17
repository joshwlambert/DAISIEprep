extract_endemic <- function(phylod,
                            species_label) {

  # create an instance of the island_colonist class to store data
  island_col <- new("island_colonist")

  # check whether the focal species is in an endemic clade
  clade <- is_island_clade(phylod, species_label)

  if (isFALSE(clade)) {
    # assign data to instance of island_colonist class
    set_clade_name(island_col) <- species_label
    set_status(island_col) <- "endemic"
    set_missing_species(island_col) <- 0
    set_branching_times(island_col) <-
      as.numeric(phylobase::edgeLength(phylod, species_label))
  } else {
    island_col <- extract_endemic_clade(phylod, species_label)
  }

  #return instance of island_colonist class
  island_col
}
