# these are copied over from a project at work
income_pumas <- readRDS(file.path("data-raw", "files", "income_by_puma.rds"))

wages_by_puma <- income_pumas |>
  dplyr::bind_rows() |>
  dplyr::ungroup() |>
  dplyr::select(-dplyr::matches("_se$"), -sample_n)

usethis::use_data(wages_by_puma, overwrite = TRUE)
