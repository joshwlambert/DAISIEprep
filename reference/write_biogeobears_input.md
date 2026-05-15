# Write input files for BioGeoBEARS

Write input files for a BioGeoBEARS analysis, i.e. a phlyogenetic tree
in Newick format and occurrence data in PHYLIP format.

## Usage

``` r
write_biogeobears_input(phylod, path_to_phylo, path_to_biogeo)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- path_to_phylo:

  string specifying the path and name to write the phylogeny file to.

- path_to_biogeo:

  string specifying the path and name to write the biogeography file to.

## Value

Nothing, called for side-effects
