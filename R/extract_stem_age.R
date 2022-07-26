#' Extracts the stem age from the phylogeny when the a species is known to
#' belong to a genus but is not itself in the phylogeny and there are members
#' of the same genus are in the phylogeny. The stem age can either be for the
#' genus (or several genera) in the tree (`stem = "genus"`) or use an extraction
#' algorithm to find the stem of when the species colonised the island
#' (`stem = "island_presence`), either 'min' or 'asr' as in
#' extract_island_species(). When `stem = "island_presence"`
#' the reconstructed node states are used
#' to determine the stem age.
#'
#' @inheritParams default_params_doc
#'
#' @return Numeric
#' @export
#'
#' @examples
#' # In this example the parrot clade is the genus of interest only the parrots
#' # are endemic to the island and all the passerines are not on the island
#' set.seed(1)
#' tree <- ape::rcoal(10)
#' tree$tip.label <- c(
#'   "passerine_a", "passerine_b", "passerine_c", "passerine_d", "passerine_e",
#'   "passerine_f", "parrot_a", "parrot_b", "parrot_c", "passerine_j")
#' tree <- phylobase::phylo4(tree)
#' endemicity_status <- c(
#'   "not_present", "not_present", "not_present", "not_present", "not_present",
#'   "not_present", "endemic", "endemic", "endemic", "not_present")
#' phylod <- phylobase::phylo4d(tree, as.data.frame(endemicity_status))
#' DAISIEprep::plot_phylod(phylod)
#' # the species 'parrot_a' is removed and becomes the missing species we want
#' # to the know the stem age for
#' phylod <- phylobase::subset(x = phylod, tips.exclude = "parrot_a")
#' DAISIEprep::plot_phylod(phylod)
#' extract_stem_age(
#'   genus_name = "parrot",
#'   phylod = phylod,
#'   stem = "island_presence",
#'   extraction_method = "min"
#' )
#' # here we use the extraction_method = "asr" which requires ancestral node
#' # states in the tree.
#' phylod <- add_asr_node_states(
#'   phylod = phylod,
#'   asr_method = "parsimony",
#'   tie_preference = "mainland"
#' )
#' DAISIEprep::plot_phylod(phylod)
#' extract_stem_age(
#'   genus_name = "parrot",
#'   phylod = phylod,
#'   stem = "island_presence",
#'   extraction_method = "asr"
#' )
#' # lastly we extract the stem age based on the genus name
#' extract_stem_age(
#'   genus_name = "parrot",
#'   phylod = phylod,
#'   stem = "genus",
#'   extraction_method = NULL
#' )
extract_stem_age <- function(genus_name,
                             phylod,
                             stem,
                             extraction_method = NULL) {

  # get genus name from tip labels in tree
  species_names <- unname(phylobase::tipLabels(phylod))
  split_species_names <- strsplit(x = species_names, split = "_")
  genus_names <- sapply(split_species_names, "[[", 1)

  # match the genus with species in the tree
  genus_in_tree <- which(genus_names %in% genus_name)

  if (length(genus_in_tree) == 0) {
    message("Genus input is not found in the tree")
    return(NaN)
  }

  if (stem == "genus") {
    col_time <- extract_stem_age_genus(
      genus_in_tree = genus_in_tree,
      phylod = phylod
    )
  } else if (stem == "island_presence") {

    if (extraction_method == "min") {
      col_time <- extract_stem_age_min(
        genus_in_tree = genus_in_tree,
        phylod = phylod
      )
    } else if (extraction_method == "asr") {
      col_time <- extract_stem_age_asr(
        genus_in_tree = genus_in_tree,
        phylod = phylod
      )
    } else {
      stop("Incorrect extraction_method given, must be 'min' or 'asr'")
    }
  } else {
    stop("Incorrect stem given, must be 'genus' or 'island_presence'")
  }

  # return stem age
  col_time
}
