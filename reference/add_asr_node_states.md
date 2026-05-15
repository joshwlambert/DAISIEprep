# Fits a model of ancestral state reconstruction of island presence

Fits a model of ancestral state reconstruction of island presence

## Usage

``` r
add_asr_node_states(
  phylod,
  asr_method,
  tie_preference = "island",
  earliest_col = FALSE,
  rate_model = NULL,
  ...
)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

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

- earliest_col:

  A boolean to determine whether to take the colonisation time as the
  most probable time (FALSE) or the earliest possible colonisation time
  (TRUE), where the probability of a species being on the island is
  non-zero. Default is FALSE.

- rate_model:

  Rate model to be used for fitting the transition rate matrix. Can be
  "ER" (all rates equal), "SYM" (transition rate i–\>j is equal to
  transition rate j–\>i), "ARD" (all rates can be different), "SUEDE"
  (only stepwise transitions i–\>i+1 and i–\>i-1 allowed, all 'up'
  transitions are equal, all 'down' transitions are equal) or "SRD"
  (only stepwise transitions i–\>i+1 and i–\>i-1 allowed, and each rate
  can be different). Can also be an index matrix that maps entries of
  the transition matrix to the corresponding independent rate parameter
  to be fitted. Diagonal entries should map to 0, since diagonal entries
  are not treated as independent rate parameters but are calculated from
  the remaining entries in the transition matrix. All other entries that
  map to 0 represent a transition rate of zero. The format of this index
  matrix is similar to the format used by the `ace` function in the
  `ape` package. `rate_model` is only relevant if
  `transition_matrix==NULL`.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Allows arguments to be passed
  to
  [`castor::asr_mk_model()`](https://rdrr.io/pkg/castor/man/asr_mk_model.html)
  and
  [`castor::asr_max_parsimony()`](https://rdrr.io/pkg/castor/man/asr_max_parsimony.html).
  These arguments must match by name exactly, see
  `?castor::asr_mk_model()` and `?castor::asr_max_parsimony()` for
  information on arguments.

## Value

An object of `phylo4d` class with tip and node data

## Details

The `rate_model` argument documentation is inherited from
[`castor::asr_mk_model()`](https://rdrr.io/pkg/castor/man/asr_mk_model.html),
therefore, the last sentence about the `transition_matrix` argument does
not apply to `add_asr_node_states()`.
