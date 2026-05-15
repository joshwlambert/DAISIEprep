# Extract tip states from a phylod object

Extract tip states from a phylod object

## Usage

``` r
get_sse_tip_states(phylod, sse_model = "musse")
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- sse_model:

  either "musse" (default) or "geosse". MuSSE expects state values 1, 2,
  3, which here we encode as "not_present", "endemic", "nonendemic",
  respectively. GeoSSE expects trait values 0, 1, 2, with 0 the
  widespread state (here, "nonendemic"), and 1 and 2 are "not_present"
  and "endemic", respectively.

## Value

an integer vector of tip states, as expected by SSE models
