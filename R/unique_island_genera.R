#' Determines the unique endemic genera that are included in the island clades
#' contained within the island_tbl object and stores them as a list with each
#' genus only occuring once in the first island clade it appears in
#'
#' @inheritParams default_params_doc
#'
#' @return list of character vectors
#' @export
#'
#' @examples
#' phylod <- create_test_phylod(test_scenario = 6)
#' island_tbl <- suppressWarnings(extract_island_species(
#'   phylod = phylod,
#'   extraction_method = "asr",
#' ))
#' phylod <- create_test_phylod(test_scenario = 7)
#' island_tbl <- suppressWarnings(extract_island_species(
#'   phylod = phylod,
#'   extraction_method = "asr",
#'   island_tbl = island_tbl
#' ))
#' unique_genera <- unique_island_genera(island_tbl = island_tbl)
unique_island_genera <- function(island_tbl) {

  # convert island_tbl to data frame
  island_tbl <- DAISIEprep::get_island_tbl(island_tbl)

  # get the species from each island colonist and extract the genus name
  island_tbl_split_names <- lapply(island_tbl$species, strsplit, split = "_")
  island_tbl_genus_names <- lapply(island_tbl_split_names, function(x) {
    lapply(x, "[[", 1)
  })
  island_tbl_genus_names <- lapply(island_tbl_genus_names, unlist)

  # are there any genera that are found separate clades
  # when a duplicate genus is found the first one is kept
  # instead of keeping the first it could be assigned randomly

  # get unique genera from each clade
  genus_unique <- lapply(island_tbl_genus_names, unique)

  # get the endemicity status from each island colonist
  island_tbl_status <- island_tbl$status

  # which genera are non-endemic
  nonendemic_genus <- which(island_tbl_status == "nonendemic")

  # remove non-endemic elements as they cannot be assigned missing species
  # if non-endemics are left in then missing species might not properly be
  # assigned in DAISIEprep::add_multi_missing_species()
  genus_unique[nonendemic_genus] <- NA_character_

  # make list that will contain unique genera
  missing_genus <- genus_unique
  # take set difference between contents of list elements and accumulated
  # elements
  missing_genus[-1] <- mapply(
    setdiff,
    missing_genus[-1],
    utils::head(Reduce(c, genus_unique, accumulate = TRUE), -1)
  )

  # return missing_genus
  missing_genus
}
