ej <- list(state = "ejscreen_md_state.csv", natl = "ejscreen_md_natl.csv") |>
  purrr::map(\(x) here::here("data-raw/files", x)) |>
  purrr::map(read.csv) |>
  purrr::map(janitor::clean_names) |>
  purrr::map(dplyr::mutate, id = as.character(id)) |>
  purrr::map(dplyr::select, -acstotpop, -demogidx_2, -demogidx_5) |>
  purrr::map(tidyr::pivot_longer,
    cols = -id,
    names_to = c(".value", "indicator"),
    names_pattern = "^(p_?d?[0-9]?)_([a-z0-9]+)$"
  ) |>
  purrr::map(dplyr::rename, tract = id, value_ptile = p, d2_ptile = p_d2, d5_ptile = p_d5) |>
  purrr::map(dplyr::mutate, indicator = forcats::fct_recode(indicator,
    diesel = "dslpm", air_cancer = "cancer", air_respiratory = "resp",
    releases_to_air = "rseiair", traffic = "ptraf", superfund = "pnpl",
    risk_mgmt_plan = "prmp", haz_waste = "ptsdf", undergrnd_storage = "ust",
    wastewater = "pwdis", lead_paint = "ldpnt"
  ))


# state_csv <- here::here("data-raw/files/ejscreen_md_state.csv")
# natl_csv <- here::here()
# # cols like p_pm25, p_d2_pm25, p_d5_pm25
# ejscreen <- read.csv(csv_path) |>
#   janitor::clean_names() |>
#   dplyr::mutate(id = as.character(id)) |>
#   dplyr::select(-acstotpop, -demogidx_2, -demogidx_5) |>
#   tidyr::pivot_longer(-id,
#     names_to = c(".value", "indicator"),
#     names_pattern = "^(p_?d?[0-9]?)_([a-z0-9]+)$"
#   ) |>
#   dplyr::rename(tract = id, value_ptile = p, d2_ptile = p_d2, d5_ptile = p_d5) |>
#   dplyr::mutate(indicator = forcats::fct_recode(indicator, diesel = "dslpm", air_cancer = "cancer",
#                                                 releases_to_air = "rseiair", traffic = "ptraf", superfund = "pnpl",
#                                                 risk_mgmt_plan = "prmp", haz_waste = "ptsdf", undergrnd_storage = "ust",
#                                                 wastewater = "pwdis"))
ejscreen <- ej$state
ej_natl <- ej$natl

usethis::use_data(ejscreen, overwrite = TRUE)
usethis::use_data(ej_natl, overwrite = TRUE)