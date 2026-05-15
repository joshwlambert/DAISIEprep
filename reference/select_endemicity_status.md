# Select endemicity status from ancestral states probabilities

Selects a state for each node (both internal nodes, i.e. ancestral
states, and tips, if included) from a table of probabilities.

## Usage

``` r
select_endemicity_status(asr_df, method = "max")
```

## Arguments

- asr_df:

  a data frame containing at least these three columns: not_present_prob
  \| endemic_prob \| nonendemic_prob (in any order). Each column should
  contain the estimated probability of the state for each node (rows)
  and these columns should sum to 1.

- method:

  "max" or "random". "max" will select the state with highest
  probability (selecting last state in event of a tie), while "random"
  will sample the states randomly with the probabilities as weight for
  each state.

## Value

a character vector, with the selected endemicity status for each node.
