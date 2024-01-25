places_urls <- list(
  county = "https://data.cdc.gov/resource/swc5-untb.csv",
  tract = "https://data.cdc.gov/resource/cwsq-ngmh.csv"
)

p_query <- list(
  "$query" = "select year, stateabbr, coalesce(locationname, stateabbr) as location, short_question_text as indicator, data_value as value, totalpopulation as pop
  where data_value_type = 'Crude prevalence'
  and stateabbr in ('MD', 'US')
  and measureid in ('CASTHMA', 'DEPRESSION', 'DIABETES', 'DENTAL', 'CHECKUP', 'ACCESS2', 'MHLTH', 'MOBILITY', 'SLEEP', 'CANCER')
  limit 1000000"
)

# use socrata API to get just columns of interest for US average plus MD counties & tracts
# keep as list to bind together by level
# need weighted mean of tract values to get statewide estimates
places_read <- purrr::map(places_urls, httr::GET, query = p_query) |>
  purrr::map(\(x) httr::content(x, col_types = readr::cols(.default = "c"))) |>
  purrr::map(\(x) dplyr::mutate(x, dplyr::across(c(value, pop), readr::parse_number)))

places <- list()
places[["us"]] <- dplyr::filter(places_read$county, location == "US")
places[["state"]] <- places_read$tract |>
  dplyr::group_by(year, stateabbr, location = "Maryland", indicator) |>
  dplyr::summarise(value = weighted.mean(value, pop),
                   pop = sum(pop)) |>
  dplyr::ungroup()
places[["county"]] <- dplyr::filter(places_read$county, location != "US")
places[["tract"]] <- places_read$tract
cdc <- dplyr::bind_rows(places, .id = "level") |>
  dplyr::mutate(level = forcats::as_factor(level)) |>
  dplyr::mutate(indicator = stringr::str_to_sentence(indicator)) |>
  dplyr::select(-stateabbr)


usethis::use_data(cdc, overwrite = TRUE)
