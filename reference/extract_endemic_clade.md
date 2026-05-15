# Extracts the information for an endemic clade (i.e. more than one species on the island more closely related to each other than other mainland species) from a phylogeny (specifically `phylo4d` object from `phylobase` package) and stores it in an `Island_colonist` class

Extracts the information for an endemic clade (i.e. more than one
species on the island more closely related to each other than other
mainland species) from a phylogeny (specifically `phylo4d` object from
`phylobase` package) and stores it in an `Island_colonist` class

## Usage

``` r
extract_endemic_clade(phylod, species_label, unique_clade_name)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- species_label:

  The tip label of the species of interest.

- unique_clade_name:

  Boolean determining whether a unique species identifier is used as the
  clade name in the Island_tbl object or a genus name which may not be
  unique if that genus has several independent island colonisations

## Value

An object of `Island_colonist` class

## Examples

``` r
set.seed(
  3,
  kind = "Mersenne-Twister",
  normal.kind = "Inversion",
  sample.kind = "Rejection"
)
phylo <- ape::rcoal(10)
phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                     "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
phylo <- methods::as(phylo, "phylo4")
endemicity_status <- sample(
  x = c("not_present", "endemic", "nonendemic"),
  size = length(phylobase::tipLabels(phylo)),
  replace = TRUE,
  prob = c(0.7, 0.3, 0)
)
phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
island_colonist <- extract_endemic_clade(
  phylod = phylod,
  species_label = "bird_i",
  unique_clade_name = TRUE
)
```
