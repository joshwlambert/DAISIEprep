#' Extracts the colonisation, diversification, and endemicty data from
#' phylogenetic and endemicity data and stores it in an `Island_tbl` object
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `island_tbl` class
#' @export
#'
#' @examples
#' set.seed(1)
#' phylo <- ape::rcoal(10)
#' phylo <- as(phylo, "phylo4")
#' endemicity_status <- sample(c("not_present", "endemic", "nonendemic"),
#'                             size = length(phylobase::tipLabels(phylo)),
#'                             replace = TRUE)
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' extract_island_species(phylod)
extract_island_species <- function(phylod,
                                   island_tbl = NULL) {

  if (is.null(island_tbl)) {
    tbl <- island_tbl()
  } else {
    tbl <- island_tbl
  }

  # if no species are on the island
  if (all(identical(phylod@data$endemicity_status, "not_present"))) {
    return(tbl)
  }

  for (i in seq_len(nrow(phylod@data))) {

    # extract any nonendemic and endemic species is on the island
    if (identical(phylod@data$endemicity_status[i], "nonendemic")) {

      # does species have multiple tips in the tree (i.e. population sampling)
      multi_tip_species <- is_multi_tip_species(
        phylod = phylod,
        species_label = as.character(phylod@label[i])
      )

      # if the nonendemic is a single tip or multi tip
      if (isTRUE(multi_tip_species)) {
        island_colonist <- extract_multi_tip_nonendemic(
          phylod = phylod,
          species_label = as.character(phylod@label[i])
        )
      } else {
        island_colonist <- extract_nonendemic(
          phylod = phylod,
          species_label = as.character(phylod@label[i])
        )
      }

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
