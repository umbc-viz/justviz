url <- "https://egisdata.baltimorecity.gov/egis/rest/services/Housing/DHCD_Open_Baltimore_Datasets/FeatureServer"
dhcd_server <- arcgislayers::arc_open(url)
# fix it at today so data doesn't update as more records added online
updated <- as.Date("2026-10-05")
# might add in rehabs, layer 2
# for now just vacant notices, layer 1

vacants_sf <- dhcd_server |>
    arcgislayers::get_layer(id = 1) |>
    arcgislayers::arc_select(
        fields = c("OBJECTID", "DateNotice", "BLOCKLOT")
    ) |>
    janitor::clean_names() |>
    dplyr::mutate(date_notice = as.Date(date_notice)) |>
    dplyr::filter(date_notice <= updated) |>
    sf::st_transform(sf::st_crs(justviz::tracts_sf))

vacants_by_tract <- sf::st_join(vacants_sf, justviz::tracts_sf) |>
    sf::st_drop_geometry() |>
    dplyr::count(geoid) |>
    tibble::as_tibble() |>
    dplyr::rename(n_vacants = n)

attr(vacants_sf, "last_updated") <- updated
attr(vacants_by_tract, "last_updated") <- updated

usethis::use_data(vacants_sf, overwrite = TRUE)
usethis::use_data(vacants_by_tract, overwrite = TRUE)
