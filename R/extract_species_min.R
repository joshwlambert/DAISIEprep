#' Extracts the colonisation, diversification, and endemicty data from
#' phylogenetic and endemicity data and stores it in an `Island_tbl` object
#' using the "min" algorithm that extract island species as the shortest time
#' to the present.
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `island_tbl` class
#' @export
#'
#' @examples
#' set.seed(
#'   1,
#'   kind = "Mersenne-Twister",
#'   normal.kind = "Inversion",
#'   sample.kind = "Rejection"
#' )
#' phylo <- ape::rcoal(10)
#' phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
#'                      "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
#' phylo <- phylobase::phylo4(phylo)
#' endemicity_status <- sample(
#'   c("not_present", "endemic", "nonendemic"),
#'   size = length(phylobase::tipLabels(phylo)),
#'   replace = TRUE,
#'   prob = c(0.6, 0.2, 0.2)
#' )
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' island_tbl <- island_tbl()
#' extract_species_min(
#'   phylod = phylod,
#'   species_label = "bird_g",
#'   species_endemicity = "nonendemic",
#'   island_tbl = island_tbl
#' )
extract_species_min <- function(phylod,
                                species_label,
                                species_endemicity,
                                island_tbl) {

  # check input data
  phylod <- check_phylo_data(phylod)

  # extract any nonendemic and endemic species is on the island
  if (identical(species_endemicity, "nonendemic")) {

    # does species have multiple tips in the tree (i.e. population sampling)
    multi_tip_species <- is_multi_tip_species(
      phylod = phylod,
      species_label = species_label
    )

    # if the nonendemic is a single tip or multi tip
    if (isTRUE(multi_tip_species)) {
      island_colonist <- extract_multi_tip_species(
        phylod = phylod,
        species_label = species_label,
        species_endemicity = "nonendemic"
      )
    } else {
      island_colonist <- extract_nonendemic(
        phylod = phylod,
        species_label = species_label
      )
    }

    # append species in clade to island_tbl
    #set_extracted_species(island_tbl) <- names(clade)

  } else if (identical(species_endemicity, "endemic")) {
    island_colonist <- extract_endemic(
      phylod = phylod,
      species_label = species_label
    )
  }

  # check if colonist has already been stored in island_tbl class
  duplicate_colonist <- is_duplicate_colonist(
    island_colonist = island_colonist,
    island_tbl = island_tbl
  )

  if (duplicate_colonist) {
    print("here")
  }

  if (!duplicate_colonist) {
    # bind data from island_colonist class into island_tbl class
    island_tbl <- bind_colonist_to_tbl(
      island_colonist = island_colonist,
      island_tbl = island_tbl
    )
  }

  #return instance of island_tbl class
  island_tbl
}
