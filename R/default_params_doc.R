#' Documentation for function in the DAISIEprep package
#'
#' @param island_colonist An instance of the `Island_colonist` class.
#' @param island_tbl An instance of the `Island_tbl` class.
#' @param phylod A `phylo4d` object from the package `phylobase` containing
#' phylogenetic and endemicity data for each species.
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
#' @param endemic_clade Named vector with all the species from a clade.
#'
#' @return Nothing
#' @author Joshua W. Lambert
default_params_doc <- function(island_colonist,
                               island_tbl,
                               phylod,
                               species_label,
                               x,
                               value,
                               clade_name,
                               status,
                               missing_species,
                               branching_times,
                               endemic_clade) {
  # nothing
}
