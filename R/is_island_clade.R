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

  # get the most recent node of the focal tip
  sibling_nodes <- phylobase::siblings(
    phy = phylod,
    node = phylobase::getNode(x = phylod, species_label)
  )

  # get the descendants of that node
  siblings <- phylobase::descendants(phy = phylod, node = sibling_nodes)
  siblings_names <- names(siblings)

  # get endemicity of siblings
  which_siblings <- as.numeric(which(phylobase::labels(phylod) %in% siblings_names))
  sibling_endemicity <- phylobase::tdata(phylod)[which_siblings, ]

  # are all siblings endemic
  all_island_endemics <- all(sibling_endemicity == "endemic")

  # return boolean of species is in endemic clade
  all_island_endemics
}
