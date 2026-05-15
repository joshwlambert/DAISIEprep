# Extracts the information for an endemic species from a phylogeny (specifically `phylo4d` object from `phylobase` package) and stores it in in an `Island_colonist` class

Extracts the information for an endemic species from a phylogeny
(specifically `phylo4d` object from `phylobase` package) and stores it
in in an `Island_colonist` class

## Usage

``` r
extract_endemic_singleton(phylod, species_label)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- species_label:

  The tip label of the species of interest.

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
                     "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
phylo <- phylobase::phylo4(phylo)
endemicity_status <- sample(
  x = c("not_present", "endemic", "nonendemic"),
  size = length(phylobase::tipLabels(phylo)),
  replace = TRUE,
  prob = c(0.6, 0.2, 0.2)
)
phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
extract_endemic_singleton(phylod = phylod, species_label = "bird_i")
#> Class:  Island_colonist 
#>   Clade name:  bird_i 
#>   Status:  endemic 
#>   Missing species:  0 
#>   Colonisation time:  0.04960523 
#>   Colonisation max age:  FALSE 
#>   Branching times:  NA 
#>   Min age:  NA 
#>   Species:  bird_i 
#>   Clade type:  1 
```
