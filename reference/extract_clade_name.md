# Creates a name for a clade depending on whether all the species of the clade have the same genus name or whether the clade is composed of multiple genera, in which case it will create a unique clade name by concatinating the genus names

Creates a name for a clade depending on whether all the species of the
clade have the same genus name or whether the clade is composed of
multiple genera, in which case it will create a unique clade name by
concatinating the genus names

## Usage

``` r
extract_clade_name(clade)
```

## Arguments

- clade:

  A numeric vector which the indices of the species which are in the
  island clade.

## Value

Character
