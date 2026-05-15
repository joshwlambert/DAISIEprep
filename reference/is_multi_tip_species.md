# Checks if a species is represented in the tree has multiple tips and those tips form a monophyletic group (i.e. one species with multiple samples) all labeled as with the same endemicity status

Checks if a species is represented in the tree has multiple tips and
those tips form a monophyletic group (i.e. one species with multiple
samples) all labeled as with the same endemicity status

## Usage

``` r
is_multi_tip_species(phylod, species_label)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- species_label:

  The tip label of the species of interest.

## Value

Boolean

## Details

`is_multi_tip_species()` only returns `TRUE` if all tips for each sample
of the species (i.e. conspecific tips) are labelled the same. It is
possible that a phylogeny has multiple tips for the same species but
only the island samples are labelled as `"endemic"` or `"nonendemic"` as
the other tips are from samples from the mainland, and are labelled
`"not_present"`, see
[`vignette("Multi_tip_extraction", package = "DAISIEprep")`](https://joshwlambert.github.io/DAISIEprep/articles/Multi_tip_extraction.md).
