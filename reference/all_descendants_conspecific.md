# Checks whether all species given in the descendants vector are the same species.

Checks whether all species given in the descendants vector are the same
species.

## Usage

``` r
all_descendants_conspecific(descendants)
```

## Arguments

- descendants:

  A vector character strings with the names of species to determine
  whether they are the same species.

## Value

Boolean

## Examples

``` r
# Example where species are not conspecific
descendants <- c("bird_a", "bird_b", "bird_c")
all_descendants_conspecific(descendants = descendants)
#> [1] FALSE

# Example where species are conspecific
descendants <- c("bird_a_1", "bird_a_2", "bird_a_3")
all_descendants_conspecific(descendants = descendants)
#> [1] TRUE
```
