#' Title
#'
#' @param phylod
#' @param species_label
#' @param island_tbl
#'
#' @return
#' @export
#'
#' @examples
extract_species_min <- function(phylod,
                                species_label,
                                species_endemicity,
                                island_tbl) {

  # extract any nonendemic and endemic species is on the island
  if (identical(species_endemicity, "nonendemic")) {

    # does species have multiple tips in the tree (i.e. population sampling)
    multi_tip_species <- is_multi_tip_species(
      phylod = phylod,
      species_label = species_label
    )

    # if the nonendemic is a single tip or multi tip
    if (isTRUE(multi_tip_species)) {
      island_colonist <- extract_multi_tip_nonendemic(
        phylod = phylod,
        species_label = species_label
      )
    } else {
      island_colonist <- extract_nonendemic(
        phylod = phylod,
        extraction_method = extraction_method,
        species_label = species_label
      )
    }

    # check if colonist has already been stored in island_tbl class
    duplicate_colonist <- is_duplicate_colonist(
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
  } else if (identical(species_endemicity, "endemic")) {
    island_colonist <- extract_endemic(
      phylod = phylod,
      species_label = species_label
    )

    # check if colonist has already been stored in island_tbl class
    duplicate_colonist <- is_duplicate_colonist(
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

