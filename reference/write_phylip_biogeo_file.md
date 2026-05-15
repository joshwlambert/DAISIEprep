# Write biogeography input file for BioGeoBEARS

Write a text file containing occurrence data for all tips in the PHYLIP
format expected by BioGeoBEARS

## Usage

``` r
write_phylip_biogeo_file(phylod, path_to_biogeo)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- path_to_biogeo:

  string specifying the path and name to write the file to.

## Value

Nothing, called for side-effects.
