#' Write biogeography input file for BioGeoBEARS
#'
#' Write a text file containing occurrence data for all tips in the PHYLIP format
#' expected by BioGeoBEARS
#'
#' @inheritParams default_params_doc
#' @param path_to_biogeo string specifying the path and name to write the file to.
#'
#' @export
#'
write_phylip_biogeo_file <- function(phylod, path_to_biogeo) {
  labels <- phylod@label
  ntips <- phylobase::nTips(phylod)
  endemicity <- phylod@data$endemicity_status[1:ntips]
  is_on_mainland <- as.integer(endemicity %in% c("nonendemic", "not_present"))
  is_on_island <- as.integer(endemicity %in% c("nonendemic", "endemic"))

  first_line <- paste0(ntips, "\t2\t(M I)\n")
  cat(first_line, file = path_to_biogeo, append = FALSE)
  for (i in seq_along(labels)) {
    next_line <- paste0(labels[i], "\t", is_on_mainland[i], is_on_island[i], "\n")
    cat(next_line, file = path_to_biogeo, append = TRUE)
  }
}

#' Write tree input file for BioGeoBEARS
#'
#' Write a text file containing a phylogenetic tree in the Newick format
#' expected by BioGeoBEARS
#'
#' @inheritParams default_params_doc
#' @param path_to_phylo string specifying the path and name to write the file to.
#'
#' @export
#'
write_newick_file <- function(phylod, path_to_phylo) {
  phylo <- as(phylod, "phylo")
  ape::write.tree(phylo, file = path_to_phylo)
}

#' Write input files for BioGeoBEARS
#'
#' Write input files for a BioGeoBEARS analysis, i.e. a phlyogenetic tree in
#' Newick format and occurrence data in PHYLIP format.
#'
#' @inheritParams default_params_doc
#' @param path_to_phylo string specifying the path and name to write the phylogeny file to.
#' @param path_to_biogeo string specifying the path and name to write the biogeography file to.
#' @param path_to_biogeo string specifying the path and name to write the biogeography file to.
#' @export
#'
write_biogeobears_input <- function(phylod, path_to_phylo, path_to_biogeo) {
  write_newick_file(phylod, path_to_phylo)
  write_phylip_biogeo_file(phylod, path_to_biogeo)
}
