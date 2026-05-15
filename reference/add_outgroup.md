# Add an outgroup species to a given phylogeny.

Add an outgroup species to a given phylogeny.

## Usage

``` r
add_outgroup(phylo)
```

## Arguments

- phylo:

  A phylogeny either as a `phylo` (from the `ape` package) or `phylo4`
  (from the `phylobase` package) object.

## Value

A `phylo` object

## Examples

``` r
phylo <- ape::rcoal(10)
phylo_with_outgroup <- add_outgroup(phylo)
```
