# Checks whether `\linkS4class{phylo4d}` object conforms to the requirements of the DAISIEprep package. If the function does not return anything the data is ready to be used, if an error is returned the data requires some pre-processing before DAISIEprep can be used

Checks whether `\linkS4class{phylo4d}` object conforms to the
requirements of the DAISIEprep package. If the function does not return
anything the data is ready to be used, if an error is returned the data
requires some pre-processing before DAISIEprep can be used

## Usage

``` r
check_phylo_data(phylod)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

## Value

Nothing or error message

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
check_phylo_data(phylod)
```
