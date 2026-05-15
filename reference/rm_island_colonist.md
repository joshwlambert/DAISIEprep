# Removes an island colonist from an `Island_tbl` object

Removes an island colonist from an `Island_tbl` object

## Usage

``` r
rm_island_colonist(island_tbl, clade_name)
```

## Arguments

- island_tbl:

  An instance of the `Island_tbl` class.

- clade_name:

  Character name of the colonising clade.

## Value

Object of `Island_tbl` class

## Examples

``` r
phylod <- create_test_phylod(test_scenario = 1)
island_tbl <- extract_island_species(
  phylod = phylod,
  extraction_method = "min"
)
island_tbl <- rm_island_colonist(
  island_tbl = island_tbl,
  clade_name = "bird_b"
)
```
