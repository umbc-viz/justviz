# compare baltimore vs new haven vacancy---density of housing units, housing value
# i have a hunch that NHV vacancies are mostly expensive condos
vars <- c(total_units = "B25002_001", vacants = "B25002_003",
          med_rent = "B25064_001", med_housing_value = "B25077_001")

ct_tracts <- cwi::xwalk |>
  dplyr::distinct(town, cog_fips, cog, tract_cog) |>
  dplyr::filter(town %in% c("Stamford", "New Haven")) |>
  tidyr::separate_wider_position(cog_fips, widths = c(state = 2, county = 3)) |>
  dplyr::rename(city = town, tract = tract_cog, county_name = cog)

ct_geos <- dplyr::distinct(ct_tracts, state, city, county, county_name)

geos <- tidycensus::fips_codes |>
  dplyr::filter(state == "MD") |>
  dplyr::select(state = state_code, county = county_code, county_name = county) |>
  dplyr::mutate(city = stringr::str_extract(county_name, "([\\w\\s]+)(?= city)")) |>
  dplyr::bind_rows(ct_geos)

tracts <- geos |>
  dplyr::mutate(data = purrr::pmap(geos, function(state, county, county_name, city) {
    tigris::tracts(state = state, county = county, cb = TRUE, year = 2022) |>
      janitor::clean_names()
  })) |>
  tidyr::unnest(data) |>
  dplyr::select(state, city, county, county_name, geoid, aland) |>
  dplyr::filter(state != "09" | geoid %in% ct_tracts$tract)

housing <- purrr::pmap(geos, function(state, county, county_name, city) {
  acs <- tidycensus::get_acs("tract", variables = vars,
                             state = state, county = county, year = 2022) |>
    janitor::clean_names() |>
    tidyr::pivot_wider(id_cols = geoid, names_from = variable, values_from = estimate) |>
    dplyr::mutate(vacancy_rate = vacants / total_units)
  acs
}) |>
  dplyr::bind_rows()

vacant <- tracts |>
  dplyr::inner_join(housing, by = "geoid") |>
  dplyr::mutate(area_sqmi = measurements::conv_unit(aland, "m2", "mi2")) |>
  dplyr::mutate(housing_density = total_units / area_sqmi) |>
  dplyr::select(everything(), -aland)

#
# # keeping for notes--example of simpson's paradox
# mod <- lm(vacancy_rate ~ log10(med_housing_value) * city,
#           data = tibble::column_to_rownames(vacant, "geoid"),
#           weights = total_units)
#
# broom::augment(mod) |>
#   janitor::clean_names() |>
#   ggplot(aes(x = log10_med_housing_value, y = vacancy_rate, color = city)) +
#   geom_point(alpha = 0.8) +
#   geom_line(aes(y = fitted))


usethis::use_data(vacant, overwrite = TRUE)
