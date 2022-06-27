#' Extracts the stem age from the phylogeny when the a species is known to
#' belong to a genus but is not itself in the phylogeny and there are members
#' of the same genus are in the phylogeny. Extraction method can either be
#' 'min' or 'asr' as in extract_island_species(). When extraction_method = 'asr'
#' the constrain_to_island is ignored and the reconstructed node states are used
#' to determine the stem age and not the stem age of the genus or stem age of
#' island species within a genus (i.e. constrain_to_island = TRUE).
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
#' # here we set constrain_to_island = TRUE so it only looks at species in that
#' # genus that are on the island and constrains the stem age to the stem of the
#' # island subclade
#' extract_stem_age(
#'   genus_name = "parrot",
#'   phylod = phylod,
#'   extraction_method = "min",
#'   constrain_to_island = TRUE
#' )
#' # here we set constrain_to_island = FALSE so it extracts the stem age of the
#' # genus independent of whether any species in that genus are on the island
#' # or not
#' extract_stem_age(
#'   genus_name = "parrot",
#'   phylod = phylod,
#'   extraction_method = "min",
#'   constrain_to_island = FALSE
#' )
#' # here we use the extraction_method = "asr" which requires ancestral node
#' # states in the tree. When "asr" is used the constrain_to_island argument
#' # becomes redundant and is ignored, setting constrain_to_island to TRUE or
#' # FALSE will not change the stem age extracted
#' phylod <- add_asr_node_states(
#'   phylod = phylod,
#'   asr_method = "parsimony",
#'   tie_preference = "mainland"
#' )
#' DAISIEprep::plot_phylod(phylod)
#' extract_stem_age(
#'   genus_name = "parrot",
#'   phylod = phylod,
#'   extraction_method = "asr",
#'   constrain_to_island = FALSE
#' )
extract_stem_age <- function(genus_name,
                             phylod,
                             extraction_method,
                             constrain_to_island = FALSE) {

  # get genus name from tip labels in tree
  species_names <- unname(phylobase::tipLabels(phylod))
  split_species_names <- strsplit(x = species_names, split = "_")
  genus_names <- sapply(split_species_names, "[[", 1)

  # match the genus with species in the tree
  genus_in_tree <- which(genus_name == genus_names)

  if (length(genus_in_tree) == 0) {
    message("Genus input is not found in the tree")
    return(NaN)
  }

  endemicity_status <-
    phylobase::tdata(phylod)[genus_in_tree, "endemicity_status"]
  if (all(endemicity_status == "not_present") && constrain_to_island) {
    stop("constrain_to_island = TRUE but no island species in genus found")
  }

  if (extraction_method == "min") {
    col_time <- extract_stem_age_min(
      genus_in_tree = genus_in_tree,
      phylod = phylod,
      constrain_to_island = constrain_to_island
    )
  } else if (extraction_method == "asr") {
    col_time <- extract_stem_age_asr(
      genus_in_tree = genus_in_tree,
      phylod = phylod
    )
  } else {
    stop("Incorrect extraction_method given, must be 'min' or 'asr'")
  }

  # return stem age
  col_time
}
