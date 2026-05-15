# Checks whether the focal species (given by its tip lable in species_label argument) is part of an endemic clade on the island and a vector of the endemic species, either a single species for a singleton or multiple species in an endemic clade.

Checks whether the focal species (given by its tip lable in
species_label argument) is part of an endemic clade on the island and a
vector of the endemic species, either a single species for a singleton
or multiple species in an endemic clade.

## Usage

``` r
get_endemic_species(phylod, species_label)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- species_label:

  The tip label of the species of interest.

## Value

Named numeric vector
