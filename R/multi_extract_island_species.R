#' Extracts the colonisation, diversification, and endemicty data from multiple
#' `phylod` (`phylo4d` class from `phylobase`) objects (composed of phylogenetic
#' and endemicity data) and stores each in an `Island_tbl` object which are
#' stored in a `Multi_island_tbl` object.
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `Multi_island_tbl` class
#' @export
#'
#' @examples
#' multi_phylod <- list()
#' multi_phylod[[1]] <- DAISIEprep:::create_test_phylod(test_scenario = 1)
#' multi_phylod[[2]] <- DAISIEprep:::create_test_phylod(test_scenario = 2)
#' multi_island_tbl <- multi_extract_island_species(
#'   multi_phylod = multi_phylod,
#'   extraction_method = "min",
#'   island_tbl = NULL,
#'   include_not_present = FALSE
#' )
multi_extract_island_species <- function(multi_phylod,
                                         extraction_method,
                                         island_tbl = NULL,
                                         include_not_present = FALSE,
                                         verbose = FALSE) {

  # check each phylod
  multi_phylod <- lapply(multi_phylod, check_phylo_data)

  # create an instance of the multi_island_tbl class to store data
  multi_island_tbl <- multi_island_tbl()

  # loop over each phylod and store in multi_island_tbl
  for (i in seq_along(multi_phylod)) {

    if (verbose) {
      message("Extracting tree ", i, " of ", length(multi_phylod))
    }

    multi_island_tbl[[i]] <- extract_island_species(
      phylod = multi_phylod[[i]],
      extraction_method = extraction_method,
      island_tbl = island_tbl,
      include_not_present = include_not_present
    )
  }

  # return multi_island_tbl
  multi_island_tbl
}
