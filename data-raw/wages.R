# copied from work project
income_tbls <- readRDS(file.path("data-raw", "files", "income_tbls.rds")) |>
  purrr::map(dplyr::filter, name %in% c("US", "Maryland")) |>
  purrr::map(dplyr::filter, count >= 100, sample_n >= 30)

wages <- dplyr::bind_rows(income_tbls, .id = "dimension") |>
  tidyr::separate(dimension, into = c("status", "dimension"), sep = "\\.") |>
  dplyr::select(dimension, name, sex, race_eth = race, edu, occ_group, status, is_fulltime,
                dplyr::everything(), -dplyr::matches("_se$")) |>
  dplyr::mutate(dplyr::across(c(dimension, name, sex, race_eth, edu, occ_group, status), forcats::as_factor)) |>
  dplyr::mutate(dplyr::across(sex:occ_group, \(x) forcats::fct_na_value_to_level(x, "Total"))) |>
  dplyr::mutate(dplyr::across(sex:occ_group, \(x) forcats::fct_relevel(x, "Total"))) |>
  dplyr::mutate(sex = sex |>
                  forcats::fct_recode(Men = "Male", Women = "Female") |>
                  forcats::fct_relevel("Total", "Men")) |>
  dplyr::mutate(status = forcats::fct_recode(status, "All workers" = "all_time", "Full-time only" = "full_time")) |>
  dplyr::mutate(race_eth = forcats::fct_relevel(race_eth, "Total", "White", "Black", "Latino", "API")) |>
  dplyr::mutate(is_fulltime = ifelse(is.na(is_fulltime) & status == "Full-time only", TRUE, NA)) |>
  dplyr::mutate(dimension = forcats::fct_relevel(dimension, "total", "sex", "race", "time", "edu", "occ", "sex_x_time", "race_x_sex", "race_x_edu", "sex_x_edu", "sex_x_occ"))

usethis::use_data(wages, overwrite = TRUE)
