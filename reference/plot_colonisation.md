# Plots a dot plot (cleveland dot plot when include_crown_age = TRUE) of the stem and potentially crown ages of a community of island colonists.

Plots a dot plot (cleveland dot plot when include_crown_age = TRUE) of
the stem and potentially crown ages of a community of island colonists.

## Usage

``` r
plot_colonisation(island_tbl, island_age, include_crown_age = TRUE)
```

## Arguments

- island_tbl:

  An instance of the `Island_tbl` class.

- island_age:

  Age of the island in appropriate units.

- include_crown_age:

  A boolean determining whether the crown age gets plotted with the stem
  age.

## Value

`ggplot` object

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
  c("not_present", "endemic", "nonendemic"),
  size = length(phylobase::tipLabels(phylo)),
  replace = TRUE,
  prob = c(0.6, 0.2, 0.2)
)
phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
island_tbl <- extract_island_species(phylod, extraction_method = "min")
plot_colonisation(island_tbl, island_age = 2)
```
