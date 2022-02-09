#' Checks whether phylo (or phylo4 or phylo4d) object conforms
#' to the requirements of the DAISIEprep package. If TRUE is returned the data
#' is ready to be used, if FALSE is returned the data requires some
#' pre-processing before DAISIEprep can be used
#'
#' @inheritParams default_params_doc
#'
#' @return Nothing
#' @export
#'
#' @examples
#' set.seed(1)
#' phylo <- ape::rcoal(10)
#' phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
#'                      "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
#'                      phylo <- as(phylo, "phylo4")
#' endemicity_status <- sample(c("not_present", "endemic", "nonendemic"),
#'                               size = length(phylobase::tipLabels(phylo)),
#'                               replace = TRUE)
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' check_phylo_data(phylod)
check_phylo_data <- function(phylod) {
  if (isFALSE(is(phylod, "phylo4d"))) {
    stop("Object must be of the class phylo4d")
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
