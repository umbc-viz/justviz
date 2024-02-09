# these are copied over from a project at work
income_pumas <- readRDS(file.path("data-raw", "files", "income_by_puma.rds"))

wages_by_puma <- income_pumas |>
  dplyr::bind_rows() |>
  dplyr::ungroup() |>
  dplyr::select(-dplyr::matches("_se$"), -sample_n) |>
  dplyr::mutate(sex = forcats::as_factor(sex)) |>
  dplyr::mutate(sex = forcats::fct_recode(sex, Men = "Male", Women = "Female")) |>
  dplyr::mutate(sex = forcats::fct_relevel(sex, "Men"))

usethis::use_data(wages_by_puma, overwrite = TRUE)
