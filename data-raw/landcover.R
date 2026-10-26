# land cover raster from NLCD
balt <- tigris::counties(state = "MD") |>
    dplyr::filter(
        NAMELSAD %in%
            c(
                "Baltimore city",
                "Baltimore County",
                "Anne Arundel County",
                "Howard County"
            )
    ) |>
    sf::st_union() |>
    sf::st_bbox() |>
    sf::st_as_sfc()

# replace NA with 0
landcover <- FedData::get_nlcd(
    template = balt,
    label = "balt",
    year = 2021
)

# impervious <- FedData::get_nlcd(
#     template = balt,
#     label = "balt",
#     year = 2021,
#     dataset = "impervious"
# )

# canopy <- terra::subst(canopy, from = NA, to = 0)
# canopy <- terra::aggregate(canopy, fact = 3, fun = "mean", na.rm = TRUE)

# impervious <- terra::subst(impervious, from = NA, to = 0)
# impervious <- terra::aggregate(impervious, fact = 3, fun = "mean", na.rm = TRUE)

# terra::writeRaster(
#     canopy,
#     file.path("inst", "raster", "canopy.tif"),
#     overwrite = TRUE,
#     gdal = c("COMPRESS=DEFLATE"),
#     datatype = "INT1U"
# )

# terra::writeRaster(
#     impervious,
#     file.path("inst", "raster", "impervious.tif"),
#     overwrite = TRUE,
#     gdal = c("COMPRESS=DEFLATE"),
#     datatype = "INT1U"
# )
terra::writeRaster(
    landcover,
    file.path("inst", "raster", "landcover.tif"),
    overwrite = TRUE,
    gdal = c("COMPRESS=DEFLATE"),
    datatype = "INT1U"
)
