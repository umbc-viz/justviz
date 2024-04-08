# had to switch API URL to https://overpass-api.de/api/interpreter
# keep ones in low-residential tracts
osmdata::set_overpass_url("https://overpass-api.de/api/interpreter")
counties <- tigris::counties(state = "24", cb = TRUE) |>
  sf::st_union()
bb <- sf::st_bbox(counties)
all_hh <- tidycensus::get_acs("tract", variables = "B25003_001", year = 2022, state = "24", geometry = TRUE) |>
  dplyr::select(geoid = GEOID, hh = estimate) |>
  sf::st_transform(2248)
low_res <- all_hh |>
  dplyr::filter(hh < 500)

features <- tibble::tribble(
  ~id, ~key, ~value,
  "prison", "amenity", "prison",
  "military", "landuse", "military",
  "industrial", "landuse", "industrial",
  "airport", "aeroway", "aerodrome",
  "wastewater", "water", "wastewater",
  "protected_area", "boundary", "protected_area"
)

# could use osmdata::add_osm_features but I'd rather have different location types
# in different data frames since so many attributes don't overlap
qs <- purrr::pmap(features, function(id, key, value) {
  q <- osmdata::opq(bbox = bb)
  q <- osmdata::add_osm_feature(q, key = key, value = value)
  q <- osmdata::osmdata_sf(q)
  q <- q[c("osm_polygons", "osm_multipolygons", "osm_points")]
  polys <- purrr::compact(q[c("osm_polygons", "osm_multipolygons")])
  points <- q[["osm_points"]]
  if (length(polys) > 1) {
    polys <- dplyr::bind_rows(polys)
  } else {
    polys <- purrr::pluck(polys, 1)
  }
  out <- list(polys = polys, points = points)
  # out <- purrr::compact(out)
  out <- purrr::map(out, sf::st_transform, 2248)
  out <- purrr::map(out, sf::st_make_valid)
  out
})
names(qs) <- features$id

# drop points---they seem to be mostly individual buildings at larger sites, etc
nonres_sf <- qs |>
  purrr::map(purrr::pluck, "polys") |>
  purrr::map(dplyr::select, osm_id, name)
nonres_sf <- dplyr::bind_rows(nonres_sf, .id = "type")
nonres_sf <- dplyr::filter(nonres_sf, !is.na(name))
nonres_sf <- sf::st_intersection(nonres_sf, sf::st_transform(counties, 2248))
# nonres_sf <- sf::st_intersection(nonres_sf, sf::st_union(low_res))
nonres_sf$area <- sf::st_area(nonres_sf$geometry)
nonres_sf$area <- measurements::conv_unit(nonres_sf$area, "ft2", "mi2")
nonres_sf$area <- as.numeric(nonres_sf$area)
nonres_sf <- dplyr::distinct(nonres_sf, .keep_all = TRUE)
nonres_sf <- sf::st_cast(nonres_sf, "POLYGON")
nonres_sf <- dplyr::filter(nonres_sf, area > 0.2)
nonres_sf$type <- as.factor(nonres_sf$type)
nonres_sf$area <- NULL

nonres_sf$is_low_res <- lengths(sf::st_intersects(nonres_sf, low_res)) > 0
nonres_sf$name <- stringr::str_replace_all(nonres_sf$name, "’", "'")
nonres_sf <- sf::st_transform(nonres_sf, sf::st_crs(counties))

usethis::use_data(nonres_sf, overwrite = TRUE)
