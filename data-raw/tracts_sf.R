tracts_sf <- tigris::tracts(state = "MD",
                         county = c("Baltimore County", "Baltimore city", "Anne Arundel County", "Howard County"),
                         cb = TRUE) |>
  dplyr::select(county = NAMELSADCO, geoid = GEOID) |>
  rmapshaper::ms_simplify(keep = 0.5)

usethis::use_data(tracts_sf, overwrite = TRUE)
