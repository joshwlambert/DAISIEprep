# Extract ancestral state probabilities from BioGeoBEARS output

Extract the probabilities of each endemicity status for tip and internal
node states from the output of an optimisation performed with
BioGeoBEARS

## Usage

``` r
extract_biogeobears_ancestral_states_probs(biogeobears_res)
```

## Arguments

- biogeobears_res:

  a list, the output of `BioGeoBEARS::bears_optim_run()`

## Value

a data.frame with one row per node (tips and internals) and four
columns: label \| not_present \| endemic \| nonendemic, the last three
columns containing the probability of each endemicity status (and
summing to 1).
