osmdata::set_overpass_url("https://overpass-api.de/api/interpreter")
counties <- tigris::counties(state = "24", cb = TRUE) |>
  dplyr::filter(NAMELSAD %in% c("Baltimore County", "Baltimore city", "Anne Arundel County", "Howard County"))


bb <- sf::st_bbox(counties)
road_types <- c("motorway", "trunk")
highways <- osmdata::opq(bbox = bb) |>
  osmdata::add_osm_feature(key = "highway", value = road_types) |>
  osmdata::osmdata_sf()
highways_sf <- highways$osm_lines |>
  dplyr::select(osm_id, name, lanes) |>
  dplyr::mutate(lanes = as.numeric(lanes))

row.names(highways_sf) <- NULL

# parks <- osmdata::opq(bbox = bb) |>
#   osmdata::add_osm_feature(key = "leisure", value = "park") |>
#   osmdata::osmdata_sf()
# parks_sf <- dplyr::bind_rows(
#   parks$osm_polygons |> dplyr::select(osm_id, name),
#   parks$osm_multipolygons |> dplyr::select(osm_id, name)
# )

usethis::use_data(highways_sf, overwrite = TRUE)
