as_daisie_datatable <- function(island_tbl) {

  daisie_datatable <- data.frame(Clade_name = character(),
                                 Status = character(),
                                 Missing_species = numeric(),
                                 Branching_times = numeric())

  # extract data frame from island_tbl class
  daisie_datatable <- get_island_tbl(island_tbl)
  colnames(daisie_datatable) <- c(
    "Clade_name", "Status", "Missing_species", "Branching_times"
  )

  # if min age is given merge into branching times
  #TODO

  # if branching_time is older than the island age make a max age

  # return daisie_datatable
  daisie_datatable
}
