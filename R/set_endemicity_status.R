set_endemicity_status <- function(phylo, island_species) {


  correct_colnames <- identical(colnames(island_species),
                                c("tip_labels", "tip_endemicity_status"))
  if (isFALSE(correct_colnames)) {
    stop("The column names of the island species data frame need to be
         'tip_labels' and 'tip_endemicity_status' respectively")
  }

  tip_labels <- unname(phylobase::tipLabels(phylo))
  init_endemicity_status <- rep("not_present", length(tip_labels))
  endemicity_status <- data.frame(
    endemicity_status = init_endemicity_status
  )
  rownames(endemicity_status) <- tip_labels

  tips_found <- which(island_species$tip_labels == rownames(endemicity_status))
  endemicity_status[tips_found, ] <- island_species$tip_endemicity_status

  # return endemicity_status
  endemicity_status
}
