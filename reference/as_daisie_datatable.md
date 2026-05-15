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

## Details

When the colonisation time of an island colonist is older than
`island_age` (either because `col_max_age = TRUE` in the `island_tbl`,
because `precise_col_time = FALSE`, or because the extracted
colonisation time itself exceeds `island_age`), the colonist's status is
appended with `_MaxAge`. This tells the downstream
[`create_daisie_data()`](https://joshwlambert.github.io/DAISIEprep/reference/create_daisie_data.md)
step to treat the colonisation time as an upper bound and integrate over
possible colonisation times between the island age and the present.

If the island colonist additionally contains one or more in-island
branching times that are also older than `island_age`, those branching
events cannot represent on-island cladogenesis (the island did not yet
exist). In that case the clade is *split*:

- each branching time older than `island_age` is written as its own
  `_MaxAge` singleton row, with the clade name suffixed `_1`, `_2`, ...;
  and

- the colonisation time together with any remaining (valid, in-island)
  branching times stays as the main `_MaxAge` row under the original
  clade name.

If all branching times exceed `island_age`, the main row contains only
the colonisation time. The numeric values written to `Branching_times`
are not clamped to `island_age` at this stage; clamping (to
`island_age - epss`) happens in
[`create_daisie_data()`](https://joshwlambert.github.io/DAISIEprep/reference/create_daisie_data.md),
which treats the `_MaxAge` flag as an instruction to integrate up to the
island age.

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
