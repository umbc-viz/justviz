# helper function to load land cover rasters from sys files
#' @title Load land cover raster data
#' @description This is a helper function to load landcover raster data for the Baltimore area. From the National Land Cover Database (NLCD) obtained with ROpenSci's `FedData` package.
#' @return A raster of class `terra::SpatRaster` with 1 band.
#' @examples
#' landcover <- load_land_cover()
#' landcover
#' \dontrun{
#'   if (interactive()) {
#'     terra::plot(landcover)
#'   }
#' }
#' @export
#' @source \url{https://www.mrlc.gov/data/legends/national-land-cover-database-class-legend-and-description}
#' @seealso [`FedData::get_nlcd`]
#'
load_land_cover <- function() {
    # match.arg(type)
    type <- "landcover"
    fn <- paste(type, "tif", sep = ".")
    path <- system.file("raster", fn, package = "justviz")
    r <- terra::rast(path)
    # r <- round(r / 255, digits = 2)
    r
}
