# Convert SSE states back to endemicity status

Convert SSE states back to endemicity status

## Usage

``` r
sse_states_to_endemicity(states, sse_model = "musse")
```

## Arguments

- states:

  integer vector of tip states, as expected by SSE models

- sse_model:

  either "musse" (default) or "geosse". MuSSE expects state values 1, 2,
  3, which here we encode as "not_present", "endemic", "nonendemic",
  respectively. GeoSSE expects trait values 0, 1, 2, with 0 the
  widespread state (here, "nonendemic"), and 1 and 2 are "not_present"
  and "endemic", respectively.

## Value

character vector with values "endemic", "nonendemic" and/or
"not_present"
