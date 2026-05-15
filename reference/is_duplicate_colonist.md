# Determines if colonist has already been stored in `Island_tbl` class. This is used to stop endemic clades from being stored multiple times in the island table by checking if the endemicity status and branching times are identical.

Determines if colonist has already been stored in `Island_tbl` class.
This is used to stop endemic clades from being stored multiple times in
the island table by checking if the endemicity status and branching
times are identical.

## Usage

``` r
is_duplicate_colonist(island_colonist, island_tbl)
```

## Arguments

- island_colonist:

  An instance of the `Island_colonist` class.

- island_tbl:

  An instance of the `Island_tbl` class.

## Value

Boolean

## Examples

``` r
# with empty island_tbl
island_colonist <- island_colonist(
  clade_name = "bird",
  status = "endemic",
  missing_species = 0,
  col_time = 1.0,
  col_max_age = FALSE,
  branching_times = 0.5,
  species = "bird_a",
  clade_type = 1
)
island_tbl <- island_tbl()
is_duplicate_colonist(
  island_colonist = island_colonist,
  island_tbl = island_tbl
)
#> [1] FALSE

# with non-empty island_tbl
island_colonist <- island_colonist(
  clade_name = "bird",
  status = "endemic",
  missing_species = 0,
  col_time = 1.0,
  col_max_age = FALSE,
  branching_times = 0.5,
  species = c("bird_a", "bird_b"),
  clade_type = 1
)
island_tbl <- island_tbl()
island_tbl <- bind_colonist_to_tbl(
  island_colonist = island_colonist,
  island_tbl = island_tbl
)
island_colonist <- island_colonist(
  clade_name = "bird",
  status = "endemic",
  missing_species = 0,
  col_time = 1.0,
  col_max_age = FALSE,
  branching_times = 0.5,
  species = c("bird_a", "bird_b"),
  clade_type = 1
)
is_duplicate_colonist(
  island_colonist = island_colonist,
  island_tbl = island_tbl
)
#> [1] TRUE
```
