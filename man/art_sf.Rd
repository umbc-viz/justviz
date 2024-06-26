% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{art_sf}
\alias{art_sf}
\title{Public art in Baltimore}
\format{
An sf data frame with 672 rows and 12 variables:
\describe{
\item{id}{Integer. An ID, identical to the object ID in the original dataset.}
\item{county}{Character. County name where art is located.}
\item{artist_last_name}{Character. Last name(s) of the artist(s).}
\item{artist_first_name}{Character. First name(s) of the artist(s).}
\item{title}{Character. Artwork title.}
\item{date}{Character. Year of artwork, including some spans of multiple years.}
\item{medium}{Character. Medium of artwork.}
\item{location}{Character. Name of location or address.}
\item{site}{Character. Description of location where art is situated.}
\item{visibility}{Character. Description of level of visibility to public. This variable is very sparsely populated.}
\item{access}{Character. Description of public access. This variable is very sparsely populated.}
\item{geometry}{POINT. Location.}
}
}
\source{
Open Baltimore data portal. Public Art Inventory, available at \url{https://data.baltimorecity.gov/datasets/baltimore::public-art-inventory}
}
\usage{
art_sf
}
\description{
A spatial points dataset of public art in and near Baltimore city. This comes from the city's open data portal. Some projects appear to be inside of buildings and therefore not visible from the outside, but much of this metadata is incomplete. Several art projects without coordinates included, or with coordinates outside of Baltimore city, Baltimore County, and Anne Arundel County were dropped.
}
\examples{
 head(art_sf)
}
\keyword{datasets}
