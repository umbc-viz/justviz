# download spreadsheets from BLS---series finder is a pain but so is this
# bls is blocking everything so download from site
cx_wbs <- list.files(file.path("data-raw", "files", "cx"), full.names = TRUE) |>
  rlang::set_names(stringr::str_extract, "\\d{4}") |>
  purrr::map(openxlsx::loadWorkbook)

# only need to get indentations once---2019 not actually formatted this way, so just use 2022
cx_read <- openxlsx::read.xlsx(cx_wbs[["2022"]], sheet = 1, startRow = 1, colNames = FALSE, skipEmptyRows = FALSE)
indents <- purrr::map_dfr(cx_wbs[["2022"]]$styleObjects, function(x) {
  indent <- x$style$indent
  if (is.null(indent)) {
    indent <- NA_real_
  } else {
    indent <- as.numeric(indent)
  }
  cols <- x$cols
  rows <- x$rows
  tibble::tibble(indent = indent, row = rows, col = cols)
}, .id = "id") |>
  dplyr::filter(col == 1)

hdrs <- cx_read |>
  tibble::as_tibble() |>
  tibble::rowid_to_column("row") |>
  dplyr::inner_join(indents, by = "row") |>
  dplyr::slice(-1:-53) |>
  dplyr::filter(!X1 %in% c("Mean", "SE", "RSE", "Share")) |>
  # dplyr::mutate(lvl1 = is.na(dplyr::lag(X1))) |>
  dplyr::filter(!is.na(X1)) |>
  dplyr::mutate(indent = tidyr::replace_na(indent, 0)) |>
  dplyr::filter(indent != 1) |> # footnotes
  dplyr::mutate(lvl = dplyr::dense_rank(indent)) |>
  # def a better way to do this
  dplyr::mutate(l1 = ifelse(lvl == 1, X1, NA_character_),
                l2 = ifelse(lvl == 2, X1, NA_character_),
                l3 = ifelse(lvl == 3, X1, NA_character_),
                l4 = ifelse(lvl == 4, X1, NA_character_),
                l5 = ifelse(lvl == 5, X1, NA_character_)) |>
  dplyr::select(row, X1, dplyr::matches("^l\\d$")) |>
  tidyr::fill(l1, .direction = "down") |>
  dplyr::group_by(l1) |>
  tidyr::fill(l2, .direction = "down") |>
  dplyr::group_by(l1, l2) |>
  tidyr::fill(l3, .direction = "down") |>
  dplyr::group_by(l1, l2, l3) |>
  tidyr::fill(l4, .direction = "down") |>
  dplyr::ungroup() |>
  dplyr::filter(l1 == "Average annual expenditures") |>
  dplyr::select(-l1)

spending <- cx_wbs |>
  purrr::map(openxlsx::read.xlsx, sheet = 1, startRow = 3) |>
  dplyr::bind_rows(.id = "year") |>
  dplyr::mutate(Item = stringr::str_replace(Item, "out\\-of\\-town", "out of town")) |>
  dplyr::group_by(year) |>
  camiller::filter_until(grepl("^Sources of income .+", Item)) |>
  dplyr::slice(-1:-39) |>
  dplyr::filter(!Item %in% c("SE", "RSE", "Share", "CV(%)")) |>
  tidyr::fill(-year:-Item, .direction = "up") |>
  dplyr::inner_join(hdrs, by = c("Item" = "X1")) |>
  dplyr::ungroup() |>
  janitor::clean_names() |>
  dplyr::rename(qtotal = all_consumer_units, q1 = 4, q2 = 5, q3 = 6, q4 = 7, q5 = 8) |>
  dplyr::select(-row) |>
  dplyr::mutate(dplyr::across(c(year, qtotal:q5), readr::parse_number))

usethis::use_data(spending, overwrite = TRUE)
# individual l2 values sum up to total spending, give or take a couple dollars
