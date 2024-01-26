if (require("dcws")) {
  youth_risks <- dcws::fetch_cws(grepl("^LIFE", code), .name = "Connecticut", .year = 2021, .unnest = TRUE) |>
    dplyr::mutate(response = forcats::as_factor(response)) |>
    dplyr::select(code, question, category, group, response, value) |>
    dplyr::filter(category != "Five Connecticuts") |>
    dplyr::mutate(dplyr::across(tidyselect::where(is.factor), forcats::fct_drop)) |>
    cwi::sub_nonanswers()

  usethis::use_data(youth_risks, overwrite = TRUE)
}
