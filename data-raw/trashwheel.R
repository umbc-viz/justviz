# from https://www.mrtrashwheel.com/trash-interception
path <- file.path("data-raw", "files", "trashwheel.xlsx")
download.file(
    "https://docs.google.com/spreadsheets/d/1b8Lbe-z3PNb3H8nSsSjrwK2B0ReAblL2/export",
    path
)

trashwheel <- tibble::tibble(name = openxlsx::getSheetNames(path)) |>
    dplyr::filter(grepl("Wheel", name)) |>
    dplyr::mutate(
        data = purrr::map(name, \(x) {
            openxlsx::read.xlsx(path, sheet = x, startRow = 2)
        })
    ) |>
    dplyr::mutate(data = purrr::map(data, janitor::clean_names)) |>
    dplyr::mutate(
        data = purrr::map(
            data,
            dplyr::select,
            -dplyr::matches("^x\\d"),
            -homes_powered,
            -month,
            -year
        )
    ) |>
    dplyr::mutate(
        data = purrr::map(
            data,
            dplyr::mutate,
            dplyr::across(dplyr::where(is.character), readr::parse_number)
        )
    ) |>
    tidyr::unnest(data) |>
    dplyr::mutate(date = as.Date(date)) |>
    dplyr::mutate(
        name = forcats::as_factor(name) |>
            forcats::fct_relabel(stringr::str_replace, "\\bW$", "West")
    )

usethis::use_data(trashwheel, overwrite = TRUE)
