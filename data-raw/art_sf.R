# get locations of public art in Baltimore from city open data portal
# a few are in anne arundel county but one is far out in Howard county
county_sf <- tigris::counties(state = "24") |>
  dplyr::select(county = NAMELSAD) |>
  dplyr::filter(county %in% c("Baltimore city", "Baltimore County", "Anne Arundel County"))
url <- "https://services1.arcgis.com/UWYHeuuJISiGmgXx/arcgis/rest/services/PublicArtInventory/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"

art <- jsonlite::read_json(url)[["features"]]
art <- purrr::map(art, \(x) x[["attributes"]])
art <- purrr::map(art, purrr::compact)
art <- purrr::map(art, dplyr::as_tibble)
art <- dplyr::bind_rows(art)
art <- janitor::clean_names(art)
art <- dplyr::rename(art, loc_tmp = location)
art <- dplyr::rename_with(art, \(x) stringr::str_remove(x, "_of_artwork"))
art <- dplyr::select(art, id = objectid, artist_last_name, artist_first_name, title, date, medium,
                     location, site, visibility, access = indoor_outdoor_accessible, loc_tmp)
# art$medium <- tolower(art$medium)
art <- dplyr::mutate(art, dplyr::across(c(medium, visibility, access), tolower))
art <- dplyr::mutate(art, dplyr::across(dplyr::where(is.character), \(x) dplyr::na_if(x, "n/a")))
art$access <- stringr::str_replace(art$access, "acessible", "accessible")
art$geometry <- stringr::str_extract(art$loc_tmp, "(?<=\n).+$")
art <- dplyr::filter(art, !is.na(geometry))
art$geometry <- stringr::str_replace_all(art$geometry, "\\((.+), (.+)\\)", "POINT(\\2 \\1)")
art$loc_tmp <- NULL
art_sf <- sf::st_as_sf(art, wkt = "geometry", crs = 4326)
art_sf <- sf::st_transform(art_sf, sf::st_crs(county_sf))

# filter for just those counties
art_sf <- sf::st_join(art_sf, county_sf, left = FALSE)
art_sf <- dplyr::select(art_sf, id, county, dplyr::everything())

usethis::use_data(art_sf, overwrite = TRUE)
