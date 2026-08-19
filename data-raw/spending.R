# download spreadsheets from BLS---series finder is a pain but so is this
# bls is blocking everything so download from site
cx_wbs <- list.files(file.path("data-raw", "files", "cx"), full.names = TRUE) |>
    rlang::set_names(stringr::str_extract, "\\d{4}") |>
    purrr::map(openxlsx::loadWorkbook)

# formatting sucks, just using 2024
yr <- "2024"
cx_read <- openxlsx::read.xlsx(
    cx_wbs[[yr]],
    sheet = 1,
    startRow = 1,
    colNames = FALSE,
    skipEmptyRows = FALSE,
    na.strings = c("NA", "n.a.")
)
indents <- purrr::map_dfr(
    cx_wbs[[yr]]$styleObjects,
    function(x) {
        indent <- x$style$indent
        if (is.null(indent)) {
            indent <- NA_real_
        } else {
            indent <- as.numeric(indent)
        }
        cols <- x$cols
        rows <- x$rows
        tibble::tibble(indent = indent, row = rows, col = cols)
    },
    .id = "id"
) |>
    dplyr::filter(col == 1)

hdrs <- cx_read |>
    tibble::as_tibble() |>
    tibble::rowid_to_column("row") |>
    dplyr::inner_join(indents, by = "row") |>
    # keep rows after expenditures start
    dplyr::mutate(
        is_top_meta = cumsum(grepl("Average annual expenditures", X1)) < 1
    ) |>
    # keep rows before income
    dplyr::mutate(
        is_bottom_meta = cumsum(grepl("Sources of pretax income", X1)) >= 1
    ) |>
    dplyr::filter(!is_top_meta & !is_bottom_meta) |>
    dplyr::filter(!X1 %in% c("Mean", "SE", "RSE", "Share")) |>
    dplyr::filter(!is.na(X1)) |>
    dplyr::mutate(indent = tidyr::replace_na(indent, 0)) |>
    dplyr::filter(indent != 1) |> # footnotes
    dplyr::mutate(lvl = dplyr::dense_rank(indent)) |>
    # def a better way to do this
    dplyr::mutate(
        l1 = ifelse(lvl == 1, X1, NA_character_),
        l2 = ifelse(lvl == 2, X1, NA_character_),
        l3 = ifelse(lvl == 3, X1, NA_character_),
        l4 = ifelse(lvl == 4, X1, NA_character_),
        l5 = ifelse(lvl == 5, X1, NA_character_)
    ) |>
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

spending <- openxlsx::read.xlsx(cx_wbs[[yr]], sheet = 1, startRow = 3) |>
    tibble::as_tibble() |>
    dplyr::mutate(
        Item = stringr::str_replace(Item, "out\\-of\\-town", "out of town")
    ) |>
    # keep rows after expenditures start
    dplyr::mutate(
        is_top_meta = cumsum(grepl("Average annual expenditures", Item)) < 1
    ) |>
    # keep rows before income
    dplyr::mutate(
        is_bottom_meta = cumsum(grepl("Sources of pretax income", Item)) >= 1
    ) |>
    dplyr::filter(!is_top_meta & !is_bottom_meta) |>
    dplyr::select(-is_top_meta, -is_bottom_meta) |>
    dplyr::filter(Item %notin% c("SE", "RSE", "Share", "CV(%)")) |>
    tidyr::fill(-Item, .direction = "up") |>
    dplyr::inner_join(hdrs, by = c("Item" = "X1")) |>
    janitor::clean_names() |>
    dplyr::rename(
        qtotal = all_consumer_units,
        q1 = lowest_20_percent,
        q2 = second_20_percent,
        q3 = third_20_percent,
        q4 = fourth_20_percent,
        q5 = highest_20_percent
    ) |>
    dplyr::select(-row) |>
    dplyr::mutate(dplyr::across(c(qtotal:q5), readr::parse_number)) |>
    dplyr::relocate(item, dplyr::matches("^l\\d")) |>
    dplyr::mutate(dplyr::across(item:l5, forcats::as_factor))

usethis::use_data(spending, overwrite = TRUE)
# individual l2 values sum up to total spending, give or take a couple dollars
