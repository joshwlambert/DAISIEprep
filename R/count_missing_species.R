#' Reads in the checklist of all species on an island, including those that are
#' not in the phylogeny (represented by NA) and counts the number of species
#' missing from the phylogeny each genus
#'
#' @inheritParams default_params_doc
#'
#' @return Data frame
#' @export
#'
#' @examples
#' mammal_checklist <- read_checklist(file_name = "mammal_checklist.csv")
#' count_missing_species(checklist = mammal_checklist)
count_missing_species <- function(checklist,
                                  in_phylo_col,
                                  endemicity_status_col,
                                  rm_species_col = NULL) {

  # Naming convention is the raw data column names are underscore separated
  # title case, when the data is modified in memory (i.e. in R) data column
  # names are underscore separated lowercase

  # remove species that are tagged as needing removal from the data set
  # likely as they are introduced (alien) to the island
  if (!is.null(rm_species_col)) {
    rm_species <- which(checklist[, rm_species_col])
  }
  if (length(rm_species) > 0) {
    checklist <- checklist[-rm_species, ]
  }

  if (grepl(pattern = "dna", x = in_phylo_col, ignore.case = TRUE)) {
    # check data is boolean
    if (any(!is.logical(checklist$DNA_In_Tree))) stop("Must be boolean values")
    not_in_tree <- which(!checklist$DNA_In_Tree)
  } else {
    if (any(!is.logical(checklist$Sampled))) stop("Must be boolean values")
    not_in_tree <- which(!checklist$Sampled)
  }

  # get the genus name from the tree complete tree if sampled
  phylo_genus <- checklist[not_in_tree, "Name_In_Tree"]
  phylo_genus <- strsplit(x = phylo_genus, split = "_")
  phylo_genus <- sapply(phylo_genus, "[[", 1)

  # get the genus name from the checklist
  missing_genus <- checklist[not_in_tree, "Genus"]

  # if genus name in checklist and the tree differ use the name from tree
  genus_name <- data.frame(phylo = phylo_genus, genus = missing_genus)
  match_index <- c()
  for (i in seq_len(nrow(genus_name))) {
    if (!is.na(genus_name$phylo[i])) {
      if (!genus_name$phylo[i] == genus_name$genus[i]) {
        match_index[i] <- i
      }
    }
  }
  match_index <- na.omit(match_index)
  missing_genus[match_index] <- phylo_genus[match_index]

  # get the endemicity status for each species
  endemicity_status <- checklist[not_in_tree, endemicity_status_col]


  # standardise endemicity statuses
  endemicity_status <- Vectorize(
    FUN = DAISIEprep::translate_status,
    vectorize.args = "status"
  )(endemicity_status)
  endemicity_status <- unname(endemicity_status)

  missing_genus <- paste(missing_genus, endemicity_status, sep = "_")

  # sum the number of missing species in each genera
  missing_species <- table(missing_genus)

  missing_species <- as.data.frame(missing_species)

  missing_species$missing_genus <- as.character(missing_species$missing_genus)

  colnames(missing_species) <- c("clade_name", "missing_species")

  # make clade name and endemicity status separate columns
  split_name <- strsplit(missing_species$clade_name, split = "_")
  missing_species$clade_name <- sapply(split_name, "[[", 1)
  missing_species$endemicity_status <- sapply(split_name, "[[", 2)

  # return missing species data frame
  missing_species
}
