# Extract non-endemic colonist that is forced to be a singleton by user

Extract non-endemic colonist that is forced to be a singleton by user

## Usage

``` r
extract_nonendemic_forced(phylod, species_label, island_tbl)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- species_label:

  The tip label of the species of interest.

- island_tbl:

  An instance of the `Island_tbl` class.

## Value

An object of `phylo4d` class with tip and node data
