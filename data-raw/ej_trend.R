# open connection with duckdb database
con <- DBI::dbConnect(duckdb::duckdb(), file.path("data-raw", "files", "ej_trend.duckdb"), read_only = TRUE)

# get table names
ids <- DBI::dbGetQuery(con, "SELECT table_name FROM information_schema.tables;") |>
  tibble::deframe() |>
  rlang::set_names()

# for each table, extract vector of column names
# underwater storage tanks (ust) not in every year; cancer spelled differently
queries <- ids |>
  purrr::map(function(id) {
    query <- stringr::str_glue(
      "SELECT column_name
      FROM information_schema.columns
      WHERE table_name = '{id}';"
    )
    all_cols <- DBI::dbGetQuery(con, query) |>
      tibble::deframe()

    ptiles <- stringr::str_subset(all_cols, "^P_") |>
      stringr::str_subset("(PCT|B\\d|P\\d)$", negate = TRUE) |>
      stringr::str_subset("_D(5|6)", negate = TRUE) |>
      stringr::str_subset("DEMOG", negate = TRUE) |>
      stringr::str_subset("(PM25|OZONE|DSLPM|CANCE?R|RESP|PTRAF|LDPNT|PNPL|PRMP|PTSDF|UST|PWDIS)") |>
      stringi::stri_encode(to = "UTF-8") |>
      paste(collapse = ", ")
    query2 <- stringr::str_glue("
      SELECT ID, ACSTOTPOP, {ptiles}
      FROM {id};
    ")
    query2
  })

DBI::dbDisconnect(con)

# can't figure out why something in the files' bad encoding is crashing DBI, but can use duckdb directly
# also R isn't using login shell so need full path to duckdb since it's installed with brew
# also very cool that column types change every year---depending on year, same column can be int, double, or varchar
dfs <- purrr::imap(queries, function(q, id) {
  fn <- tempfile()
  result <- sys::exec_internal(
    "/home/linuxbrew/.linuxbrew/bin/duckdb",
    c("-csv", "-readonly", "-c", q, "data-raw/files/ej_trend.duckdb")
  )
  # returns binary results in stdout; convert to character vector and read as csv
  sys::as_text(result$stdout) |>
    I() |>
    readr::read_csv(col_types = readr::cols(.default = "c"))
})

# still need to clean up names
ej_trend <- dfs |>
  purrr::map(function(df) {
    df |>
      # dplyr::rename_with(\(x) stringr::str_replace_all(x, "RSEI_AIR", "RSEIAIR")) |>
      dplyr::rename_with(\(x) stringr::str_replace_all(x, "(P)_(D\\d)_([A-Z0-9]+)", "\\1_\\3_\\2")) |>
      dplyr::rename_with(\(x) stringr::str_replace_all(x, "CANCR", "CANCER"))
  }) |>
  dplyr::bind_rows(.id = "table") |>
  janitor::clean_names() |>
  tidyr::pivot_longer(
    cols = -table:-acstotpop,
    names_to = c(NA, "indicator", "type"), names_sep = "_",
    values_to = "ptile"
  ) |>
  dplyr::mutate(type = tidyr::replace_na(type, "value")) |>
  dplyr::mutate(indicator = forcats::fct_recode(indicator,
    diesel = "dslpm", air_cancer = "cancer", air_respiratory = "resp",
    releases_to_air = "rseiair", traffic = "ptraf", superfund = "pnpl",
    risk_mgmt_plan = "prmp", haz_waste = "ptsdf", undergrnd_storage = "ust",
    wastewater = "pwdis", lead_paint = "ldpnt"
  )) |>
  dplyr::mutate(ptile = readr::parse_number(ptile) |> round()) |>
  dplyr::mutate(acstotpop = readr::parse_number(acstotpop)) |>
  dplyr::filter(!is.na(ptile)) |>
  tidyr::pivot_wider(
    id_cols = table:indicator,
    names_from = type, values_from = ptile,
    names_glue = "{type}_{.value}"
  ) |>
  dplyr::mutate(year = stringr::str_extract(table, "\\d{4}") |> as.numeric()) |>
  dplyr::select(year, bg = id, total_pop = acstotpop, everything(), -table) |>
  dplyr::as_tibble()

usethis::use_data(ej_trend, overwrite = TRUE)
