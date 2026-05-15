# Remove any duplicated species from the `island_tbl` after `"asr"` extraction

Removes any duplicates species from the `island_tbl` by choosing to
either have duplicated species be in smaller, more recently colonised
clade(s) and removing them from the larger, older clade(s)
(`nested_asr_species = "split"`), or removing the smaller, more recently
colonised clade(s) in favour of leaving them in the larger, older
clade(s) (`nested_asr_species = "group"`).

## Usage

``` r
rm_duplicate_island_species(
  island_tbl,
  phylod,
  nested_asr_species,
  include_not_present
)
```

## Arguments

- island_tbl:

  An instance of the `Island_tbl` class.

- phylod:

  A `phylo4d` object from the package `phylobase` containing
  phylogenetic and endemicity data for each species.

- nested_asr_species:

  A `character` string which determines whether *nested island
  colonists* are split into separate colonists (`"split"`), or grouped
  into a single clade (`"group"`). Nested species are those whose tip
  state is on the island, and they have ancestral nodes on the island,
  but there are nodes in between these island state nodes that have the
  state `not_present` (i.e. not on the island). Therefore, the
  colonisation time can be extracted as the most recent node state on
  the island (this can be the branching time before the tip if the
  ancestor node of the tip is not on the island), or the older node
  state of the larger clade, for `"split"` or `"group"` respectively.
  **Note** This argument only applies when `extraction_method = "asr"`.

- include_not_present:

  A boolean determining whether species not present on the island should
  be included in island colonist when embedded within an island clade.
  Default is FALSE.

## Value

An object of `Island_tbl` class
