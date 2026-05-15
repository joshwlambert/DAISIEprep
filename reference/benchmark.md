# Performance analysis of the extract_island_species() function Uses system.time() for timing for reasons explained here: https://radfordneal.wordpress.com/2014/02/02/inaccurate-results-from-microbenchmark/ \# nolint

Performance analysis of the extract_island_species() function Uses
system.time() for timing for reasons explained here:
https://radfordneal.wordpress.com/2014/02/02/inaccurate-results-from-microbenchmark/
\# nolint

## Usage

``` r
benchmark(
  phylod,
  tree_size_range,
  num_points,
  prob_on_island,
  prob_endemic,
  replicates,
  extraction_method,
  asr_method,
  tie_preference,
  log_scale = TRUE,
  parameter_index = NULL,
  verbose = FALSE
)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- tree_size_range:

  Numeric vector of two elements, the first is the smallest tree size
  (number of tips) and the second is the largest tree size

- num_points:

  Numeric determining how many points in the sequence of smallest tree
  size to largest tree size

- prob_on_island:

  Numeric vector of each probability on island to use in the parameter
  space

- prob_endemic:

  Numeric vector of each probability of an island species being endemic
  to use in the parameter space

- replicates:

  Numeric determining the number of replicates to use to account for the
  stochasticity in sampling the species on the island and endemic
  species

- extraction_method:

  A character string specifying whether the colonisation time extracted
  is the minimum time (`min`) (before the present), or the most probable
  time under ancestral state reconstruction (`asr`).

- asr_method:

  A character string, either "parsimony" or "mk" determines whether a
  maximum parsimony or continuous-time markov model reconstructs the
  ancestral states at each node. See documentation in
  [`castor::asr_max_parsimony()`](https://rdrr.io/pkg/castor/man/asr_max_parsimony.html)
  or
  [`castor::asr_mk_model()`](https://rdrr.io/pkg/castor/man/asr_mk_model.html)
  in `castor` R package for details on the methods used.

- tie_preference:

  Character string, either "island" or "mainland" to choose the most
  probable state at each node using the
  [`max.col()`](https://rdrr.io/r/base/maxCol.html) function. When a
  node has island presence and absence equally probable we need to
  decide whether that species should be considered on the island. To
  consider it on the island use `ties.method = "last"` in the
  [`max.col()`](https://rdrr.io/r/base/maxCol.html) function, if you
  consider it not on the island use `ties.method = "first"`. Default is
  "island".

- log_scale:

  A boolean determining whether the sequence of tree sizes are on a
  linear (FALSE) or log (TRUE) scale

- parameter_index:

  Numeric determining which parameter set to use (i.e which row in the
  parameter space data frame), if this is NULL all parameter sets will
  be looped over

- verbose:

  Boolean. States if intermediate results should be printed to console.
  Defaults to FALSE

## Value

Data frame
