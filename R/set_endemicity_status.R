set_endemicity_status <- function(phylo, island_species) {

  # check the phylo input
  correct_class <- class(phylo) %in% c("phylo", "phylo4")
  if (isFALSE(correct_class)) {
    stop("The phylo object should be a 'phylo' or 'phylo4' object")
  }

  # check the data frame input
  correct_colnames <- identical(
    colnames(island_species),
    c("tip_labels", "tip_endemicity_status")
  )
  if (isFALSE(correct_colnames)) {
    stop("The column names of the island species data frame need to be
         'tip_labels' and 'tip_endemicity_status' respectively")
  }

  # create a data frame where all species are not present
  tip_labels <- unname(phylobase::tipLabels(phylo))
  init_endemicity_status <- rep("not_present", length(tip_labels))
  endemicity_status <- data.frame(
    endemicity_status = init_endemicity_status
  )
  rownames(endemicity_status) <- tip_labels

  # replace the species endemicity status with those given in island_species
  tips_found <- which(island_species$tip_labels %in% rownames(endemicity_status))
  endemicity_status[tips_found, ] <- island_species$tip_endemicity_status

  # return endemicity_status
  endemicity_status
}
