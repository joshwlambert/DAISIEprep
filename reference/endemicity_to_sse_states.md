# Convert endemicity to SSE states

Convert endemicity to SSE states

## Usage

``` r
endemicity_to_sse_states(endemicity_status, sse_model = "musse")
```

## Arguments

- endemicity_status:

  character vector with values "endemic", "nonendemic" and/or
  "not_present"

- sse_model:

  either "musse" (default) or "geosse". MuSSE expects state values 1, 2,
  3, which here we encode as "not_present", "endemic", "nonendemic",
  respectively. GeoSSE expects trait values 0, 1, 2, with 0 the
  widespread state (here, "nonendemic"), and 1 and 2 are "not_present"
  and "endemic", respectively.

## Value

an integer vector of tip states, following the encoding expected by the
MuSSE/GeoSSE
