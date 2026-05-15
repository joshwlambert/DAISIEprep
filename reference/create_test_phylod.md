# Creates phylod objects.

A helper function that is useful in tests and examples to easily create
`phylod` objects (i.e. phylogenetic trees with data).

## Usage

``` r
create_test_phylod(test_scenario)
```

## Arguments

- test_scenario:

  Integer specifying which test phylod object to create.

## Value

A `phylo4d` object

## Examples

``` r
create_test_phylod(test_scenario = 1)
#>    label node ancestor edge.length node.type endemicity_status island_status
#> 1 bird_a    1        3   0.7551818       tip       not_present          <NA>
#> 2 bird_b    2        3   0.7551818       tip        nonendemic          <NA>
#> 3   <NA>    3        0          NA      root              <NA>    nonendemic
#>   nonendemic_prob not_present_prob
#> 1              NA               NA
#> 2              NA               NA
#> 3             0.5              0.5
```
