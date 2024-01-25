# ever been unfairly stopped by police x stopped multiple times
out <- list()
police <- dcws::fetch_cws(code %in% c("DISC2", "DISC2_1"),
                          name %in% c("Connecticut", "New Haven", "Greater New Haven"),
                          .year = 2021) |>
  dplyr::mutate(code = forcats::as_factor(code) |>
                  forcats::fct_recode(ever_unfairly_stopped = "DISC2", multiple_times_3yr = "DISC2_1")) |>
  split(~code) |>
  purrr::map(tidyr::unnest, data)

out[[1]] <- police$ever_unfairly_stopped |>
  cwi::sub_nonanswers() |>
  dplyr::filter(response == "Yes")

out[[2]] <- police$multiple_times_3yr |>
  dplyr::mutate(response = forcats::as_factor(response) |>
                  forcats::fct_collapse(multiple = c("Once every week or more", "A few times every month", "A few times every year", "A few times in the past 3 years"))) |>
  dplyr::group_by(year, name, code, category, group, response) |>
  dplyr::summarise(value = sum(value)) |>
  cwi::sub_nonanswers() |>
  dplyr::filter(response == "multiple")

police_stops <- out |>
  purrr::map(dplyr::ungroup) |>
  purrr::map(dplyr::select, name, code, category, group, value) |>
  dplyr::bind_rows() |>
  tidyr::pivot_wider(id_cols = c(name, category, group), names_from = code, values_from = value) |>
  dplyr::filter(category %in% c("Total", "Gender", "Race/Ethnicity")) |>
  dplyr::mutate(group = dplyr::if_else(category == "Total", "Total", as.character(group)) |>
                  forcats::as_factor()) |>
  dplyr::filter(!is.na(multiple_times_3yr))

usethis::use_data(police_stops, overwrite = TRUE)
