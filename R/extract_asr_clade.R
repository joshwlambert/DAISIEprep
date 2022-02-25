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
                              ancestor,
                              clade) {

  # create an instance of the island_colonist class to store data
  island_col <- island_colonist()

  # extract colonisation time as stem age of clade (time before present)
  col_time <- as.numeric(phylobase::nodeHeight(
    x = phylod,
    node = ancestor,
    from = "min_tip"
  ))

  # subset the clade from the rest of the tree
  clade_phylod <- phylobase::subset(
    x = phylod,
    tips.include = clade
  )

  # extract branching times (time before present)
  node_heights <- c()
  for (i in seq_len(phylobase::nEdges(clade_phylod))) {
    node_heights[i] <- phylobase::nodeHeight(
      x = clade_phylod,
      node = i,
      from = "min_tip"
    )
  }

  # remove any duplicates if two species come from the same branching event
  branching_times <- sort(unique(node_heights), decreasing = TRUE)

  # remove any zero valued branching times
  branching_times <- branching_times[-which(branching_times == 0)]

  # add the colonisation time to the branching times
  branching_times <- c(col_time, branching_times)

  # remove duplicate values if colonisation and first branching time are equal
  branching_times <- unique(branching_times)

  # extract clade name from species labels
  clade_name <- extract_clade_name(clade = clade)

  # assign data to instance of island_colonist class
  set_clade_name(island_col) <- species_label #clade_name
  set_status(island_col) <- "endemic"
  set_missing_species(island_col) <- 0
  set_branching_times(island_col) <- branching_times

  # return island_colonist class
  island_col
}
