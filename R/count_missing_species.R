#' Reads in the checklist of all species on an island, including those that are
#' not in the phylogeny (represented by NA) and counts the number of species
#' missing from the phylogeny each genus
#'
#' @inheritParams default_params_doc
#'
#' @return Data frame
#' @export
#'
#' @examples
#' mock_checklist <- data.frame(
#'   species_names = c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
#'                     "bird_f","bird_g", "bird_h", "bird_i", "bird_j"),
#'   sampled = c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE),
#'   endemicity_status = c("endemic", "endemic", "endemic", "nonendemic",
#'                         "endemic", "nonendemic", "endemic", "endemic",
#'                         "endemic", "endemic"),
#'   remove_species = (rep(FALSE, 10))
#' )
#' missing_species <- count_missing_species(
#'   checklist = mock_checklist,
#'   phylo_name_col = "species_names",
#'   in_phylo_col = "sampled",
#'   endemicity_status_col = "endemicity_status",
#'   rm_species_col = NULL
#' )
count_missing_species <- function(checklist,
                                  phylo_name_col,
                                  in_phylo_col,
                                  endemicity_status_col,
                                  rm_species_col = NULL) {

  if (!is.data.frame(checklist)) stop("checklist must be a data frame")
  if (!is.character(phylo_name_col)) stop("phylo_name_col must be a character")
  if (!is.character(in_phylo_col)) stop("in_phylo_col must be a character")
  if (!is.character(endemicity_status_col)) {
    stop("endemicity_status_col must be a character")
  }
  if (!is.character(rm_species_col) && !is.null(rm_species_col)) {
    stop("rm_species_col must be a character or NULL")
  }

  # remove species that are tagged as needing removal from the data set
  # likely as they are introduced (alien) to the island
  if (!is.null(rm_species_col)) {
    rm_species <- which(checklist[, rm_species_col])
    if (length(rm_species) > 0) {
      checklist <- checklist[-rm_species, ]
    }
  }

  # check data is boolean
  if (any(!is.logical(checklist[, in_phylo_col]))) stop("Must be boolean values")
  not_in_tree <- which(!checklist[, in_phylo_col])

  # get the genus name from the tree complete tree if sampled
  phylo_genus <- checklist[not_in_tree, phylo_name_col]
  phylo_genus <- strsplit(x = phylo_genus, split = "_")
  missing_genus <- sapply(phylo_genus, "[[", 1)

  # get the endemicity status for each species
  endemicity_status <- checklist[not_in_tree, endemicity_status_col]

  # standardise endemicity statuses
  endemicity_status <- Vectorize(
    FUN = DAISIEprep::translate_status,
    vectorize.args = "status"
  )(endemicity_status)
  endemicity_status <- unname(endemicity_status)

  missing_genus <- paste(missing_genus, endemicity_status, sep = "_")

  # sum the number of missing species in each genera
  missing_species <- table(missing_genus)

  missing_species <- as.data.frame(missing_species)

  missing_species$missing_genus <- as.character(missing_species$missing_genus)

  colnames(missing_species) <- c("clade_name", "missing_species")

  # make clade name and endemicity status separate columns
  split_name <- strsplit(missing_species$clade_name, split = "_")
  missing_species$clade_name <- sapply(split_name, "[[", 1)
  missing_species$endemicity_status <- sapply(split_name, "[[", 2)

  # return missing species data frame
  missing_species
}
