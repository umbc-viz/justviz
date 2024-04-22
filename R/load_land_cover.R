# helper function to load land cover rasters from sys files
#' @title Load land cover raster data
#' @description This is a helper function to load one of two types of raster data for the Baltimore area. Both are land cover data from the National Land Cover Database (NLCD) obtained with ROpenSci's `FedData` package. The "canopy" data is the percentage of each pixel that is covered by tree canopy, for vegetation-related land cover types. The "impervious" data is the percentage of each pixel that is considered an impervious surface, for urban developed land cover types. Both files originally were downloaded as 30m x 30m rasters with values ranging from 1 to 255 and `NA` at pixels of other land cover types. Both were then downsampled to 90m x 90m, scaled to percentages, and `NA` values were replaced with 0.
#' @param type String, type of land cover raster to return. Either "canopy" or "impervious".
#' @return A raster of class `terra::SpatRaster` with 1 band.
#' @examples
#' canopy <- load_land_cover("canopy")
#' canopy
#' \dontrun{
#'   if (interactive()) {
#'     plot(canopy)
#'   }
#' }
#' @export
#' @source \url{https://www.mrlc.gov/data/legends/national-land-cover-database-class-legend-and-description}
#' @seealso [`FedData::get_nlcd`]
#'
load_land_cover <- function(type = c("canopy", "impervious")) {
  match.arg(type)
  fn <- paste(type, "tif", sep = ".")
  path <- system.file("raster", fn, package = "justviz")
  r <- terra::rast(path)
  r <- round(r / 255, digits = 2)
  r
}
