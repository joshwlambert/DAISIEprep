# Write tree input file for BioGeoBEARS

Write a text file containing a phylogenetic tree in the Newick format
expected by BioGeoBEARS

## Usage

``` r
write_newick_file(phylod, path_to_phylo)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- path_to_phylo:

  string specifying the path and name to write the file to.

## Value

Nothing, called for side-effects.
