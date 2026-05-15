# Checks whether there are any species in the phylogeny that have multiple tips (i.e. multiple subspecies per species) and whether any of those tips are paraphyletic (i.e. are their subspecies more distantly related to each other than to other subspecies or species).

Checks whether there are any species in the phylogeny that have multiple
tips (i.e. multiple subspecies per species) and whether any of those
tips are paraphyletic (i.e. are their subspecies more distantly related
to each other than to other subspecies or species).

## Usage

``` r
any_polyphyly(phylod)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

## Value

Boolean

## Examples

``` r
phylod <- create_test_phylod(test_scenario = 1)
any_polyphyly(phylod)
#> [1] FALSE
```
