rm_nonendemic_in_clade <- function(phylod, island_tbl) {

  warning("Non-endemic species may be grouped within an endemic clade.\n",
          "force_nonendemic_singleton cannot remove non-endemic species from ",
          "endemic clades in these cases.")

  # TODO: this function is WIP. Currently it warns the user that non-endemics
  # cannot be forced when reconstructed within an endemic clade.

  # # check if non-endemics have been extracted in clade
  # species_in_clade <- phylod@label %in% get_extracted_species(island_tbl)
  # endemicity <- phylod@data$endemicity_status[species_in_clade]
  # if (any(endemicity == "nonendemic")) {
  #   nonendemics <- phylod@label[which(endemicity == "nonendemic")]
  #   endemics <- phylod@label[which(endemicity == "endemic")]
  #   endemic_idx <- !island_tbl@island_tbl$species[[1]] %in% nonendemics
  #   # check if clade name is from one of the non-endemic species if so rename
  #   if (island_tbl@island_tbl$clade_name %in% nonendemics) {
  #     # rename clade_name with first endemic species
  #     island_tbl@island_tbl$clade_name <- endemics[1]
  #   }
  #   # remove non-endemics from species list
  #   island_tbl@island_tbl$species[[1]] <- unname(endemics)
  #   # remove branching times of non-endemic species
  #
  #   # update colonisation time if different without non-endemic species
  # }
  return(island_tbl)
}
