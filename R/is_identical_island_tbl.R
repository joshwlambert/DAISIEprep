#' Checks whether two `Island_tbl` objects are identical. If they are different
#' comparisons are made to report which components of the `Island_tbls` are
#' different.
#'
#' @inheritParams default_params_doc
#'
#' @return Either TRUE or a character string with the differences
#' @export
#'
#' @examples
#' multi_island_tbl <- multi_extract_island_species(
#'   multi_phylod = list(
#'     DAISIEprep:::create_test_phylod(test_scenario = 1),
#'     DAISIEprep:::create_test_phylod(test_scenario = 1)),
#'  extraction_method = "min")
#' is_identical_island_tbl(multi_island_tbl[[1]], multi_island_tbl[[2]])
is_identical_island_tbl <- function(island_tbl_1, island_tbl_2) {
  if (identical(island_tbl_1, island_tbl_2)) {
    return(TRUE)
  } else {

    # locate and store differences in msg
    msg <- c()

    # test differences
    num_col_1 <- nrow(get_island_tbl(island_tbl_1))
    num_col_2 <- nrow(get_island_tbl(island_tbl_2))
    if (!isTRUE(all.equal(num_col_1, num_col_2))) {
      msg <- c(
        msg,
        paste(
          "Number of colonisation difference:",
          all.equal(num_col_1, num_col_2)
        )
      )
    }

    clade_name_1 <- get_island_tbl(island_tbl_1)$clade_name
    clade_name_2 <- get_island_tbl(island_tbl_2)$clade_name
    if (!isTRUE(all.equal(clade_name_1, clade_name_2))) {
      msg <- c(
        msg,
        paste(
          "Colonist name(s) difference:",
          all.equal(clade_name_1, clade_name_2)
        )
      )
    }

    status_1 <- get_island_tbl(island_tbl_1)$status
    status_2 <- get_island_tbl(island_tbl_2)$status
    if (!isTRUE(all.equal(status_1, status_2))) {
      msg <- c(
        msg,
        paste(
          "Endemicity status difference:",
          all.equal(status_1, status_2)
        )
      )
    }

    missing_species_1 <- get_island_tbl(island_tbl_1)$missing_species
    missing_species_2 <- get_island_tbl(island_tbl_2)$missing_species
    if (!isTRUE(all.equal(missing_species_1, missing_species_2))) {
      msg <- c(
        msg,
        paste(
          "Number of missing species difference:",
          all.equal(missing_species_1, missing_species_2)
        )
      )
    }

    branching_times_1 <- get_island_tbl(island_tbl_1)$branching_times[[1]]
    branching_times_2 <- get_island_tbl(island_tbl_2)$branching_times[[1]]
    if (!isTRUE(all.equal(branching_times_1, branching_times_2))) {
      msg <- c(
        msg,
        paste(
          "Colonisation and Branching times difference:",
          all.equal(branching_times_1, branching_times_2)
        )
      )
    }

    min_age_1 <- get_island_tbl(island_tbl_1)$min_age
    min_age_2 <- get_island_tbl(island_tbl_2)$min_age
    if (!isTRUE(all.equal(min_age_1, min_age_2))) {
      msg <- c(
        msg,
        paste(
          "Colonisation and Branching times difference:",
          all.equal(min_age_1, min_age_2)
        )
      )
    }
    return(msg)
  }
}
