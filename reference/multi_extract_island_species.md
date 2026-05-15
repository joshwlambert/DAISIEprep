# Extracts the colonisation, diversification, and endemicty data from multiple `phylod` (`phylo4d` class from `phylobase`) objects (composed of phylogenetic and endemicity data) and stores each in an `Island_tbl` object which are stored in a `Multi_island_tbl` object.

Extracts the colonisation, diversification, and endemicty data from
multiple `phylod` (`phylo4d` class from `phylobase`) objects (composed
of phylogenetic and endemicity data) and stores each in an `Island_tbl`
object which are stored in a `Multi_island_tbl` object.

## Usage

``` r
multi_extract_island_species(
  multi_phylod,
  extraction_method,
  island_tbl = NULL,
  include_not_present = FALSE,
  verbose = FALSE,
  unique_clade_name = TRUE
)
```

## Arguments

- multi_phylod:

  A list of phylod objects.

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

- verbose:

  Boolean. States if intermediate results should be printed to console.
  Defaults to FALSE

- unique_clade_name:

  Boolean determining whether a unique species identifier is used as the
  clade name in the Island_tbl object or a genus name which may not be
  unique if that genus has several independent island colonisations

## Value

An object of `Multi_island_tbl` class

## Examples

``` r
multi_phylod <- list()
multi_phylod[[1]] <- create_test_phylod(test_scenario = 1)
multi_phylod[[2]] <- create_test_phylod(test_scenario = 2)
multi_island_tbl <- multi_extract_island_species(
  multi_phylod = multi_phylod,
  extraction_method = "min",
  island_tbl = NULL,
  include_not_present = FALSE
)
```
