#' Extracts the colonisation, diversification, and endemicty data from
#' phylogenetic and endemicity data and stores it in an `Island_tbl` object
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
#' extract_island_species(phylod, extraction_method = "min")
extract_island_species <- function(phylod,
                                   extraction_method,
                                   island_tbl = NULL,
                                   include_not_present = FALSE) {

  # check the input data
  phylod <- check_phylo_data(phylod)

  if (is.null(island_tbl)) {
    island_tbl <- island_tbl()
  }

  # check extraction_method and asr_method input
  missing_node_data <- "island_status" %in% names(phylobase::nodeData(phylod))

  if (extraction_method == "asr" && isFALSE(missing_node_data)) {
    stop("Using colonisation times from ancestral state reconstruction requires
         data of the island presence at the nodes")
  }

  # create extracted_species vector
  extracted_species <- c()

  island_species <- which(
    phylobase::tdata(phylod)$endemicity_status %in% c("endemic", "nonendemic")
  )
  for (i in island_species) {

    # if species has already been extracted in a clade no need to extract again
    extracted <- phylobase::tipLabels(phylod)[i] %in% extracted_species

    if (extracted) {
      next
    }

    if (extraction_method == "asr") {
      # extract species using the ancestral state reconstruction data
      island_tbl <- extract_species_asr(
        phylod = phylod,
        species_label = as.character(phylod@label[i]),
        species_endemicity = phylod@data$endemicity_status[i],
        island_tbl = island_tbl,
        include_not_present = include_not_present
      )
    } else if (extraction_method == "min") {
      island_tbl <- extract_species_min(
        phylod = phylod,
        species_label = as.character(phylod@label[i]),
        species_endemicity = phylod@data$endemicity_status[i],
        island_tbl = island_tbl
      )
    }

    # append extracted species to vector
    extracted_species <- c(extracted_species, get_extracted_species(island_tbl))

    # clear the extracted species from the island_tbl for next iteration
    set_extracted_species(island_tbl) <- NA_integer_
  }

  # return island_tbl class
  island_tbl
}
