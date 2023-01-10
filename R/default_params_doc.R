#' Documentation for function in the DAISIEprep package
#'
#' @param island_colonist An instance of the `Island_colonist` class.
#' @param island_tbl An instance of the `Island_tbl` class.
#' @param phylod A `phylo4d` object from the package `phylobase` containing
#' phylogenetic and endemicity data for each species.
#' @param extraction_method A character string specifying whether the
#' colonisation time extracted is the minimum time (`min`) (before the present),
#' or the most probable time under ancestral state reconstruction (`asr`).
#' @param species_label The tip label of the species of interest.
#' @param species_endemicity A character string with the endemicity, either
#' "endemic" or "nonendemic" of an island species, or "not_present" if not on
#' the island.
#' @param x An object whose class is determined by the signature.
#' @param value A value which can take several forms to be assigned to an object
#' of a class.
#' @param clade_name Character name of the colonising clade.
#' @param status Character endemicity status of the colonising clade.
#' @param missing_species Numeric number of missing species from the phylogeny
#' that belong to the colonising clade.
#' @param col_time Numeric with the colonisation time of the island colonist
#' @param col_max_age Boolean determining whether colonisation time should be
#' considered a precise time of colonisation or a maximum time of colonisation
#' @param branching_times Numeric vector of one or more elements which are the
#' branching times on the island.
#' @param min_age Numeric minimum age (time before the present) that the species
#' must have colonised the island by. This is known when there is a branching
#' on the island, either in species or subspecies.
#' @param species Character vector of one or more elements containing the name
#' of the species included in the colonising clade.
#' @param clade_type Numeric determining which type of clade the island colonist
#' is, this determines which macroevolutionary regime (parameter set) the island
#' colonist is in.
#' @param endemic_clade Named vector with all the species from a clade.
#' @param phylo A phylogeny either as a `phylo` (from the `ape` package) or
#' `phylo4` (from the `phylobase` package) object.
#' @param island_species Data frame with two columns. The first is a character
#' string of the tip_labels with the tip names of the species on the island.
#' The second column a character string of the endemicity status of the species,
#' either endemic or nonendemic.
#' @param descendants A vector character strings with the names of species to
#' determine whether they are the same species.
#' @param clade A numeric vector which the indices of the species which are
#' in the island clade.
#' @param asr_method A character string, either "parsimony" or "mk" determines
#' whether a maximum parsimony or continuous-time markov model reconstructs the
#' ancestral states at each node. See documentation in
#' `castor::asr_maximum_parsimony` or `castor::asr_mk` in `castor` R package
#' for details on the methods used.
#' @param tie_preference Character string, either "island" or "mainland" to
#' choose the most probable state at each node using the `max.col()` function.
#' When a node has island presence and absence equally probable we need to
#' decide whether that species should be considered on the island. To consider
#' it on the island use `ties.method = "last"` in the `max.col()` function, if
#' you consider it not on the island use `ties.method = "first"`. Default is
#' "island".
#' @param earliest_col A boolean to determine whether to take the colonisation
#' time as the most probable time (FALSE) or the earliest possible colonisation
#' time (TRUE), where the probability of a species being on the island is
#' non-zero. Default is FALSE.
#' @param include_not_present A boolean determining whether species not present
#' on the island should be included in island colonist when embedded within an
#' island clade. Default is FALSE.
#' @param num_missing_species Numeric for the number of missing species in the
#' clade.
#' @param species_to_add_to Character string with the name of the species to
#' identify which clade to assign missing species to.
#' @param node_pies Boolean determining if pie charts of the probabilities of
#' a species being present on the island. If TRUE the correct data is required
#' in the phylod object.
#' @param test_scenario Integer specifying which test phylod object to create.
#' @param data Either an object of class `Island_tbl` or a DAISIE data table
#' object (output from `as_daisie_datatable()`).
#' @param island_age Age of the island in appropriate units.
#' @param num_mainland_species The size of the mainland pool, i.e. the number
#' of species that can potentially colonise the island.
#' @param num_clade_types Number of clade types. Default num_clade_types = 1 all
#' species are considered to belong to the same macroevolutionary process. If
#' num_clade_types = 2, there are two types of clades with distinct
#' macroevolutionary processes.
#' @param list_type2_clades If num_clade_types = 2, list_type2_clades specifies
#' the names of the clades that have a distinct macroevolutionary process. The
#' names must match those in the "Clade_name" column of the source data table.
#' If num_clade_types = 1, then list_type2_clades = NA should be specified
#' (default).
#' @param prop_type2_pool Specifies the fraction of potential mainland colonists
#' that have a distinct macroevolutionary process. Applies only if
#' number_clade_types = 2. Default "proportional" sets the fraction to be
#' proportional to the number of clades of distinct macroevolutionary process
#' that have colonised the island. Alternatively, the user can specify a value
#' between 0 and 1 (e.g. if the mainland pool size is 1000 and prop_type2_pool
#' = 0.02 then the number of type 2 species is 20).
#' @param epss Default = 1e-5 should be appropriate in most cases. This value
#' is used to set the maximum age of colonisation of "Non_endemic_MaxAge" and
#' "Endemic_MaxAge" species to an age that is slightly younger than the island
#' for cases when the age provided for that species is older than the island.
#' The new maximum age is then used as an upper bound to integrate over all
#' possible colonisation times.
#' @param verbose Boolean. States if intermediate results should be printed to
#' console. Defaults to TRUE.
#' @param precise_col_time Boolean, TRUE uses the precise times of colonisation,
#' FALSE makes every colonist a max age colonistion and uses minimum age of
#' colonisation if available.
#' @param n A numeric to be rounded.
#' @param digits A numeric specifying which decimal places to round to
#' @param include_crown_age A boolean determining whether the crown age gets
#' plotted with the stem age.
#' @param only_tips A boolean determing whether only the tips (i.e. terminal
#' branches) are searched for back colonisation events.
#' @param node_label A numeric label for a node within a phylogeny.
#' @param multi_phylod A list of phylod objects.
#' @param island_tbl_1 An object of `Island_tbl` class to be comparedl
#' @param island_tbl_2 An object of `Island_tbl` class to be compared
#' @param unique_clade_name Boolean determining whether a unique species
#' identifier is used as the clade name in the Island_tbl object or a genus
#' name which may not be unique if that genus has several independent island
#' colonisations
#' @param genus_name Character string of genus name to be matched with a genus name from
#' the tip labels in the phylogeny
#' @param stem Character string, either "genus" or "island_presence". The former
#' will extract the stem age of the genussbased on the genus name provided, the
#' latter will extract the stem age based on the ancestral presence on the island
#' either based on the "min" or "asr" extraction algorithms.
#' @param genus_in_tree A numeric vector that indicates which species in the
#' genus are in the tree
#' @param missing_genus A list of character vectors containing the genera in
#' each island clade
#' @param checklist data frame with information on species on the island
#' @param phylo_name_col A character string specifying the column name where the
#' names in the phylogeny are in the checklist
#' @param genus_name_col A character string specifying the column name where the
#' genus names are in the checklist
#' @param in_phylo_col A character string specifying the column name where the
#' status of whether a species is in the phylogeny is in the checklist
#' @param endemicity_status_col A character string specifying the column name
#' where the endemicity status of the species are in the checklist
#' @param rm_species_col A character string specifying the column name where
#' the information on whether to remove species from the checklist before
#' counting the number of missing species is in the checklist. This can be NULL
#' if no species are to be removed from the checklist. This is useful when
#' species are in the checklist because they are on the island but need to be
#' removed as they are not in the group of interest, e.g. a migratory bird
#' amongst terrestrial birds
#' @param tree_size_range Numeric vector of two elements, the first is the
#' smallest tree size (number of tips) and the second is the largest tree size
#' @param num_points Numeric determining how many points in the sequence of
#' smallest tree size to largest tree size
#' @param prob_on_island Numeric vector of each probability on island to use in
#' the parameter space
#' @param prob_endemic Numeric vector of each probability of an island species
#' being endemic to use in the parameter space
#' @param replicates Numeric determining the number of replicates to use to
#' account for the stochasticity in sampling the species on the island and
#' endemic species
#' @param log_scale A boolean determining whether the sequence of tree sizes
#' are on a linear (FALSE) or log (TRUE) scale
#' @param parameter_index Numeric determining which parameter set to use (i.e
#' which row in the parameter space data frame), if this is NULL all parameter
#' sets will be looped over
#' @param sse_model either "musse" (default) or "geosse". MuSSE expects state
#' values 1, 2, 3, which here we encode as "not_present", "endemic",
#' "nonendemic", respectively. GeoSSE expects trait values 0, 1, 2, with 0 the
#' widespread state (here, "nonendemic"), and 1 and 2 are "not_present" and
#' "endemic", respectively.
#'
#' @return Nothing
#' @author Joshua W. Lambert
default_params_doc <- function(island_colonist,
                               island_tbl,
                               phylod,
                               extraction_method,
                               species_label,
                               species_endemicity,
                               x,
                               value,
                               clade_name,
                               status,
                               missing_species,
                               col_time,
                               col_max_age,
                               branching_times,
                               min_age,
                               species,
                               clade_type,
                               endemic_clade,
                               phylo,
                               island_species,
                               descendants,
                               clade,
                               asr_method,
                               tie_preference,
                               earliest_col,
                               include_not_present,
                               num_missing_species,
                               species_to_add_to,
                               node_pies,
                               test_scenario,
                               data,
                               island_age,
                               num_mainland_species,
                               num_clade_types,
                               list_type2_clades,
                               prop_type2_pool,
                               epss,
                               verbose,
                               precise_col_time,
                               n,
                               digits,
                               include_crown_age,
                               only_tips,
                               node_label,
                               multi_phylod,
                               island_tbl_1,
                               island_tbl_2,
                               unique_clade_name,
                               genus_name,
                               stem,
                               genus_in_tree,
                               missing_genus,
                               checklist,
                               phylo_name_col,
                               genus_name_col,
                               in_phylo_col,
                               endemicity_status_col,
                               rm_species_col,
                               tree_size_range,
                               num_points,
                               prob_on_island,
                               prob_endemic,
                               replicates,
                               log_scale,
                               parameter_index,
                               sse_model
                               ) {
  # nothing
}
