# impervious land raster from NLCD
balt <- justviz::tracts_sf |>
  sf::st_union() |>
  sf::st_bbox() |>
  sf::st_as_sfc()

# replace NA with 0
impervious <- FedData::get_nlcd(template = balt,
                            label = "balt",
                            year = 2021,
                            dataset = "impervious")

impervious <- terra::subst(impervious, from = NA, to = 0)
impervious <- terra::aggregate(impervious, fact = 3, fun = "mean", na.rm = TRUE)
# impervious <- round(impervious / 255, digits = 2)

terra::writeRaster(impervious, file.path("inst", "raster", "impervious.tif"), overwrite = TRUE,
                   gdal = c("COMPRESS=DEFLATE"), datatype = "INT1U")
