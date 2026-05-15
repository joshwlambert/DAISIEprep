# Checks whether the phylogeny has an outgroup that is not present on the island. This is critical when extracting data from the phylogeny so the stem age (colonisation time) is correct.

Checks whether the phylogeny has an outgroup that is not present on the
island. This is critical when extracting data from the phylogeny so the
stem age (colonisation time) is correct.

## Usage

``` r
any_outgroup(phylod)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

## Value

Boolean

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
endemicity_status <- sample(c("not_present", "endemic", "nonendemic"),
                            size = length(phylobase::tipLabels(phylo)),
                            replace = TRUE)
phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
any_outgroup(phylod)
#> [1] FALSE
```
