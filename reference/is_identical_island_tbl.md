# Checks whether two `Island_tbl` objects are identical. If they are different comparisons are made to report which components of the `Island_tbls` are different.

Checks whether two `Island_tbl` objects are identical. If they are
different comparisons are made to report which components of the
`Island_tbls` are different.

## Usage

``` r
is_identical_island_tbl(island_tbl_1, island_tbl_2)
```

## Arguments

- island_tbl_1:

  An object of `Island_tbl` class to be comparedl

- island_tbl_2:

  An object of `Island_tbl` class to be compared

## Value

Either TRUE or a character string with the differences

## Examples

``` r
multi_island_tbl <- multi_extract_island_species(
  multi_phylod = list(
    create_test_phylod(test_scenario = 1),
    create_test_phylod(test_scenario = 1)),
 extraction_method = "min")
is_identical_island_tbl(multi_island_tbl[[1]], multi_island_tbl[[2]])
#> [1] TRUE
```
