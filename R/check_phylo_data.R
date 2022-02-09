#' Checks whether `\linkS4class{phylo4d}` object conforms
#' to the requirements of the DAISIEprep package. If the function does not
#' return anything the data is ready to be used, if an error is returned the
#' data requires some pre-processing before DAISIEprep can be used
#'
#' @inheritParams default_params_doc
#'
#' @return Nothing or error message
#' @export
#'
#' @examples
#' library(phylobase)
#' set.seed(1)
#' phylo <- ape::rcoal(10)
#' phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
#'                      "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
#' phylo <- methods::as(phylo, "phylo4")
#' endemicity_status <- sample(c("not_present", "endemic", "nonendemic"),
#'                               size = length(phylobase::tipLabels(phylo)),
#'                               replace = TRUE)
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' check_phylo_data(phylod)
check_phylo_data <- function(phylod) {
  if (isFALSE(methods::is(phylod, "phylo4d"))) {
    stop("Object must be of the class phylo4d")
  }

  # extract the tip labels from the tree
  tip_labels <- unname(phylobase::tipLabels(phylod))
  split_tip_labels <- strsplit(tip_labels, split = "_")

  # check the tip labels are in genus_species_marker format (marker is optional)
  correct_structure <- all(sapply(split_tip_labels, function(x) {
    length(x) >= 2
  }))

  if (isFALSE(correct_structure)) {
    stop("Tip labels on the phylogeny need to be in the format genus underscore
         species and then optionally underscore and molecular marker or
         collection tag")
  }

  # extract genus names
  genus_name <- lapply(split_tip_labels, "[[", 1)

  #check genus name only contains letters
  correct_genus_name <- lapply(genus_name, function(x) {
    grep(pattern = "^[A-z]+$", x)
  })
  correct_genus_name <- all(sapply(correct_genus_name, function(x) {
    isTRUE(x == 1)
  }))

  # extract species names
  species_name <- lapply(split_tip_labels, "[[", 2)

  # check species name only contains letters
  correct_species_name <- sapply(species_name, function(x) {
    grep(pattern = "^[A-z]+$", x)
  })
  correct_species_name <- all(sapply(correct_species_name, function(x) {
    isTRUE(x == 1)
  }))

  correct_name <- correct_genus_name && correct_species_name

  if (isFALSE(correct_name)) {
    stop("The genus or species names in the tip labels contain non-alphabetic
         characters")
  }

  if (isFALSE(phylobase::hasTipData(phylod))) {
    stop("Object must have endemicity status stored as tip data")
  }

  if (names(phylobase::tipData(phylod)) != "endemicity_status") {
    stop("Tip data must be called endemicity_status")
  }

  status <- phylobase::tipData(phylod)$endemicity_status
  if (isFALSE(all(status %in% c("endemic", "nonendemic", "not_present")))) {
    stop("Endemicity status must be either 'endemic', 'nonendemic', or
         'not_present'")
  }

  invisible(phylod)
}
