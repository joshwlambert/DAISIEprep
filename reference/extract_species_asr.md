# Extracts the colonisation, diversification, and endemicty data from phylogenetic and endemicity data and stores it in an `Island_tbl` object using the "asr" algorithm that extract island species given their ancestral states of either island presence or absence.

Extracts the colonisation, diversification, and endemicty data from
phylogenetic and endemicity data and stores it in an `Island_tbl` object
using the "asr" algorithm that extract island species given their
ancestral states of either island presence or absence.

## Usage

``` r
extract_species_asr(
  phylod,
  species_label,
  species_endemicity,
  island_tbl,
  include_not_present
)
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

- island_tbl:

  An instance of the `Island_tbl` class.

- include_not_present:

  A boolean determining whether species not present on the island should
  be included in island colonist when embedded within an island clade.
  Default is FALSE.

## Value

An object of `island_tbl` class

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
                            replace = TRUE, prob = c(0.8, 0.1, 0.1))
phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
phylod <- add_asr_node_states(
  phylod = phylod,
  asr_method = "parsimony"
)
island_tbl <- island_tbl()
extract_species_asr(
  phylod = phylod,
  species_label = "bird_i",
  species_endemicity = "endemic",
  island_tbl = island_tbl,
  include_not_present = FALSE
)
#> Class:  Island_tbl 
#>   clade_name  status missing_species   col_time col_max_age branching_times
#> 1     bird_i endemic               0 0.04960523       FALSE              NA
#>   min_age species clade_type
#> 1      NA  bird_i          1
```
