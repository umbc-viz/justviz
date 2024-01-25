csv_path <- here::here("data-raw/files/ejscreen_md.csv")
# cols like p_pm25, p_d2_pm25, p_d5_pm25
ejscreen <- read.csv(csv_path) |>
  janitor::clean_names() |>
  dplyr::mutate(id = as.character(id)) |>
  dplyr::select(-acstotpop, -demogidx_2, -demogidx_5) |>
  tidyr::pivot_longer(-id,
    names_to = c(".value", "indicator"),
    names_pattern = "^(p_?d?[0-9]?)_([a-z0-9]+)$"
  ) |>
  dplyr::rename(tract = id, value_ptile = p, d2_ptile = p_d2, d5_ptile = p_d5) |>
  dplyr::mutate(indicator = forcats::fct_recode(indicator, diesel = "dslpm", air_cancer = "cancer",
                                                releases_to_air = "rseiair", traffic = "ptraf", superfund = "pnpl",
                                                risk_mgmt_plan = "prmp", haz_waste = "ptsdf", undergrnd_storage = "ust",
                                                wastewater = "pwdis"))

usethis::use_data(ejscreen, overwrite = TRUE)
