#' Detects any cases where a non-endemic species or species not present on the
#' island has likely been on the island given its ancestral state reconstruction
#' indicating ancestral presence on the island and so is likely a back
#' colonisation from the island to the mainland (or potentially different
#' island). This function is useful if using extraction_method = "min" in
#' DAISIEprep::extract_island_species() as it may brake up a single colonist
#' into multiple colonists because of back-colonisation.
#'
#' @inheritParams default_params_doc
#'
#' @return A named vector
#' @export
#'
#' @examples
#' \dontrun{
#' set.seed(
#'   1,
#'   kind = "Mersenne-Twister",
#'   normal.kind = "Inversion",
#'   sample.kind = "Rejection"
#' )
#' phylo <- ape::rcoal(10)
#' phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
#'                      "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
#' phylo <- methods::as(phylo, "phylo4")
#' endemicity_status <- sample(c("not_present", "endemic", "nonendemic"),
#'                             size = length(phylobase::tipLabels(phylo)),
#'                             replace = TRUE)
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' any_back_colonisation(phylod)
#' }
any_back_colonisation <- function(phylod) {


  # check data input has node data
  missing_node_data <- "island_status" %in% names(phylobase::nodeData(phylod))

  if (isFALSE(missing_node_data)) {
    stop("This function requires ancestral state reconstruction data of the
         island presence at the nodes")
  }

  # loop through the phylogeny and determine if each tip is a back colonisation
  back_cols <- c()
  back_col_spec <- c()
  for (i in seq_len(phylobase::nTips(phylod))) {
    back_cols[i] <- is_back_colonisation(
      phylod = phylod,
      species_label = unname(phylobase::tipLabels(phylod))[i]
    )

    # if tip is back colonist give it the name of the species
    if (isTRUE(back_cols[i])) {
      back_cols_spec <- unname(phylobase::tipLabels(phylod))[i]
    } else {
      back_cols_spec <- NA_character_
    }
  }
  names(back_cols) <- back_col_spec

  # return the named vector
  back_cols
}
