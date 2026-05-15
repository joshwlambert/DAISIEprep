# Plots performance results for a grouping variable (prob_on_island or prob_endemic).

Plots performance results for a grouping variable (prob_on_island or
prob_endemic).

## Usage

``` r
plot_performance(performance_data, group_by)
```

## Arguments

- performance_data:

  Tibble of collated performance results

- group_by:

  A variable to partition by for plotting. Uses data masking so variable
  does not need to be quoted.

## Value

ggplot2 object
