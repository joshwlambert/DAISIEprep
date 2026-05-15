# Takes a string of the various ways the island species status can be and returns a uniform all lower-case string of the same status to make handling statuses easier in other function

Takes a string of the various ways the island species status can be and
returns a uniform all lower-case string of the same status to make
handling statuses easier in other function

## Usage

``` r
translate_status(status)
```

## Arguments

- status:

  Character endemicity status of the colonising clade. Either
  `"endemic"` or `"nonendemic"`.

## Value

Character string

## Examples

``` r
translate_status("Endemic")
#> [1] "endemic"
```
