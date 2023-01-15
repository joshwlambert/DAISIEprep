#' Creates a data frame with the endemicity status (either 'endemic',
#' 'nonendemic', 'not_present') of every species in the phylogeny using a
#' phylogeny and a data frame of the island species and their endemicity (either
#' 'endemic' or 'nonendemic') provided.
#'
#' @inheritParams default_params_doc
#'
#' @return Data frame with single column of character strings and row names
#' @export
#'
#' @examples
#' set.seed(
#'   1,
#'   kind = "Mersenne-Twister",
#'   normal.kind = "Inversion",
#'   sample.kind = "Rejection"
#' )
#' phylo <- ape::rcoal(4)
#' phylo$tip.label <- c("species_a", "species_b", "species_c", "species_d")
#' phylo <- methods::as(phylo, "phylo4")
#' island_species <- data.frame(
#'   tip_labels = c("species_a", "species_b", "species_c", "species_d"),
#'   tip_endemicity_status = c("endemic", "endemic", "endemic", "nonendemic")
#' )
#' endemicity_status <- create_endemicity_status(
#'   phylo = phylo,
#'   island_species = island_species
#' )
create_endemicity_status <- function(phylo,
                                     island_species) {

  # check the phylo input
  correct_class <- inherits(phylo, c("phylo", "phylo4"))
  if (isFALSE(correct_class)) {
    stop("The phylo object should be a 'phylo' or 'phylo4' object")
  }

  if (inherits(phylo, "phylo")) {
    phylo <- phylobase::phylo4(phylo)
  }

  # check the data frame input
  correct_colnames <- identical(
    colnames(island_species),
    c("tip_labels", "tip_endemicity_status")
  )
  if (isFALSE(correct_colnames)) {
    stop("The column names of the island species data frame need to be
         'tip_labels' and 'tip_endemicity_status' respectively")
  }

  # create a data frame where all species are not present
  tip_labels <- unname(phylobase::tipLabels(phylo))
  init_endemicity_status <- rep("not_present", length(tip_labels))
  endemicity_status <- data.frame(
    endemicity_status = init_endemicity_status
  )
  rownames(endemicity_status) <- tip_labels

  # replace the species endemicity status with those given in island_species
  for (i in seq_along(island_species$tip_labels)) {
    on_island <- grepl(
      pattern = paste0("^", island_species$tip_labels[i], "$"),
      x = rownames(endemicity_status)
    )
    if (any(on_island)) {
      if (sum(on_island) > 1) {
        warning("There are multiple tips matched to a single species")
      }
      island <- which(on_island)
      species_endemicity <- translate_status(
        status = island_species$tip_endemicity_status[i]
      )
      endemicity_status[island, ] <- species_endemicity
    }
  }


  # return endemicity_status
  endemicity_status
}
