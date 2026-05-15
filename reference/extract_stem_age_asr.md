# Extracts the stem age from the phylogeny when the a species is known to belong to a genus but is not itself in the phylogeny and there are members of the same genus are in the phylogeny using the 'asr' extraction method

Extracts the stem age from the phylogeny when the a species is known to
belong to a genus but is not itself in the phylogeny and there are
members of the same genus are in the phylogeny using the 'asr'
extraction method

## Usage

``` r
extract_stem_age_asr(genus_in_tree, phylod)
```

## Arguments

- genus_in_tree:

  A numeric vector that indicates which species in the genus are in the
  tree

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

## Value

Numeric
