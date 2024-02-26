# one of the steps in making cwi::laus_codes drops text after punctuation---should fix that
# in the meantime, glue it back on
county_patt <- c("^Baltimore$" = "Baltimore city",
                 "Prince George" = "Prince George's County",
                 "Queen Anne" = "Queen Anne's County",
                 "St. Mary" = "St. Mary's County")
counties <- cwi::laus_codes |>
  dplyr::filter(type %in% c("A", "F"))
fetch <- cwi::laus_trend(startyear = 2000, endyear = 2023, state = "24") |>
  tidyr::unnest(c(unemployment_rate, unemployment, employment, labor_force)) |>
  dplyr::distinct(area, date, .keep_all = TRUE) |> # baltimore city comes through twice, I guess once as a county & once as a town
  dplyr::semi_join(counties, by = "area") |>
  dplyr::select(name = area, date, rate = unemployment_rate) |>
  dplyr::mutate(name = stringr::str_replace_all(name, county_patt)) |>
  dplyr::mutate(date = tsibble::yearmonth(date))

unemp_adj <- fetch |>
  tsibble::as_tsibble(key = name, index = date) |>
  fabletools::model(seas_adj = feasts::X_13ARIMA_SEATS(rate ~ transform(`function` = "none")))

unemployment <- fabletools::components(unemp_adj) |>
  dplyr::select(name, date, reported_rate = rate, adjusted_rate = season_adjust) |>
  dplyr::mutate(date = as.Date(date)) |>
  dplyr::mutate(dplyr::across(c(reported_rate, adjusted_rate), \(x) x / 100)) |>
  dplyr::as_tibble()

usethis::use_data(unemployment, overwrite = TRUE)
