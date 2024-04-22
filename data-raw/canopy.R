# tree canopy raster from NLCD
balt <- justviz::tracts_sf |>
  sf::st_union() |>
  sf::st_bbox() |>
  sf::st_as_sfc()

# replace NA with 0
canopy <- FedData::get_nlcd(template = balt,
                          label = "balt",
                          year = 2021,
                          dataset = "canopy")

# canopy <- terra::subst(canopy, from = NA, to = 0)
canopy <- terra::aggregate(canopy, fact = 3, fun = "mean", na.rm = TRUE)
# canopy <- round(canopy / 255, digits = 2)

terra::writeRaster(canopy, file.path("inst", "raster", "canopy.tif"), overwrite = TRUE,
                   gdal = c("COMPRESS=DEFLATE"), datatype = "INT1U")
