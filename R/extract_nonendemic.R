#' Extracts the information for a non-endemic species from a phylogeny
#' (specifically `phylo4d`  object from `phylobase` package) and stores it in
#' in an `island_colonist` class
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `island_colonist` class
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
#' phylo <- methods::as(phylo, "phylo4")
#' endemicity_status <- sample(c("not_present", "endemic", "nonendemic"),
#'                               size = length(phylobase::tipLabels(phylo)),
#'                               replace = TRUE)
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' extract_nonendemic(phylod = phylod, species_label = "t7")
extract_nonendemic <- function(phylod,
                               species_label) {

    # create an instance of the island_colonist class to store data
    island_col <- island_colonist()

    #TODO: write check that the species_label refers to nonendemic species

    # assign data to instance of island_colonist class
    set_clade_name(island_col) <- species_label
    set_status(island_col) <- "nonendemic"
    set_missing_species(island_col) <- 0
    set_branching_times(island_col) <-
      as.numeric(phylobase::edgeLength(phylod, species_label))

  #return instance of island_colonist class
  island_col
}
