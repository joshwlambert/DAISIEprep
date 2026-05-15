# Extracts the colonisation, diversification, and endemicty data from phylogenetic and endemicity data and stores it in an `Island_tbl` object

Extracts the colonisation, diversification, and endemicty data from
phylogenetic and endemicity data and stores it in an `Island_tbl` object

## Usage

``` r
extract_island_species(
  phylod,
  extraction_method,
  island_tbl = NULL,
  include_not_present = FALSE,
  nested_asr_species = c("split", "group"),
  force_nonendemic_singleton = FALSE,
  unique_clade_name = TRUE
)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- extraction_method:

  A character string specifying whether the colonisation time extracted
  is the minimum time (`min`) (before the present), or the most probable
  time under ancestral state reconstruction (`asr`).

- island_tbl:

  An instance of the `Island_tbl` class.

- include_not_present:

  A boolean determining whether species not present on the island should
  be included in island colonist when embedded within an island clade.
  Default is FALSE.

- nested_asr_species:

  A `character` string which determines whether *nested island
  colonists* are split into separate colonists (`"split"`), or grouped
  into a single clade (`"group"`). Nested species are those whose tip
  state is on the island, and they have ancestral nodes on the island,
  but there are nodes in between these island state nodes that have the
  state `not_present` (i.e. not on the island). Therefore, the
  colonisation time can be extracted as the most recent node state on
  the island (this can be the branching time before the tip if the
  ancestor node of the tip is not on the island), or the older node
  state of the larger clade, for `"split"` or `"group"` respectively.
  **Note** This argument only applies when `extraction_method = "asr"`.

- force_nonendemic_singleton:

  A boolean that determines whether all species that are classified as
  `"nonendemic"` are forced to be extracted as singletons (i.e single
  species lineages). By default it is `FALSE` so non-endemics can be
  extracted either as singletons or part of an endemic clade. When set
  to `TRUE` all non-endemic species in the tree will be single species
  colonists, with the colonisation time extracted as the stem age for
  the tip in the phylogeny. There are some exceptions to this, please
  see
  [`vignette("Forcing_nonendemic_singleton", package = "DAISIEprep")`](https://joshwlambert.github.io/DAISIEprep/articles/Forcing_nonendemic_singleton.md)
  for more details.

  This argument is only active when `extraction_method = "asr"`, when
  `extraction_method = "min"` this argument will be ignored with a
  warning, as the `min` method always extracts non-endemic species as
  singletons.

- unique_clade_name:

  Boolean determining whether a unique species identifier is used as the
  clade name in the Island_tbl object or a genus name which may not be
  unique if that genus has several independent island colonisations

## Value

An object of `Island_tbl` class

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
extract_island_species(phylod, extraction_method = "min")
#> Class:  Island_tbl 
#>   clade_name     status missing_species   col_time col_max_age branching_times
#> 1     bird_g nonendemic               0 0.38003405       FALSE              NA
#> 2     bird_i    endemic               0 0.04960523       FALSE              NA
#>   min_age species clade_type
#> 1      NA  bird_g          1
#> 2      NA  bird_i          1
```
