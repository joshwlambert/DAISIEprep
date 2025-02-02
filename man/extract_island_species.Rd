% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extract_island_species.R
\name{extract_island_species}
\alias{extract_island_species}
\title{Extracts the colonisation, diversification, and endemicty data from
phylogenetic and endemicity data and stores it in an \code{Island_tbl} object}
\usage{
extract_island_species(
  phylod,
  extraction_method,
  island_tbl = NULL,
  include_not_present = FALSE,
  nested_asr_species = c("split", "group"),
  force_nonendemic_singleton = FALSE,
  unique_clade_name = TRUE
)
}
\arguments{
\item{phylod}{A \code{phylo4d} object from the package \code{phylobase} containing
phylogenetic and endemicity data for each species.}

\item{extraction_method}{A character string specifying whether the
colonisation time extracted is the minimum time (\code{min}) (before the present),
or the most probable time under ancestral state reconstruction (\code{asr}).}

\item{island_tbl}{An instance of the \code{Island_tbl} class.}

\item{include_not_present}{A boolean determining whether species not present
on the island should be included in island colonist when embedded within an
island clade. Default is FALSE.}

\item{nested_asr_species}{A \code{character} string which determines whether
\emph{nested island colonists} are split into separate colonists (\code{"split"}), or
grouped into a single clade (\code{"group"}). Nested species are those whose tip
state is on the island, and they have ancestral nodes on the island, but
there are nodes in between these island state nodes that have the state
\code{not_present} (i.e. not on the island). Therefore, the colonisation time
can be extracted as the most recent node state on the island (this can be
the branching time before the tip if the ancestor node of the tip is not
on the island), or the older node state of the larger clade, for \code{"split"}
or \code{"group"} respectively. \strong{Note} This argument only applies when
\code{extraction_method = "asr"}.}

\item{force_nonendemic_singleton}{A boolean that determines whether all
species that are classified as \code{"nonendemic"} are forced to be extracted as
singletons (i.e single species lineages). By default it is \code{FALSE} so
non-endemics can be extracted either as singletons or part of an endemic
clade. When set to \code{TRUE} all non-endemic species in the tree will be
single species colonists, with the colonisation time extracted as the stem
age for the tip in the phylogeny. There are some exceptions to this, please
see \code{vignette("Forcing_nonendemic_singleton", package = "DAISIEprep")} for more details.

This argument is only active when \code{extraction_method = "asr"}, when
\code{extraction_method = "min"} this argument will be ignored with a warning,
as the \code{min} method always extracts non-endemic species as singletons.}

\item{unique_clade_name}{Boolean determining whether a unique species
identifier is used as the clade name in the Island_tbl object or a genus
name which may not be unique if that genus has several independent island
colonisations}
}
\value{
An object of \code{Island_tbl} class
}
\description{
Extracts the colonisation, diversification, and endemicty data from
phylogenetic and endemicity data and stores it in an \code{Island_tbl} object
}
\examples{
set.seed(
  1,
  kind = "Mersenne-Twister",
  normal.kind = "Inversion",
  sample.kind = "Rejection"
)
phylo <- ape::rcoal(10)
phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
                     "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
phylo <- phylobase::phylo4(phylo)
endemicity_status <- sample(
  c("not_present", "endemic", "nonendemic"),
  size = length(phylobase::tipLabels(phylo)),
  replace = TRUE,
  prob = c(0.6, 0.2, 0.2)
)
phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
extract_island_species(phylod, extraction_method = "min")
}
