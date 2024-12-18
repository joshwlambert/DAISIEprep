# News

# DAISIEprep 1.0.0

### NEW FEATURES
* Package data (`/data`) added to make it easier to load data in tutorial. Some data has been moved from `inst/extdata` into `/data` (#42).
* A new `force_nonendemic_singleton` argument has been added to `extract_island_species()`. This allows enforcing non-endemic island species to be extracted as singleton lineages on the island (under most scenarios) using the `"asr"` extraction method. A new `extract_nonendemic_forced()` function is added (collaboration with @luislvalente, #45).
* A new vignette explaining the feature of forcing non-endemic species to be extracted as singletons has been added (collaboration with @luislvalente, #45).
* The DAISIEprep tutorial vignette has been improved. The explanations are more clear, with simpler data loading (@luislvalente, #42).

### MINOR IMPROVEMENTS
* Input checking added to `add_island_colonist()` (collaboration with @luislvalente, #48).
* Warn in `create_endemicity_status()` when species provided by user not found in phylogeny (collaboration with @luislvalente, #46).
* `extract_multi_tip_species()` now returns an `Island_colonist` objects with `col_max_age` set to `TRUE`. This enables DAISIE to make full use of max and min age information (#51).
* `plot_phylod()` now plots the x-axis with the time counting from right to left to correctly label years before present (collaboration with @luislvalente, #50).
* The package website now has a structured vignette dropdown menu (#49).

### BUG FIXES
* `is_multi_tip_speices()` now checks that multi-tip monophyletic species have the same endemicity status to be considered multi-tip. This fixes a bug where species in the phylogeny with multiple tips but labelled according to where they are sampled with only a single island sample extracted using the `"min"` algorithm would error (#51).

### DEPRECATED AND DEFUNCT
* None

# DAISIEprep 0.4.2

### NEW FEATURES
* None

### MINOR IMPROVEMENTS
* None

### BUG FIXES
* Fix for a bug when the ancestral state reconstruction (see 
`add_asr_node_states()`) produces _nested island colonists_ which was causing
some island species to become duplicated in the `island_tbl` previous versions.
The fix adds a new internal function to the package
`rm_duplicate_island_species()` which is called in `extract_island_species()`
when `extraction_method = asr`. This function uses the `nested_asr_species` 
argument (added to `extract_island_species()`) to determine whether duplicated
island species should be kept as smaller, more recent colonist and removed
from the larger, older clade (`nested_asr_species = "split"`), or whether the
smaller, more recent colonist should be removed and the larger, older clade
should retain the species (`nested_asr_species = "group"`). Both choices result
in duplicates being removed.

### DEPRECATED AND DEFUNCT
* None

# DAISIEprep 0.4.1

### NEW FEATURES
* None

### MINOR IMPROVEMENTS
* `...` (`dots`) have been added as an argument to `add_asr_node_states()` in
order to pass other arguments to the `castor` R package functions called for
ancestral state reconstruction (`castor::ask_mk_model()` and 
`castor::asr_max_parsimony()`).
* Tests have been added to check arguments can be passed through `...` in 
`add_asr_node_states()`.

### BUG FIXES
* None

### DEPRECATED AND DEFUNCT
* None

# DAISIEprep 0.4.0

### NEW FEATURES
* The rate model (`rate_model`) can now be selected in `add_asr_node_states()` 
and passed to `castor::asr_mk_model()`. Feature suggested by @rsetienne.

### MINOR IMPROVEMENTS
* `add_missing_species()` now errors when the species name supplied to
`species_to_add_to` is not found in the `island_tbl`. Suggested by @luislvalente.
* Function documentation for `add_island_colonist()` arguments has been improved.
Suggested by @rsetienne.
* Unit tests have been added for `add_asr_node_states()`.
* Unit test for `add_missing_species()` has been updated.
* Markdown formatting has been enabled for Roxygen documentation.

### BUG FIXES
* None

### DEPRECATED AND DEFUNCT
* None

# DAISIEprep 0.3.3

### NEW FEATURES
* None

### MINOR IMPROVEMENTS
* Addition of _corHMM_ section to Extending ASR article, contributed by @TheoPannetier.

### BUG FIXES
* Bug fix in `sse_states_to_endemicity()` (#17).

### DEPRECATED AND DEFUNCT
* None

# DAISIEprep 0.3.2

### NEW FEATURES 
* None

### MINOR IMPROVEMENTS
* Converted Extending_asr vignette to article
* Removed remote dependencies due to CRAN rules

### BUG FIXES
* None

### DEPRECATED AND DEFUNCT
* None

# DAISIEprep 0.3.1

### NEW FEATURES 
* None

### MINOR IMPROVEMENTS
* Updates to Sensitivity vignette

### BUG FIXES
* None

### DEPRECATED AND DEFUNCT
* None

# DAISIEprep 0.3.0

### NEW FEATURES 
* New vignette on performance of `extract_island_species()` 

### MINOR IMPROVEMENTS
* Updates to Extending ASR vignette and Sensitivity vignette

### BUG FIXES
* Bug fix for `benchmark()` function

### DEPRECATED AND DEFUNCT
* None

# DAISIEprep 0.2.1

### NEW FEATURES 
* None

### MINOR IMPROVEMENTS
* Higher test coverage
* `plot_phylod()` tip labels are now white space separated

### BUG FIXES
* Bug fixes for `benchmark()` function

### DEPRECATED AND DEFUNCT
* None

## DAISIEprep 0.2.0

### NEW FEATURES 
* Stable version of DAISIEprep
* New functions
* New documentation and vignettes

### MINOR IMPROVEMENTS
* Addition of several functions

### BUG FIXES
* Bug fixes for various functions

### DEPRECATED AND DEFUNCT
* None

## DAISIEprep 0.1.0

### NEW FEATURES 
* Beta version of DAISIEprep
* Ready for users

### MINOR IMPROVEMENTS
* None

### BUG FIXES
* None

### DEPRECATED AND DEFUNCT
* None
