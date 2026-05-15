# Runs a sensitivity analysis to test the influences of changing the data on the parameter estimates for the DAISIE maximum likelihood inference model

Runs a sensitivity analysis to test the influences of changing the data
on the parameter estimates for the DAISIE maximum likelihood inference
model

## Usage

``` r
sensitivity(
  phylo,
  island_species,
  extraction_method,
  asr_method,
  tie_preference,
  island_age,
  num_mainland_species,
  verbose = FALSE
)
```

## Arguments

- phylo:

  A phylogeny either as a `phylo` (from the `ape` package) or `phylo4`
  (from the `phylobase` package) object.

- island_species:

  Data frame with two columns. The first is a character string of the
  tip_labels with the tip names of the species on the island. The second
  column a character string of the endemicity status of the species,
  either endemic or nonendemic.

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

- island_age:

  Age of the island in appropriate units.

- num_mainland_species:

  The size of the mainland pool, i.e. the number of species that can
  potentially colonise the island.

- verbose:

  Boolean. States if intermediate results should be printed to console.
  Defaults to FALSE

## Value

Data frame of parameter estimates and the parameter setting used when
inferring them
