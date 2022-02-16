#' Documentation for function in the DAISIEprep package
#'
#' @param island_colonist An instance of the `Island_colonist` class.
#' @param island_tbl An instance of the `Island_tbl` class.
#' @param phylod A `phylo4d` object from the package `phylobase` containing
#' phylogenetic and endemicity data for each species.
#' @param colonisation_time A character string specifying whether the
#' colonisation time extracted is the minimum time (`max`) (before the present),
#' or the most probable time under ancestral state reconstruction (`asr`).
#' @param species_label The tip label of the species of interest.
#' @param x An object whose class is determined by the signature.
#' @param value A value which can take several forms to be assigned to an object
#' of a class.
#' @param clade_name Character name of the colonising clade.
#' @param status Character endemicity status of the colonising clade.
#' @param missing_species Numeric number of missing species from the phylogeny
#' that belong to the colonising clade.
#' @param branching_times Numeric vector of one or more elements where the first
#' element is the colonisation time and subsequent elements are the branching
#' times on the island.
#' @param min_age Numeric minimum age (time before the present) that the species
#' must have colonised the island by. This is known when there is a branching
#' on the island, either in species or subspecies.
#' @param endemic_clade Named vector with all the species from a clade.
#' @param phylo A `phylo4` object from the package `phylobase`.
#' @param island_species Data frame with two columns. The first is a character
#' string of the tip_labels with the tip names of the species on the island.
#' The second column a character string of the endemicity status of the species,
#' either endemic or nonendemic.
#'
#' @return Nothing
#' @author Joshua W. Lambert
default_params_doc <- function(island_colonist,
                               island_tbl,
                               phylod,
                               colonisation_time,
                               species_label,
                               x,
                               value,
                               clade_name,
                               status,
                               missing_species,
                               branching_times,
                               min_age,
                               endemic_clade,
                               phylo,
                               island_species) {
  # nothing
}
