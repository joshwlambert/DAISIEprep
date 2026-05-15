# Package index

## All functions

- [`coccyzus_tree`](https://joshwlambert.github.io/DAISIEprep/reference/GalapagosTrees.md)
  [`columbiformes_tree`](https://joshwlambert.github.io/DAISIEprep/reference/GalapagosTrees.md)
  [`finches_tree`](https://joshwlambert.github.io/DAISIEprep/reference/GalapagosTrees.md)
  [`mimus_tree`](https://joshwlambert.github.io/DAISIEprep/reference/GalapagosTrees.md)
  [`myiarchus_tree`](https://joshwlambert.github.io/DAISIEprep/reference/GalapagosTrees.md)
  [`progne_tree`](https://joshwlambert.github.io/DAISIEprep/reference/GalapagosTrees.md)
  [`pyrocephalus_tree`](https://joshwlambert.github.io/DAISIEprep/reference/GalapagosTrees.md)
  [`setophaga_tree`](https://joshwlambert.github.io/DAISIEprep/reference/GalapagosTrees.md)
  : Phylogenetic trees of the Galapagos bird lineages and sister species
  on the mainland.

- [`get_clade_name()`](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`` `set_clade_name<-`() ``](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`get_status()`](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`` `set_status<-`() ``](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`get_missing_species()`](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`` `set_missing_species<-`() ``](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`get_col_time()`](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`` `set_col_time<-`() ``](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`get_col_max_age()`](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`` `set_col_max_age<-`() ``](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`get_branching_times()`](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`` `set_branching_times<-`() ``](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`get_min_age()`](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`` `set_min_age<-`() ``](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`get_species()`](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`` `set_species<-`() ``](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`get_clade_type()`](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  [`` `set_clade_type<-`() ``](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-accessors.md)
  :

  Accessor functions for the data (slots) in objects of the
  `Island_colonist` class

- [`Island_colonist-class`](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-class.md)
  :

  Defines the `island_tbl` class which is used when extracting
  information from the phylogenetic and island data to be used for
  constructing a `daisie_data_tbl`

- [`get_island_tbl()`](https://joshwlambert.github.io/DAISIEprep/reference/Island_tbl-accessors.md)
  [`` `set_island_tbl<-`() ``](https://joshwlambert.github.io/DAISIEprep/reference/Island_tbl-accessors.md)
  [`get_extracted_species()`](https://joshwlambert.github.io/DAISIEprep/reference/Island_tbl-accessors.md)
  [`` `set_extracted_species<-`() ``](https://joshwlambert.github.io/DAISIEprep/reference/Island_tbl-accessors.md)
  [`get_num_phylo_used()`](https://joshwlambert.github.io/DAISIEprep/reference/Island_tbl-accessors.md)
  [`` `set_num_phylo_used<-`() ``](https://joshwlambert.github.io/DAISIEprep/reference/Island_tbl-accessors.md)
  :

  Accessor functions for the data (slots) in objects of the `Island_tbl`
  class

- [`Island_tbl-class`](https://joshwlambert.github.io/DAISIEprep/reference/Island_tbl-class.md)
  :

  Defines the `island_tbl` class which is used when extracting
  information from the phylogenetic and island data to be used for
  constructing a `daisie_data_tbl`

- [`Multi_island_tbl-class`](https://joshwlambert.github.io/DAISIEprep/reference/Multi_island_tbl-class.md)
  :

  Defines the `Multi_island_tbl` class which is multiple `Island_tbl`s.

- [`add_asr_node_states()`](https://joshwlambert.github.io/DAISIEprep/reference/add_asr_node_states.md)
  : Fits a model of ancestral state reconstruction of island presence

- [`add_island_colonist()`](https://joshwlambert.github.io/DAISIEprep/reference/add_island_colonist.md)
  : Adds an island colonists (can be either a singleton lineage or an
  island clade) to the island community (island_tbl).

- [`add_missing_species()`](https://joshwlambert.github.io/DAISIEprep/reference/add_missing_species.md)
  :

  Adds a specified number of missing species to an existing island_tbl
  at the colonist specified by the species_to_add_to argument given. The
  species given is located within the island_tbl data and missing
  species are assigned. This is to be used after
  [`extract_island_species()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_island_species.md)
  to input missing species.

- [`add_multi_missing_species()`](https://joshwlambert.github.io/DAISIEprep/reference/add_multi_missing_species.md)
  : Calculates the number of missing species to be assigned to each
  island clade in the island_tbl object and assigns the missing species
  to them. In the case that multiple genera are in an island clade and
  each have missing species the number of missing species is summed.
  Currently the missing species are assigned to the genus that first
  matches with the missing species table, however a more biologically or
  stochastic assignment is in development.

- [`add_outgroup()`](https://joshwlambert.github.io/DAISIEprep/reference/add_outgroup.md)
  : Add an outgroup species to a given phylogeny.

- [`all_descendants_conspecific()`](https://joshwlambert.github.io/DAISIEprep/reference/all_descendants_conspecific.md)
  : Checks whether all species given in the descendants vector are the
  same species.

- [`all_endemicity_status()`](https://joshwlambert.github.io/DAISIEprep/reference/all_endemicity_status.md)
  : All possible endemicity statuses

- [`any_back_colonisation()`](https://joshwlambert.github.io/DAISIEprep/reference/any_back_colonisation.md)
  :

  Detects any cases where a non-endemic species or species not present
  on the island has likely been on the island given its ancestral state
  reconstruction indicating ancestral presence on the island and so is
  likely a back colonisation from the island to the mainland (or
  potentially different island). This function is useful if using
  extraction_method = "min" in
  [`DAISIEprep::extract_island_species()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_island_species.md)
  as it may brake up a single colonist into multiple colonists because
  of back-colonisation.

- [`any_outgroup()`](https://joshwlambert.github.io/DAISIEprep/reference/any_outgroup.md)
  : Checks whether the phylogeny has an outgroup that is not present on
  the island. This is critical when extracting data from the phylogeny
  so the stem age (colonisation time) is correct.

- [`any_polyphyly()`](https://joshwlambert.github.io/DAISIEprep/reference/any_polyphyly.md)
  : Checks whether there are any species in the phylogeny that have
  multiple tips (i.e. multiple subspecies per species) and whether any
  of those tips are paraphyletic (i.e. are their subspecies more
  distantly related to each other than to other subspecies or species).

- [`as_daisie_datatable()`](https://joshwlambert.github.io/DAISIEprep/reference/as_daisie_datatable.md)
  :

  Converts the `Island_tbl` class to a data frame in the format of a
  DAISIE data table (see DAISIE R package for details). This can then be
  input into
  [`DAISIEprep::create_daisie_data()`](https://joshwlambert.github.io/DAISIEprep/reference/create_daisie_data.md)
  function which creates the list input into the DAISIE ML models.

- [`benchmark()`](https://joshwlambert.github.io/DAISIEprep/reference/benchmark.md)
  : Performance analysis of the extract_island_species() function Uses
  system.time() for timing for reasons explained here:
  https://radfordneal.wordpress.com/2014/02/02/inaccurate-results-from-microbenchmark/
  \# nolint

- [`bind_colonist_to_tbl()`](https://joshwlambert.github.io/DAISIEprep/reference/bind_colonist_to_tbl.md)
  :

  Takes an existing instance of an `Island_tbl` class and bind the
  information from the instance of an `Island_colonist` class to it

- [`check_island_colonist()`](https://joshwlambert.github.io/DAISIEprep/reference/check_island_colonist.md)
  : Checks the validity of the Island_colonist class

- [`check_island_tbl()`](https://joshwlambert.github.io/DAISIEprep/reference/check_island_tbl.md)
  : Checks the validity of the Island_tbl class

- [`check_multi_island_tbl()`](https://joshwlambert.github.io/DAISIEprep/reference/check_multi_island_tbl.md)
  : Checks the validity of the Multi_island_tbl class

- [`check_phylo_data()`](https://joshwlambert.github.io/DAISIEprep/reference/check_phylo_data.md)
  :

  Checks whether `\linkS4class{phylo4d}` object conforms to the
  requirements of the DAISIEprep package. If the function does not
  return anything the data is ready to be used, if an error is returned
  the data requires some pre-processing before DAISIEprep can be used

- [`coccyzus_phylod`](https://joshwlambert.github.io/DAISIEprep/reference/coccyzus_phylod.md)
  : A phylogenetic tree of coccyzus species with endemicity status as
  tip states.

- [`columbiformes_phylod`](https://joshwlambert.github.io/DAISIEprep/reference/columbiformes_phylod.md)
  : A phylogenetic tree of columbiformes species with endemicity status
  as tip states.

- [`count_missing_species()`](https://joshwlambert.github.io/DAISIEprep/reference/count_missing_species.md)
  : Reads in the checklist of all species on an island, including those
  that are not in the phylogeny (represented by NA) and counts the
  number of species missing from the phylogeny each genus

- [`create_daisie_data()`](https://joshwlambert.github.io/DAISIEprep/reference/create_daisie_data.md)
  : This is a wrapper function for DAISIE::DAISIE_dataprep(). It allows
  the final DAISIE data structure to be produced from within DAISIEprep.
  For detailed documentation see the help documentation in the DAISIE
  package (?DAISIE::DAISIE_dataprep).

- [`create_endemicity_status()`](https://joshwlambert.github.io/DAISIEprep/reference/create_endemicity_status.md)
  : Creates a data frame with the endemicity status (either 'endemic',
  'nonendemic', 'not_present') of every species in the phylogeny using a
  phylogeny and a data frame of the island species and their endemicity
  (either 'endemic' or 'nonendemic') provided.

- [`create_test_phylod()`](https://joshwlambert.github.io/DAISIEprep/reference/create_test_phylod.md)
  : Creates phylod objects.

- [`default_params_doc()`](https://joshwlambert.github.io/DAISIEprep/reference/default_params_doc.md)
  : Documentation for function in the DAISIEprep package

- [`endemicity_to_sse_states()`](https://joshwlambert.github.io/DAISIEprep/reference/endemicity_to_sse_states.md)
  : Convert endemicity to SSE states

- [`extract_asr_clade()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_asr_clade.md)
  : Extracts an island clade based on the ancestral state reconstruction
  of the species presence on the island, therefore this clade can
  contain non-endemic species as well as endemic species.

- [`extract_biogeobears_ancestral_states_probs()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_biogeobears_ancestral_states_probs.md)
  : Extract ancestral state probabilities from BioGeoBEARS output

- [`extract_clade_name()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_clade_name.md)
  : Creates a name for a clade depending on whether all the species of
  the clade have the same genus name or whether the clade is composed of
  multiple genera, in which case it will create a unique clade name by
  concatinating the genus names

- [`extract_endemic_clade()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_endemic_clade.md)
  :

  Extracts the information for an endemic clade (i.e. more than one
  species on the island more closely related to each other than other
  mainland species) from a phylogeny (specifically `phylo4d` object from
  `phylobase` package) and stores it in an `Island_colonist` class

- [`extract_endemic_singleton()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_endemic_singleton.md)
  :

  Extracts the information for an endemic species from a phylogeny
  (specifically `phylo4d` object from `phylobase` package) and stores it
  in in an `Island_colonist` class

- [`extract_island_species()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_island_species.md)
  :

  Extracts the colonisation, diversification, and endemicty data from
  phylogenetic and endemicity data and stores it in an `Island_tbl`
  object

- [`extract_multi_tip_species()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_multi_tip_species.md)
  :

  Extracts the information for a species (endemic or non-endemic) which
  has multiple tips in the phylogeny (i.e. more than one sample per
  species) from a phylogeny (specifically `phylo4d` object from
  `phylobase` package) and stores it in an `Island_colonist` class

- [`extract_nonendemic()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_nonendemic.md)
  :

  Extracts the information for a non-endemic species from a phylogeny
  (specifically `phylo4d` object from `phylobase` package) and stores it
  in in an `island_colonist` class

- [`extract_species_asr()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_species_asr.md)
  :

  Extracts the colonisation, diversification, and endemicty data from
  phylogenetic and endemicity data and stores it in an `Island_tbl`
  object using the "asr" algorithm that extract island species given
  their ancestral states of either island presence or absence.

- [`extract_species_min()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_species_min.md)
  :

  Extracts the colonisation, diversification, and endemicty data from
  phylogenetic and endemicity data and stores it in an `Island_tbl`
  object using the "min" algorithm that extract island species as the
  shortest time to the present.

- [`extract_stem_age()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_stem_age.md)
  :

  Extracts the stem age from the phylogeny when the a species is known
  to belong to a genus but is not itself in the phylogeny and there are
  members of the same genus are in the phylogeny. The stem age can
  either be for the genus (or several genera) in the tree
  (`stem = "genus"`) or use an extraction algorithm to find the stem of
  when the species colonised the island (`stem = "island_presence`),
  either 'min' or 'asr' as in extract_island_species(). When
  `stem = "island_presence"` the reconstructed node states are used to
  determine the stem age.

- [`extract_stem_age_asr()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_stem_age_asr.md)
  : Extracts the stem age from the phylogeny when the a species is known
  to belong to a genus but is not itself in the phylogeny and there are
  members of the same genus are in the phylogeny using the 'asr'
  extraction method

- [`extract_stem_age_genus()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_stem_age_genus.md)
  : Extracts the stem age from the phylogeny when the a species is known
  to belong to a genus but is not itself in the phylogeny and there are
  members of the same genus are in the phylogeny

- [`extract_stem_age_min()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_stem_age_min.md)
  : Extracts the stem age from the phylogeny when the a species is known
  to belong to a genus but is not itself in the phylogeny and there are
  members of the same genus are in the phylogeny using the 'min'
  extraction method

- [`finches_phylod`](https://joshwlambert.github.io/DAISIEprep/reference/finches_phylod.md)
  : A phylogenetic tree of finches species with endemicity status as tip
  states.

- [`get_sse_tip_states()`](https://joshwlambert.github.io/DAISIEprep/reference/get_sse_tip_states.md)
  : Extract tip states from a phylod object

- [`is_back_colonisation()`](https://joshwlambert.github.io/DAISIEprep/reference/is_back_colonisation.md)
  : Checks whether species has undergone back-colonisation from

- [`is_duplicate_colonist()`](https://joshwlambert.github.io/DAISIEprep/reference/is_duplicate_colonist.md)
  :

  Determines if colonist has already been stored in `Island_tbl` class.
  This is used to stop endemic clades from being stored multiple times
  in the island table by checking if the endemicity status and branching
  times are identical.

- [`is_identical_island_tbl()`](https://joshwlambert.github.io/DAISIEprep/reference/is_identical_island_tbl.md)
  :

  Checks whether two `Island_tbl` objects are identical. If they are
  different comparisons are made to report which components of the
  `Island_tbls` are different.

- [`island_colonist()`](https://joshwlambert.github.io/DAISIEprep/reference/island_colonist.md)
  : Constructor for Island_colonist

- [`island_tbl()`](https://joshwlambert.github.io/DAISIEprep/reference/island_tbl.md)
  :

  Constructor function for `Island_tbl` class

- [`mimus_phylod`](https://joshwlambert.github.io/DAISIEprep/reference/mimus_phylod.md)
  : A phylogenetic tree of mimus species with endemicity status as tip
  states.

- [`multi_extract_island_species()`](https://joshwlambert.github.io/DAISIEprep/reference/multi_extract_island_species.md)
  :

  Extracts the colonisation, diversification, and endemicty data from
  multiple `phylod` (`phylo4d` class from `phylobase`) objects (composed
  of phylogenetic and endemicity data) and stores each in an
  `Island_tbl` object which are stored in a `Multi_island_tbl` object.

- [`multi_island_tbl()`](https://joshwlambert.github.io/DAISIEprep/reference/multi_island_tbl.md)
  :

  Constructor function for `Multi_island_tbl` class

- [`myiarchus_phylod`](https://joshwlambert.github.io/DAISIEprep/reference/myiarchus_phylod.md)
  : A phylogenetic tree of myiarchus species with endemicity status as
  tip states.

- [`plant_phylo`](https://joshwlambert.github.io/DAISIEprep/reference/plant_phylo.md)
  : A phylogenetic tree of plant species.

- [`plot_colonisation()`](https://joshwlambert.github.io/DAISIEprep/reference/plot_colonisation.md)
  : Plots a dot plot (cleveland dot plot when include_crown_age = TRUE)
  of the stem and potentially crown ages of a community of island
  colonists.

- [`plot_performance()`](https://joshwlambert.github.io/DAISIEprep/reference/plot_performance.md)
  : Plots performance results for a grouping variable (prob_on_island or
  prob_endemic).

- [`plot_phylod()`](https://joshwlambert.github.io/DAISIEprep/reference/plot_phylod.md)
  : Plots the phylogenetic tree and its associated tip and/or node data

- [`progne_phylod`](https://joshwlambert.github.io/DAISIEprep/reference/progne_phylod.md)
  : A phylogenetic tree of progne species with endemicity status as tip
  states.

- [`pyrocephalus_phylod`](https://joshwlambert.github.io/DAISIEprep/reference/pyrocephalus_phylod.md)
  : A phylogenetic tree of pyrocephalus species with endemicity status
  as tip states.

- [`rm_island_colonist()`](https://joshwlambert.github.io/DAISIEprep/reference/rm_island_colonist.md)
  :

  Removes an island colonist from an `Island_tbl` object

- [`rm_multi_missing_species()`](https://joshwlambert.github.io/DAISIEprep/reference/rm_multi_missing_species.md)
  :

  Loops through the genera that have missing species and removes the
  ones that are found in the missing genus list which have phylogenetic
  data. This is useful when wanting to know which missing species have
  not been assigned to the island_tbl using
  [`add_multi_missing_species()`](https://joshwlambert.github.io/DAISIEprep/reference/add_multi_missing_species.md).

- [`round_up()`](https://joshwlambert.github.io/DAISIEprep/reference/round_up.md)
  :

  Rounds numbers using the round up method, rather than the round to the
  nearest even number method used by the base function `round`.

- [`select_endemicity_status()`](https://joshwlambert.github.io/DAISIEprep/reference/select_endemicity_status.md)
  : Select endemicity status from ancestral states probabilities

- [`sensitivity()`](https://joshwlambert.github.io/DAISIEprep/reference/sensitivity.md)
  : Runs a sensitivity analysis to test the influences of changing the
  data on the parameter estimates for the DAISIE maximum likelihood
  inference model

- [`setophaga_phylod`](https://joshwlambert.github.io/DAISIEprep/reference/setophaga_phylod.md)
  : A phylogenetic tree of setophaga species with endemicity status as
  tip states.

- [`sse_states_to_endemicity()`](https://joshwlambert.github.io/DAISIEprep/reference/sse_states_to_endemicity.md)
  : Convert SSE states back to endemicity status

- [`translate_status()`](https://joshwlambert.github.io/DAISIEprep/reference/translate_status.md)
  : Takes a string of the various ways the island species status can be
  and returns a uniform all lower-case string of the same status to make
  handling statuses easier in other function

- [`unique_island_genera()`](https://joshwlambert.github.io/DAISIEprep/reference/unique_island_genera.md)
  : Determines the unique endemic genera that are included in the island
  clades contained within the island_tbl object and stores them as a
  list with each genus only occuring once in the first island clade it
  appears in

- [`write_biogeobears_input()`](https://joshwlambert.github.io/DAISIEprep/reference/write_biogeobears_input.md)
  : Write input files for BioGeoBEARS

- [`write_newick_file()`](https://joshwlambert.github.io/DAISIEprep/reference/write_newick_file.md)
  : Write tree input file for BioGeoBEARS

- [`write_phylip_biogeo_file()`](https://joshwlambert.github.io/DAISIEprep/reference/write_phylip_biogeo_file.md)
  : Write biogeography input file for BioGeoBEARS
