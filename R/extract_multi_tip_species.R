#' Extracts the information for a species (endemic or non-endemic) which has
#' multiple tips in the phylogeny (i.e. more than one sample per species) from
#' a phylogeny (specifically `phylo4d`  object from `phylobase` package)
#' and stores it in an `Island_colonist` class
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `Island_colonist` class
#' @export
#'
#' @examples
#' set.seed(
#'   1,
#'   kind = "Mersenne-Twister",
#'   normal.kind = "Inversion",
#'   sample.kind = "Rejection"
#' )
#' phylo <- ape::rcoal(10)
#' phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
#'                      "bird_f", "bird_g", "bird_h_1", "bird_h_2", "bird_i")
#' phylo <- phylobase::phylo4(phylo)
#' endemicity_status <- c("not_present", "not_present", "not_present",
#'                        "not_present", "not_present", "not_present",
#'                        "not_present",  "endemic", "endemic", "not_present")
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' extract_multi_tip_species(
#'   phylod = phylod,
#'   species_label = "bird_h_1",
#'   species_endemicity = "endemic"
#' )
extract_multi_tip_species <- function(phylod,
                                      species_label,
                                      species_endemicity) {

  # check input data
  phylod <- check_phylo_data(phylod)

  # create an instance of the island_colonist class to store data
  island_colonist <- island_colonist()

  # recursive tree traversal to find all nonendemic species in clade
  all_same_species <- TRUE
  ancestor <- species_label
  descendants <- species_label
  while (all_same_species) {
    ancestor <- phylobase::ancestor(phy = phylod, node = ancestor)
    # save a copy of descendants for when loop stops
    species_tips <- descendants
    descendants <- phylobase::descendants(phy = phylod, node = ancestor)
    # get endemicity of siblings
    which_siblings <- which(phylobase::labels(phylod) %in% names(descendants))
    sibling_endemicity <-
      phylobase::tdata(phylod)[which_siblings, "endemicity_status"]
    all_siblings_endemicity <- all(sibling_endemicity == species_endemicity)
    # get names of siblings
    descendants_names <- names(descendants)
    split_descendants_names <- strsplit(x = descendants_names, split = "_")
    descendants_genus_names <- sapply(split_descendants_names, "[[", 1)
    descendants_species_names <- sapply(split_descendants_names, "[[", 2)
    descendants_genus_species_names <- paste(
      descendants_genus_names, descendants_species_names, sep = "_"
    )

    # if all siblings have the same endemicity and all tips are the same species
    # continue
    island_multi_tip <- all_siblings_endemicity &&
      any(duplicated(descendants_genus_species_names))
    if (isFALSE(island_multi_tip)) {
      all_same_species <- FALSE
    }
  }

  # use S3 phylo objects for speed
  # suppress warnings about tree conversion as they are fine
  phylo <- suppressWarnings(methods::as(phylod, "phylo"))

  # extract colonisation time as stem age of clade (time before present)
  mrca <- ape::getMRCA(phylo, tip = species_tips)
  stem <- phylo$edge[which(phylo$edge[, 2] == mrca), 1]
  col_times <- ape::node.depth.edgelength(phy = phylo)

  # convert from distance from root to distance from tip
  col_times <- abs(col_times - max(col_times))

  # get only the stem age
  col_time <- col_times[stem]

  # subset the multi-tip nonendemic species from the rest of the tree
  multi_tip_species_phylod <- phylobase::subset(
    x = phylod,
    tips.include = species_tips
  )

  # use S3 phylo objects for speed
  # suppress warnings about tree conversion as they are fine
  phylo <- suppressWarnings(methods::as(multi_tip_species_phylod, "phylo"))

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

  # extract minimum time as crown age of species pops (time before present)
  min_age <- max(branching_times)

  # assign data to instance of island_colonist class
  # extract species name from species label
  species_name <- unlist(strsplit(x = species_label, split = "_"))[1:2]
  species_name <- paste(species_name, collapse = "_")
  set_clade_name(island_colonist) <- species_name
  set_status(island_colonist) <- species_endemicity
  set_missing_species(island_colonist) <- 0
  set_col_time(island_colonist) <- col_time
  set_col_max_age(island_colonist) <- FALSE
  set_branching_times(island_colonist) <- NA_real_
  set_min_age(island_colonist) <- min_age
  set_species(island_colonist) <- names(species_tips)
  set_clade_type(island_colonist) <- 1

  # return instance of island_colonist class
  island_colonist
}
