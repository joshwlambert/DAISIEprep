# Extracts the information for a species (endemic or non-endemic) which has multiple tips in the phylogeny (i.e. more than one sample per species) from a phylogeny (specifically `phylo4d` object from `phylobase` package) and stores it in an `Island_colonist` class

Extracts the information for a species (endemic or non-endemic) which
has multiple tips in the phylogeny (i.e. more than one sample per
species) from a phylogeny (specifically `phylo4d` object from
`phylobase` package) and stores it in an `Island_colonist` class

## Usage

``` r
extract_multi_tip_species(phylod, species_label, species_endemicity)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- species_label:

  The tip label of the species of interest.

- species_endemicity:

  A character string with the endemicity, either "endemic" or
  "nonendemic" of an island species, or "not_present" if not on the
  island.

## Value

An object of `Island_colonist` class

## Examples

``` r
set.seed(
  1,
  kind = "Mersenne-Twister",
  normal.kind = "Inversion",
  sample.kind = "Rejection"
)
phylo <- ape::rcoal(10)
phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                     "bird_f", "bird_g", "bird_h_1", "bird_h_2", "bird_i")
phylo <- phylobase::phylo4(phylo)
endemicity_status <- c("not_present", "not_present", "not_present",
                       "not_present", "not_present", "not_present",
                       "not_present",  "endemic", "endemic", "not_present")
phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
extract_multi_tip_species(
  phylod = phylod,
  species_label = "bird_h_1",
  species_endemicity = "endemic"
)
#> Class:  Island_colonist 
#>   Clade name:  bird_h 
#>   Status:  endemic 
#>   Missing species:  0 
#>   Colonisation time:  0.3800341 
#>   Colonisation max age:  TRUE 
#>   Branching times:  NA 
#>   Min age:  0.04960523 
#>   Species:  bird_h_1 bird_h_2 
#>   Clade type:  1 
```
