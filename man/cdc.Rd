% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{cdc}
\alias{cdc}
\title{Adult health data from the CDC}
\format{
A data frame with 14140 rows and 6 variables:
\describe{
\item{level}{Factor. The level of the data (us, state, etc.).}
\item{year}{Character. The year the data was collected.}
\item{location}{Character. The location where the data was collected (US, Maryland, etc.).}
\item{indicator}{Character. The health indicator being measured.}
\item{value}{Numeric. The rate of the corresponding population.}
\item{pop}{Numeric. The adult population size for the given location and year, used as the denominator.}
}
}
\source{
Centers for Disease Control and Prevention (CDC) PLACES Project. Data portal, definitions, and methodology are available at \url{https://www.cdc.gov/places/}
}
\usage{
cdc
}
\description{
A dataset containing health indicators from the CDC's PLACES project for the US, Maryland, and the state's counties and census tracts. Where tract-level data couldn't be directly measured, values are modeled. This is the most recent data from the 2023 update. The denominator for all variables is the population of adults ages 18 and older, except missing health insurance, which is based on adults ages 18 to 64.
}
\examples{
 head(cdc)
}
\keyword{datasets}
