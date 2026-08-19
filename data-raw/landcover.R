# tree canopy raster from NLCD
tracts_sf <- tigris::tracts(
    state = "MD",
    county = c(
        "Baltimore County",
        "Baltimore city",
        "Anne Arundel County",
        "Howard County"
    ),
    cb = TRUE
) |>
    dplyr::select(county = NAMELSADCO, geoid = GEOID) |>
    rmapshaper::ms_simplify(keep = 0.5)
balt <- tracts_sf |>
    sf::st_union() |>
    sf::st_bbox() |>
    sf::st_as_sfc()

# replace NA with 0
canopy <- FedData::get_nlcd(
    template = balt,
    label = "balt",
    year = 2021,
    dataset = "canopy"
)

impervious <- FedData::get_nlcd(
    template = balt,
    label = "balt",
    year = 2021,
    dataset = "impervious"
)

# canopy <- terra::subst(canopy, from = NA, to = 0)
canopy <- terra::aggregate(canopy, fact = 3, fun = "mean", na.rm = TRUE)
# canopy <- round(canopy / 255, digits = 2)

impervious <- terra::subst(impervious, from = NA, to = 0)
impervious <- terra::aggregate(impervious, fact = 3, fun = "mean", na.rm = TRUE)

terra::writeRaster(
    canopy,
    file.path("inst", "raster", "canopy.tif"),
    overwrite = TRUE,
    gdal = c("COMPRESS=DEFLATE"),
    datatype = "INT1U"
)

terra::writeRaster(
    impervious,
    file.path("inst", "raster", "impervious.tif"),
    overwrite = TRUE,
    gdal = c("COMPRESS=DEFLATE"),
    datatype = "INT1U"
)
