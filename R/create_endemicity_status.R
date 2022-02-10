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
#' set.seed(1)
#' phylo <- ape::rcoal(4)
#' phylo$tip.label <- c("species_a", "species_b", "species_c", "species_d")
#' phylo <- as(phylo, "phylo4")
#' island_species <- data.frame(
#'   tip_labels = c("species_a", "species_b", "species_c", "species_d"),
#'   tip_endemicity_status = c("endemic", "endemic", "endemic", "nonendemic")
#' )
#' endemicity_status <- create_endemicity_status(
#'   phylo = phylo,
#'   island_species = island_species
#' )

create_endemicity_status <- function(phylo, island_species) {

  # check the phylo input
  correct_class <- class(phylo) %in% c("phylo", "phylo4")
  if (isFALSE(correct_class)) {
    stop("The phylo object should be a 'phylo' or 'phylo4' object")
  }

  if (class(phylo) == "phylo") {
    phylo <- as(phylo, "phylo4")
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
  tips_found <- which(island_species$tip_labels %in% rownames(endemicity_status))
  endemicity_status[tips_found, ] <- island_species$tip_endemicity_status

  # return endemicity_status
  endemicity_status
}
