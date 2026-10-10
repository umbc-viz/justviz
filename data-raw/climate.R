url <- "https://mdgeodata.md.gov/imap/rest/services/Environment/MD_Climate_Vulnerability_Score/MapServer"
climate_server <- arcgislayers::arc_open(url)

climate <- climate_server |>
    arcgislayers::get_layer(id = 0) |>
    arcgislayers::arc_select(
        fields = c("GEOID20", "TCC", "DROUGHT", "UHI", "FLOOD_SS", "CVS_PCTL")
    ) |>
    janitor::clean_names() |>
    sf::st_drop_geometry() |>
    dplyr::mutate(tcc = round(tcc / 100, digits = 3)) |>
    dplyr::mutate(cvs_pctl = round(cvs_pctl, digits = 2)) |>
    dplyr::mutate(dplyr::across(c(drought, uhi, flood_ss), as.integer)) |>
    dplyr::rename(geoid = geoid20)

usethis::use_data(climate, overwrite = TRUE)
