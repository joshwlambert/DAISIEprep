# Converts the `Island_tbl` class to a data frame in the format of a DAISIE data table (see DAISIE R package for details). This can then be input into `DAISIEprep::create_daisie_data()` function which creates the list input into the DAISIE ML models.

Converts the `Island_tbl` class to a data frame in the format of a
DAISIE data table (see DAISIE R package for details). This can then be
input into
[`DAISIEprep::create_daisie_data()`](https://joshwlambert.github.io/DAISIEprep/reference/create_daisie_data.md)
function which creates the list input into the DAISIE ML models.

## Usage

``` r
as_daisie_datatable(island_tbl, island_age, precise_col_time = TRUE)
```

## Arguments

- island_tbl:

  An instance of the `Island_tbl` class.

- island_age:

  Age of the island in appropriate units.

- precise_col_time:

  Boolean, TRUE uses the precise times of colonisation, FALSE makes
  every colonist a max age colonistion and uses minimum age of
  colonisation if available.

## Value

A data frame in the format of a DAISIE data table

## Author

Joshua W. Lambert, Pedro Neves

## Examples

``` r
phylod <- create_test_phylod(10)
island_tbl <- extract_island_species(
  phylod = phylod,
  extraction_method = "asr"
)
#> Warning: Root of the phylogeny is on the island so the colonisation
#>               time from the stem age cannot be collected, colonisation time
#>               will be set to infinite.

# Example where precise colonisation times are known
daisie_datatable <- as_daisie_datatable(
  island_tbl = island_tbl,
  island_age = 0.2,
  precise_col_time = TRUE
)

# Example where colonisation times are uncertain and set to max ages
daisie_datatable <- as_daisie_datatable(
  island_tbl = island_tbl,
  island_age = 0.2,
  precise_col_time = FALSE
)
```
