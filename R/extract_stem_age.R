#' Extracts the stem age from the phylogeny when the a species is known to
#' belong to a genus but is not itself in the phylogeny and there are members
#' of the same genus are in the phylogeny. If some species on
#'
#' @param genus_name
#' @param phylod
#' @param extraction_method
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
    stop("Genus input is not found in the tree")
  }

  endemicity_status <-
    phylobase::tdata(phylod)[genus_in_tree, "endemicity_status"]
  if (all(endemicity_status == "not_present") && constrain_to_island) {
    stop("constrain_to_island = TRUE but no island species in genus found")
  }

  extracted_col_times <- c()
  # add for loop to loop over genus_in_tree elements
  for (i in genus_in_tree) {
    species_label <- phylobase::tipLabels(phylod)[i]

    if (constrain_to_island) {
      species_endemicity <- phylobase::tdata(phylod)[i, "endemicity_status"]
      if (species_endemicity == "not_present") {
        next
      }
    }

    # set up variables to be modified in the loop
    all_siblings <- TRUE
    ancestor <- species_label
    descendants <- 1
    names(descendants) <- species_label

    # recursive tree traversal to find endemic clade
    while (all_siblings) {
      ancestor <- phylobase::ancestor(phy = phylod, node = ancestor)
      # save a copy of descendants for when loop stops
      clade <- descendants
      descendants <- phylobase::descendants(phy = phylod, node = ancestor)
      # get endemicity of siblings
      which_siblings <- which(phylobase::labels(phylod) %in% names(descendants))
      if (constrain_to_island) {
        # check whether all siblings are endemic when constraining to island
        # clade within the genus
        sibling_endemicity <-
          phylobase::tdata(phylod)[which_siblings, "endemicity_status"]
        all_siblings <- all(sibling_endemicity == "endemic")
      } else {
        # check whether all siblings are of the same genus when not constraining
        # to the island species within the genus
        sibling_genus <- unname(phylobase::tipLabels(phylod))[which_siblings]
        split_species_names <- strsplit(x = sibling_genus, split = "_")
        genus_names <- sapply(split_species_names, "[[", 1)
        all_siblings <- length(unique(genus_names)) == 1
      }
    }

    # use S3 phylo objects for speed
    # suppress warnings about tree conversion as they are fine
    phylo <- suppressWarnings(methods::as(phylod, "phylo"))

    # extract colonisation time as stem age of clade (time before present)
    mrca <- ape::getMRCA(phylo, tip = clade)
    stem <- phylo$edge[which(phylo$edge[, 2] == mrca), 1]
    col_times <- ape::node.depth.edgelength(phy = phylo)

    # convert from distance from root to distance from tip
    col_times <- abs(col_times - max(col_times))

    # get only the stem age
    col_time <- col_times[stem]

    # return stem age
    extracted_col_times <- c(extracted_col_times, col_time)
  }

  # maximum age from those extracted
  col_time <- max(extracted_col_times)

  # return stem age
  col_time
}
