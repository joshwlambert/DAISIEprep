% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/island_tbl-accessors.R
\name{get_island_tbl}
\alias{get_island_tbl}
\alias{get_island_tbl,Island_tbl-method}
\alias{set_island_tbl<-}
\alias{set_island_tbl<-,Island_tbl-method}
\title{Accessor functions for the data (slots) in objects of the
\code{\linkS4class{Island_tbl}} class}
\usage{
get_island_tbl(x)

\S4method{get_island_tbl}{Island_tbl}(x)

set_island_tbl(x) <- value

\S4method{set_island_tbl}{Island_tbl}(x) <- value
}
\arguments{
\item{x}{An object whose class is determined by the signature.}

\item{value}{A value which can take several forms to be assigned to an object
of a class.}
}
\description{
Accessor functions for the data (slots) in objects of the
\code{\linkS4class{Island_tbl}} class
}
\examples{
tbl <- island_tbl()
get_island_tbl(tbl)
set_island_tbl(tbl) <- data.frame(
  clade_name = "birds",
  status = "endemic",
  missing_species = 0,
  branching_times = I(list(c(1.0, 0.5)))
)
}
\author{
Joshua W. Lambert
}