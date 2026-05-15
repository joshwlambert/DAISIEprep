# Loops through the genera that have missing species and removes the ones that are found in the missing genus list which have phylogenetic data. This is useful when wanting to know which missing species have not been assigned to the island_tbl using `add_multi_missing_species()`.

Loops through the genera that have missing species and removes the ones
that are found in the missing genus list which have phylogenetic data.
This is useful when wanting to know which missing species have not been
assigned to the island_tbl using
[`add_multi_missing_species()`](https://joshwlambert.github.io/DAISIEprep/reference/add_multi_missing_species.md).

## Usage

``` r
rm_multi_missing_species(missing_species, missing_genus, island_tbl)
```

## Arguments

- missing_species:

  Numeric number of missing species from the phylogeny that belong to
  the colonising clade. For a clade with missing species this is \\n -
  1\\, where \\n\\ is the number of missing species in the clade. If the
  clade is an island singleton, the number of missing species is `0`
  because by adding the colonist it already counts as one automatically.
  If the clade has more than one species, the `missing_species` is \\n -
  1\\ because adding the lineage already counts as one.

- missing_genus:

  A list of character vectors containing the genera in each island clade

- island_tbl:

  An instance of the `Island_tbl` class.

## Value

Data frame

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
missing_species <- data.frame(
  clade_name = "bird",
  missing_species = 1,
  endemicity_status = "endemic"
)
missing_genus <- list("bird", character(0))
rm_missing_species <- rm_multi_missing_species(
  missing_species = missing_species,
  missing_genus = missing_genus,
  island_tbl = island_tbl
)
```
