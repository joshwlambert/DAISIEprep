# DAISIEprep

<!-- badges: start -->
  [![R-CMD-check](https://github.com/joshwlambert/DAISIEprep/workflows/R-CMD-check/badge.svg)](https://github.com/joshwlambert/DAISIEprep/actions)
[![Codecov test coverage](https://codecov.io/gh/joshwlambert/DAISIEprep/branch/master/graph/badge.svg)](https://app.codecov.io/gh/joshwlambert/DAISIEprep?branch=master)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Project Status: WIP](https://www.repostatus.org/badges/latest/wip.svg)](https://github.com/joshwlambert/DAISIEprep/#wip)
<!-- badges: end -->

## Package description

DAISIEprep is an R package that enables the extraction and formatting of phylogenetic data on island species for the inference model [DAISIE](https://github.com/rsetienne/DAISIE) (Dynamic Assembly of Island biota through Speciation, Immigration and Extinction). The central function, `DAISIEprep::extract_island_species()`, uses data from phylogenetic trees and species island endemicity statuses (i.e. endemic to the island, non-endemic, or not present on the island). The phylogenetic and endemicity data are handled together using the `phylo4d` S4 class from the [`phylobase`](https://github.com/fmichonneau/phylobase) R package. 

DAISIEprep fills the niche of standardised, reproducible data processing for the suite of DAISIE inference models. Unlike other phylogenetic methods implemented in R, DAISIE has yet to have a defined methodological framework to extract and format data prior to analysis. While other phylogenetic models in R use common `phylo` S3 data structure from the defined by the R package [`ape`](https://github.com/emmanuelparadis/ape), DAISIE has an idiosynchratic data structure that will be unfamiliar to new users. This package provides a set of tools for those users to facilitate the application of DAISIE model for research. The package also opens the possibility of extracted data from ‘big data’ macrophylogenies (>5,000 species) which would have impeded researchers who would have previously had to extract this data manually.

There are two algorithms to extract the data the min algorithm or asr (ancestral state reconstruction) algorithm. The former is based on the rules/assumptions of the DAISIE inference model of colonisation of species from mainland source pool, speciation on the island through cladogenesis or anagenensis, and island extinction. Therefore, this algorithm assumes no back-colonisation from the island to the mainland or mainland evolutionary processes. If the data seems to conform to these assumptions (by visual inspection) then this is a good method to choose (DAISIEprep::extract_island_species(phylod, extraction_method = “min”). Alternatively, the data may violate these assumptions, by, for example having species within an island radiation migrate back to the mainland. In these, and other, cases the asr algorithm provides a method to extract data based on the most probably reconstruction of the species ranges (i.e. island presence/absence) and then can extract clades that may have non-island species. The asr algorithm utilises ancestral state reconstruction methods from other packages (e.g. [`castor`](https://cran.r-project.org/web/packages/castor/index.html)), but the package is flexible to users extending this to incorporate other models which may better suit their data set.

## Installation

``` r
remotes::install.packages("remotes")
remotes::install_github("joshwlambert/DAISIEprep")
```

## Tutorial

See [tutorial](vignettes/Tutorial.Rmd).

## Help

To report a bug please open an [issue](https://github.com/joshwlambert/DAISIEprep/issues/new) or email at j.w.l.lambert@rug.nl.

## Contribute

The DAISIE team always welcomes contributions to any of its packages. If you
would like to contribute to this package please follow the [contributing guidelines](https://github.com/joshwlambert/DAISIEprep/tree/master/.github/CONTRIBUTING.md)

## Code of Conduct

Please note that the DAISIEprep project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
