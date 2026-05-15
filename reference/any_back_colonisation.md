# Detects any cases where a non-endemic species or species not present on the island has likely been on the island given its ancestral state reconstruction indicating ancestral presence on the island and so is likely a back colonisation from the island to the mainland (or potentially different island). This function is useful if using extraction_method = "min" in `DAISIEprep::extract_island_species()` as it may brake up a single colonist into multiple colonists because of back-colonisation.

Detects any cases where a non-endemic species or species not present on
the island has likely been on the island given its ancestral state
reconstruction indicating ancestral presence on the island and so is
likely a back colonisation from the island to the mainland (or
potentially different island). This function is useful if using
extraction_method = "min" in
[`DAISIEprep::extract_island_species()`](https://joshwlambert.github.io/DAISIEprep/reference/extract_island_species.md)
as it may brake up a single colonist into multiple colonists because of
back-colonisation.

## Usage

``` r
any_back_colonisation(phylod, only_tips = FALSE)
```

## Arguments

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- only_tips:

  A boolean determing whether only the tips (i.e. terminal branches) are
  searched for back colonisation events.

## Value

A single or vector of character strings. Character string is in the
format ancestral_node -\> focal_node, where the ancestral node is not on
mainland but the focal node is. In the case of no back colonisations a
different message string is returned.

## Examples

``` r
# Example with no back colonisation
phylod <- create_test_phylod(test_scenario = 15)
any_back_colonisation(phylod)
#> [1] "No back-colonisation events found in the phylogeny"

# Example with back colonisation
set.seed(
  3,
  kind = "Mersenne-Twister",
  normal.kind = "Inversion",
  sample.kind = "Rejection"
)
phylo <- ape::rcoal(5)
phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e")
phylo <- phylobase::phylo4(phylo)
endemicity_status <- c("endemic", "endemic", "not_present",
                       "endemic", "not_present")
phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
phylod <- add_asr_node_states(phylod = phylod, asr_method = "parsimony")
# aritificially modify data to produce back-colonisation
phylobase::tdata(phylod)$island_status[8] <- "endemic"
any_back_colonisation(phylod = phylod)
#> [1] "8 -> 3"
```
