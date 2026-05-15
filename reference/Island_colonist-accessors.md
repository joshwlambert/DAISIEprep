# Accessor functions for the data (slots) in objects of the [`Island_colonist`](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-class.md) class

Accessor functions for the data (slots) in objects of the
[`Island_colonist`](https://joshwlambert.github.io/DAISIEprep/reference/Island_colonist-class.md)
class

## Usage

``` r
get_clade_name(x)

# S4 method for class 'Island_colonist'
get_clade_name(x)

set_clade_name(x) <- value

# S4 method for class 'Island_colonist'
set_clade_name(x) <- value

get_status(x)

# S4 method for class 'Island_colonist'
get_status(x)

set_status(x) <- value

# S4 method for class 'Island_colonist'
set_status(x) <- value

get_missing_species(x)

# S4 method for class 'Island_colonist'
get_missing_species(x)

set_missing_species(x) <- value

# S4 method for class 'Island_colonist'
set_missing_species(x) <- value

get_col_time(x)

# S4 method for class 'Island_colonist'
get_col_time(x)

set_col_time(x) <- value

# S4 method for class 'Island_colonist'
set_col_time(x) <- value

get_col_max_age(x)

# S4 method for class 'Island_colonist'
get_col_max_age(x)

set_col_max_age(x) <- value

# S4 method for class 'Island_colonist'
set_col_max_age(x) <- value

get_branching_times(x)

# S4 method for class 'Island_colonist'
get_branching_times(x)

set_branching_times(x) <- value

# S4 method for class 'Island_colonist'
set_branching_times(x) <- value

get_min_age(x)

# S4 method for class 'Island_colonist'
get_min_age(x)

set_min_age(x) <- value

# S4 method for class 'Island_colonist'
set_min_age(x) <- value

get_species(x)

# S4 method for class 'Island_colonist'
get_species(x)

set_species(x) <- value

# S4 method for class 'Island_colonist'
set_species(x) <- value

get_clade_type(x)

# S4 method for class 'Island_colonist'
get_clade_type(x)

set_clade_type(x) <- value

# S4 method for class 'Island_colonist'
set_clade_type(x) <- value
```

## Arguments

- x:

  An object whose class is determined by the signature.

- value:

  A value which can take several forms to be assigned to an object of a
  class.

## Value

Getter functions (get\_*) return a variable from the Island_colonist
class, the setter functions (set\_*) return the modified Island_colonist
class.

## Author

Joshua W. Lambert

## Examples

``` r
  colonist <- island_colonist()
  get_clade_name(colonist)
#> [1] NA
  set_clade_name(colonist) <- "abc"
  get_status(colonist)
#> [1] NA
  set_status(colonist) <- "abc"
  get_missing_species(colonist)
#> [1] NA
  set_missing_species(colonist) <- 0
  get_col_time(colonist)
#> [1] NA
  set_col_time(colonist) <- 1
  get_col_max_age(colonist)
#> [1] NA
  set_col_max_age(colonist) <- FALSE
  get_branching_times(colonist)
#> [1] NA
  set_branching_times(colonist) <- 0
  get_min_age(colonist)
#> [1] NA
  set_min_age(colonist) <- 0.1
  get_species(colonist)
#> [1] NA
  set_species(colonist) <- "abc_a"
  get_clade_type(colonist)
#> [1] NA
  set_clade_type(colonist) <- 1
```
