#' Extracts an island clade based on the ancestral state reconstruction of the
#' species presence on the island, therefore this clade can contain
#' non-endemic species as well as endemic species.
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `Island_colonist` class
#' @export
#'
#' @examples
#' \dontrun{
#' extract_asr_clade()
#' }
extract_asr_clade <- function(phylod,
                              species_label,
                              clade,
                              include_not_present) {

  # create an instance of the island_colonist class to store data
  island_colonist <- island_colonist()

  # get the ancestral state at the root
  root_state <-
    phylobase::tdata(phylod)[phylobase::rootNode(phylod), "island_status"]

  # if the root is on the island not not try to extract colonisation time
  if (root_state %in% c("endemic", "nonendemic")) {

    # set colonisation time to infinite when stem age of clade is not available
     col_time <- Inf

  } else {

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
  }

  # subset the clade from the rest of the tree
  phylod <- phylobase::subset(
    x = phylod,
    tips.include = clade
  )

  # get the names of the species in the clade
  species_in_clade <- names(clade)

  # remove not present species from the island clade
  if (isFALSE(include_not_present)) {

    # find which species are not present
    species_not_present <-
      which(phylobase::tipData(phylod)$endemicity_status == "not_present")

    # get names of species not present
    name_not_present <- phylobase::tipLabels(phylod)[species_not_present]

    # remove species from clade that are not present
    if (length(species_not_present) >= 1) {
      rm_species <- which(species_in_clade %in% name_not_present)
      species_in_clade <- species_in_clade[-rm_species]
    }

    num_subset_species <- phylobase::nTips(phylod) - length(name_not_present)

    if (num_subset_species >= 2) {
      # remove not present species from the clade
      phylod <- phylobase::subset(
        x = phylod,
        tips.exclude = name_not_present
      )
    }
  }

  # use S3 phylo objects for speed
  # suppress warnings about tree conversion as they are fine
  phylo <- suppressWarnings(methods::as(phylod, "phylo"))

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

  # remove duplicate values if colonisation and first branching time are equal
  if (col_time == branching_times[1]) {
    branching_times <- branching_times[-1]
  }

  # extract clade name from species labels
  clade_name <- extract_clade_name(
    clade = clade
  )

  # assign data to instance of island_colonist class
  set_clade_name(island_colonist) <- species_label #clade_name
  set_status(island_colonist) <- "endemic"
  set_missing_species(island_colonist) <- 0
  set_col_time(island_colonist) <- col_time
  set_col_max_age(island_colonist) <- FALSE
  set_branching_times(island_colonist) <- branching_times
  set_species(island_colonist) <- species_in_clade
  set_clade_type(island_colonist) <- 1

  # return island_colonist class
  island_colonist
}
