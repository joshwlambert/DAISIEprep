#' Checks whether the focal species (given by its tip lable in species_label
#' argument) is part of an endemic clade on the island
#'
#' @inheritParams default_params_doc
#'
#' @return Boolean
#' @export
#'
#' @examples x = 1
is_island_clade <- function(phylod,
                            species_label) {
  browser()
  #TODO edit this because the phylobase::siblings function cannot handle the outgroup when it goes to the crown age
  sibling_nodes <- phylobase::siblings(
    phy = phylod,
    node = phylobase::getNode(x = phylod, species_label)
  )
  siblings <- names(sibling_nodes)
  which_siblings <- as.numeric(which(phylobase::labels(phylod) %in% siblings))
  sibling_endemicity <- phylobase::tdata(phylod)[which_siblings, ]
  all_island_endemics <- all(sibling_endemicity == "endemic")

  # return boolean of species is in endemic clade
  all_island_endemics
}
