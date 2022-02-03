as_daisie_datatable <- function(island_tbl) {

  daisie_datatable <- data.frame(Clade_name = character(),
                                 Status = character(),
                                 Missing_species = numeric(),
                                 Branching_times = numeric())

  # extract data frame from island_tbl class
  island_tbl <- get_island_tbl(island_tbl)

  for (i in seq_len(nrow(island_tbl))) {
    print(i)
  }


  # return daisie_datatable
  daisie_datatable
}
