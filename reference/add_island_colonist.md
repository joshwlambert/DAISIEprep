# Adds an island colonists (can be either a singleton lineage or an island clade) to the island community (island_tbl).

Adds an island colonists (can be either a singleton lineage or an island
clade) to the island community (island_tbl).

## Usage

``` r
add_island_colonist(
  island_tbl,
  clade_name,
  status,
  missing_species,
  col_time,
  col_max_age,
  branching_times,
  min_age,
  species,
  clade_type
)
```

## Arguments

- island_tbl:

  An instance of the `Island_tbl` class.

- clade_name:

  Character name of the colonising clade.

- status:

  Character endemicity status of the colonising clade. Either
  `"endemic"` or `"nonendemic"`.

- missing_species:

  Numeric number of missing species from the phylogeny that belong to
  the colonising clade. For a clade with missing species this is \\n -
  1\\, where \\n\\ is the number of missing species in the clade. If the
  clade is an island singleton, the number of missing species is `0`
  because by adding the colonist it already counts as one automatically.
  If the clade has more than one species, the `missing_species` is \\n -
  1\\ because adding the lineage already counts as one.

- col_time:

  Numeric with the colonisation time of the island colonist

- col_max_age:

  Boolean determining whether colonisation time should be considered a
  precise time of colonisation or a maximum time of colonisation

- branching_times:

  Numeric vector of one or more elements which are the branching times
  on the island.

- min_age:

  Numeric minimum age (time before the present) that the species must
  have colonised the island by. This is known when there is a branching
  on the island, either in species or subspecies.

- species:

  Character vector of one or more elements containing the name of the
  species included in the colonising clade.

- clade_type:

  Numeric determining which type of clade the island colonist is, this
  determines which macroevolutionary regime (parameter set) the island
  colonist is in. After formatting the `island_tbl` to a DAISIE data
  list, the clade type can be used to conduct a 2-type analysis (see
  <https://CRAN.R-project.org/package=DAISIE/vignettes/demo_optimize.html>
  for more information)

## Value

An object of `Island_tbl` class

## Examples

``` r
# create an empty island_tbl to add to
island_tbl <- island_tbl()

# add a new island colonist
island_tbl <- add_island_colonist(
  island_tbl,
  clade_name = "new_clade",
  status = "endemic",
  missing_species = 0,
  col_time = 1,
  col_max_age = FALSE,
  branching_times = NA,
  min_age = NA,
  species = "new_clade",
  clade_type = 1
)
```
