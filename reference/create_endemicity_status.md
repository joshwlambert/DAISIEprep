# Creates a data frame with the endemicity status (either 'endemic', 'nonendemic', 'not_present') of every species in the phylogeny using a phylogeny and a data frame of the island species and their endemicity (either 'endemic' or 'nonendemic') provided.

Creates a data frame with the endemicity status (either 'endemic',
'nonendemic', 'not_present') of every species in the phylogeny using a
phylogeny and a data frame of the island species and their endemicity
(either 'endemic' or 'nonendemic') provided.

## Usage

``` r
create_endemicity_status(phylo, island_species)
```

## Arguments

- phylo:

  A phylogeny either as a `phylo` (from the `ape` package) or `phylo4`
  (from the `phylobase` package) object.

- island_species:

  Data frame with two columns. The first is a character string of the
  tip_labels with the tip names of the species on the island. The second
  column a character string of the endemicity status of the species,
  either endemic or nonendemic.

## Value

Data frame with single column of character strings and row names

## Details

Species included in the `island_species` data frame but not included in
the `phylo` will not be included in the output and warning will print
all of the species that are in the `island_species` that are not found
in the `phylo`.

## Examples

``` r
set.seed(
  1,
  kind = "Mersenne-Twister",
  normal.kind = "Inversion",
  sample.kind = "Rejection"
)
phylo <- ape::rcoal(4)
phylo$tip.label <- c("species_a", "species_b", "species_c", "species_d")
phylo <- methods::as(phylo, "phylo4")
island_species <- data.frame(
  tip_labels = c("species_a", "species_b", "species_c", "species_d"),
  tip_endemicity_status = c("endemic", "endemic", "endemic", "nonendemic")
)
endemicity_status <- create_endemicity_status(
  phylo = phylo,
  island_species = island_species
)
```
