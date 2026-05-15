# Determines the unique endemic genera that are included in the island clades contained within the island_tbl object and stores them as a list with each genus only occuring once in the first island clade it appears in

Determines the unique endemic genera that are included in the island
clades contained within the island_tbl object and stores them as a list
with each genus only occuring once in the first island clade it appears
in

## Usage

``` r
unique_island_genera(island_tbl)
```

## Arguments

- island_tbl:

  An instance of the `Island_tbl` class.

## Value

list of character vectors

## Examples

``` r
phylod <- create_test_phylod(test_scenario = 6)
island_tbl <- suppressWarnings(extract_island_species(
  phylod = phylod,
  extraction_method = "asr",
))
phylod <- create_test_phylod(test_scenario = 7)
island_tbl <- suppressWarnings(extract_island_species(
  phylod = phylod,
  extraction_method = "asr",
  island_tbl = island_tbl
))
unique_genera <- unique_island_genera(island_tbl = island_tbl)
```
