# News

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
