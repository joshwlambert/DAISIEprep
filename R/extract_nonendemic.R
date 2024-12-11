#' Extracts the information for a non-endemic species from a phylogeny
#' (specifically `phylo4d`  object from `phylobase` package) and stores it in
#' in an `island_colonist` class
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `island_colonist` class
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
#'   x = c("not_present", "endemic", "nonendemic"),
#'   size = length(phylobase::tipLabels(phylo)),
#'   replace = TRUE,
#'   prob = c(0.6, 0.2, 0.2)
#' )
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' extract_nonendemic(phylod = phylod, species_label = "bird_g")
extract_nonendemic <- function(phylod,
                               species_label) {

  # check input data
  phylod <- check_phylo_data(phylod)

  # create an instance of the island_colonist class to store data
  island_colonist <- island_colonist()

  # assign data to instance of island_colonist class
  set_clade_name(island_colonist) <- species_label
  set_status(island_colonist) <- "nonendemic"
  set_missing_species(island_colonist) <- 0
  set_col_time(island_colonist) <-
    as.numeric(phylobase::edgeLength(phylod, species_label))
  set_col_max_age(island_colonist) <- FALSE
  set_branching_times(island_colonist) <- NA_real_
  set_species(island_colonist) <- species_label
  set_clade_type(island_colonist) <- 1

  #return instance of island_colonist class
  island_colonist
}

#' Extract non-endemic colonist that is forced to be a singleton by user
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `phylo4d` class with tip and node data
#' @keywords internal
extract_nonendemic_forced <- function(phylod,
                                      species_label,
                                      island_tbl) {
  island_colonist <- extract_nonendemic(
    phylod = phylod,
    species_label = species_label
  )
  # TODO: check if duplication checking is needed see extract_species_asr.R L133
  # bind data from island_colonist class into island_tbl class
  island_tbl <- bind_colonist_to_tbl(
    island_colonist = island_colonist,
    island_tbl = island_tbl
  )
  # append extracted species to vector
  set_extracted_species(island_tbl) <- species_label
  return(island_tbl)
}
