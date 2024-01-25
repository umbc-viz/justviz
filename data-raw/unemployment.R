fetch <- cwi::laus_trend(names = c("Maryland", "Baltimore", "Baltimore County", "Anne Arundel County", "Howard County"),
                                startyear = 2000, endyear = 2023, state = "24") |>
  tidyr::unnest(c(unemployment_rate, unemployment, employment, labor_force)) |>
  dplyr::distinct(area, date, .keep_all = TRUE) |> # baltimore city comes through twice, I guess once as a county & once as a town
  dplyr::select(name = area, date, rate = unemployment_rate) |>
  dplyr::mutate(name = stringr::str_replace(name, "^Baltimore$", "Baltimore City")) |>
  dplyr::mutate(date = tsibble::yearmonth(date))

unemp_adj <- fetch |>
  tsibble::as_tsibble(key = name, index = date) |>
  fabletools::model(seas_adj = feasts::X_13ARIMA_SEATS(rate ~ transform(`function` = "none")))

unemployment <- fabletools::components(unemp_adj) |>
  dplyr::select(name, date, reported_rate = rate, adjusted_rate = season_adjust) |>
  dplyr::mutate(date = as.Date(date)) |>
  dplyr::as_tibble()

usethis::use_data(unemployment, overwrite = TRUE)
