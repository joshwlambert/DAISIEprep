# Accessor functions for the data (slots) in objects of the [`Island_tbl`](https://joshwlambert.github.io/DAISIEprep/reference/Island_tbl-class.md) class

Accessor functions for the data (slots) in objects of the
[`Island_tbl`](https://joshwlambert.github.io/DAISIEprep/reference/Island_tbl-class.md)
class

## Usage

``` r
get_island_tbl(x)

# S4 method for class 'Island_tbl'
get_island_tbl(x)

set_island_tbl(x) <- value

# S4 method for class 'Island_tbl'
set_island_tbl(x) <- value

get_extracted_species(x)

# S4 method for class 'Island_tbl'
get_extracted_species(x)

set_extracted_species(x) <- value

# S4 method for class 'Island_tbl'
set_extracted_species(x) <- value

get_num_phylo_used(x)

# S4 method for class 'Island_tbl'
get_num_phylo_used(x)

set_num_phylo_used(x) <- value

# S4 method for class 'Island_tbl'
set_num_phylo_used(x) <- value
```

## Arguments

- x:

  An object whose class is determined by the signature.

- value:

  A value which can take several forms to be assigned to an object of a
  class.

## Value

Getter function (get\_*) returns a data frame, the setter function
(set\_*) returns the modified Island_tbl class.

## Author

Joshua W. Lambert

## Examples

``` r
island_tbl <- island_tbl()
get_island_tbl(island_tbl)
#> [1] clade_name      status          missing_species col_time       
#> [5] col_max_age     branching_times min_age         species        
#> [9] clade_type     
#> <0 rows> (or 0-length row.names)
set_island_tbl(island_tbl) <- data.frame(
  clade_name = "birds",
  status = "endemic",
  missing_species = 0,
  branching_times = I(list(c(1.0, 0.5)))
)
```
