#' Extracts the information for an endemic clade (i.e. more than one species on
#' the island more closely related to each other than other mainland species)
#' from a phylogeny (specifically `phylo4d`  object from `phylobase` package)
#' and stores it in an `island_colonist` class
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `Island_colonist` class
#' @export
#'
#' @examples
#' set.seed(
#'   3,
#'   kind = "Mersenne-Twister",
#'   normal.kind = "Inversion",
#'   sample.kind = "Rejection"
#' )
#' phylo <- ape::rcoal(10)
#' phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
#'                      "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
#' phylo <- methods::as(phylo, "phylo4")
#' endemicity_status <- sample(
#'   x = c("not_present", "endemic", "nonendemic"),
#'   size = length(phylobase::tipLabels(phylo)),
#'   replace = TRUE,
#'   prob = c(0.7, 0.3, 0)
#' )
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' island_colonist <- extract_endemic_clade(
#'   phylod = phylod,
#'   species_label = "bird_i",
#'   unique_clade_name = TRUE
#' )
extract_endemic_clade <- function(phylod,
                                  species_label,
                                  unique_clade_name) {

  # check input data
  phylod <- check_phylo_data(phylod)

  # create an instance of the island_colonist class to store data
  island_colonist <- island_colonist()

  # set up variables to be modified in the loop
  all_siblings_endemic <- TRUE
  ancestor <- species_label
  descendants <- 1
  names(descendants) <- species_label

  # recursive tree traversal to find endemic clade
  while (all_siblings_endemic) {
    ancestor <- phylobase::ancestor(phy = phylod, node = ancestor)
    # save a copy of descendants for when loop stops
    endemic_clade <- descendants
    descendants <- phylobase::descendants(phy = phylod, node = ancestor)
    # get endemicity of siblings
    which_siblings <- which(phylobase::labels(phylod) %in% names(descendants))
    sibling_endemicity <-
      phylobase::tdata(phylod)[which_siblings, "endemicity_status"]
    all_siblings_endemic <- all(sibling_endemicity == "endemic")
  }

  # use S3 phylo objects for speed
  # suppress warnings about tree conversion as they are fine
  phylo <- suppressWarnings(methods::as(phylod, "phylo"))

  # extract colonisation time as stem age of clade (time before present)
  mrca <- ape::getMRCA(phylo, tip = endemic_clade)
  stem <- phylo$edge[which(phylo$edge[, 2] == mrca), 1]
  col_times <- ape::node.depth.edgelength(phy = phylo)

  # convert from distance from root to distance from tip
  col_times <- abs(col_times - max(col_times))

  # get only the stem age
  col_time <- col_times[stem]

  # prune species with multiple subspecies to a single species
  split_species_names <- strsplit(x = names(endemic_clade), split = "_")
  genus_name <- sapply(split_species_names, "[[", 1)
  species_name <- sapply(split_species_names, "[[", 2)
  genus_species_name <- paste(genus_name, species_name, sep = "_")
  if (any(duplicated(genus_species_name))) {
    endemic_clade <- endemic_clade[-which(duplicated(genus_species_name))]
  }

  # subset the endemic clade from the rest of the tree
  endemic_clade_phylod <- phylobase::subset(
    x = phylod,
    tips.include = endemic_clade
  )

  # use S3 phylo objects for speed
  # suppress warnings about tree conversion as they are fine
  phylo <- suppressWarnings(methods::as(endemic_clade_phylod, "phylo"))

  # extract branching times (time before present)
  node_heights <- ape::node.depth.edgelength(phy = phylo)

  # convert units from million years to years and round to nearest 10 years to
  # prevent duplicate branching times that differ due to numerical imprecision
  node_heights <- round_up(n = node_heights * 1e5, digits = 0)
  node_heights <- node_heights / 1e5

  # convert from distance from root to distance from tip
  node_heights <- abs(node_heights - max(node_heights))

  # remove any duplicates if two species come from the same branching event
  branching_times <- sort(unique(node_heights), decreasing = TRUE)

  # remove any zero valued branching times
  branching_times <- branching_times[-which(branching_times == 0)]

  # add the colonisation time to the branching times
  branching_times <- c(col_time, branching_times)

  # remove duplicate values if colonisation and first branching time are equal
  branching_times <- unique(branching_times)

  # extract clade name from species labels
  clade_name <- extract_clade_name(clade = endemic_clade)

  # assign data to instance of island_colonist class
  if (unique_clade_name) {
    set_clade_name(island_colonist) <- species_label
  } else {
    set_clade_name(island_colonist) <- clade_name
  }
  set_status(island_colonist) <- "endemic"
  set_missing_species(island_colonist) <- 0
  set_branching_times(island_colonist) <- branching_times

  # return island_colonist class
  island_colonist
}
