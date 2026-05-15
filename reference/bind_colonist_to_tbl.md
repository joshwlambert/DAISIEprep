# Takes an existing instance of an `Island_tbl` class and bind the information from the instance of an `Island_colonist` class to it

Takes an existing instance of an `Island_tbl` class and bind the
information from the instance of an `Island_colonist` class to it

## Usage

``` r
bind_colonist_to_tbl(island_colonist, island_tbl)
```

## Arguments

- island_colonist:

  An instance of the `Island_colonist` class.

- island_tbl:

  An instance of the `Island_tbl` class.

## Value

An object of `Island_tbl` class

## Examples

``` r
island_colonist <- DAISIEprep::island_colonist(
  clade_name = "bird",
  status = "endemic",
  missing_species = 0,
  col_time = 1,
  col_max_age = FALSE,
  branching_times = 0.5,
  species = "bird_a",
  clade_type = 1
)
island_tbl <- island_tbl()
bind_colonist_to_tbl(
  island_colonist = island_colonist,
  island_tbl = island_tbl
)
#> Class:  Island_tbl 
#>   clade_name  status missing_species col_time col_max_age branching_times
#> 1       bird endemic               0        1       FALSE             0.5
#>   min_age species clade_type
#> 1      NA  bird_a          1
```
