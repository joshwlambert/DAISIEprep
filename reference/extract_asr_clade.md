# Extracts an island clade based on the ancestral state reconstruction of the species presence on the island, therefore this clade can contain non-endemic species as well as endemic species.

Extracts an island clade based on the ancestral state reconstruction of
the species presence on the island, therefore this clade can contain
non-endemic species as well as endemic species.

## Usage

``` r
extract_asr_clade(phylod, species_label, clade, include_not_present)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- species_label:

  The tip label of the species of interest.

- clade:

  A numeric vector which the indices of the species which are in the
  island clade.

- include_not_present:

  A boolean determining whether species not present on the island should
  be included in island colonist when embedded within an island clade.
  Default is FALSE.

## Value

An object of `Island_colonist` class
