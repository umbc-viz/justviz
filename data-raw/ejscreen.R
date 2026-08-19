# dataverse has lots of files in repo, some data, some metadata
# need to find most recent tracts and get their download IDs
base_url <- "https://dataverse.harvard.edu/api"
meta <- httr2::request(base_url) |>
    httr2::req_url_path_append(
        "datasets/export?exporter=dataverse_json&persistentId=doi%3A10.7910/DVN/RLR5AX"
    ) |>
    httr2::req_perform() |>
    httr2::resp_body_json()

str(meta, max.level = 1)
# out of slightly weird json, need ID of most recent file
# formatting leads to lots of dupes
id <- meta$datasetVersion$files |>
    purrr::map(tibble::as_tibble) |>
    dplyr::bind_rows() |>
    dplyr::filter(grepl("EJScreen_.+_Tract_with_AS_CNMI_GU_VI.csv", label)) |>
    dplyr::mutate(
        year = stringr::str_extract(label, "\\d{4}") |> as.numeric()
    ) |>
    dplyr::slice_max(year) |>
    dplyr::pull(dataFile) |>
    purrr::pluck("id") |>
    unique()

data_url <- httr2::request(base_url) |>
    httr2::req_url_path_append("access/datafile", id)

# 86k x 230, not too much to hold in ram
ej_read <- readr::read_csv(data_url$url) |>
    dplyr::filter(ST_ABBREV == "MD")


ej_natl <- ej_read |>
    janitor::clean_names() |>
    dplyr::select(
        geoid = id,
        pop = acstotpop,
        dplyr::matches("^p_"),
        -dplyr::matches(
            "(demog|peop|lowinc|unemp|disability|lingis|lesshs|under5|over64|lifeexp)"
        )
    ) |>
    tidyr::pivot_longer(
        -geoid:-pop,
        names_to = c(".value", "indicator"),
        names_pattern = "^(p(?:_d\\d)?)_(\\w+)$",
        names_ptypes = list(indicator = factor())
    ) |>
    dplyr::filter(
        !is.na(p_d2),
        !is.na(pop),
        pop > 0
    ) |>
    dplyr::select(-p_d5) |>
    tidyr::pivot_longer(
        -geoid:-indicator,
        names_to = c(NA, "type"),
        names_pattern = "^(p)_?(d\\d)?",
        values_to = "ptile"
    ) |>
    dplyr::mutate(
        type = forcats::as_factor(type) |>
            forcats::fct_recode(unadjusted = "", adjusted = "d2")
    ) |>
    dplyr::mutate(
        indicator = forcats::fct_recode(
            indicator,
            diesel = "dslpm",
            lead_paint_exposure = "ldpnt",
            superfund = "pnpl",
            risk_mgmt = "prmp",
            haz_waste = "ptsdf",
            wastewater = "pwdis",
            traffic = "ptraf",
            underground_storage = "ust",
            drinking_water = "dwater",
            toxic_air_release = "rsei_air"
        )
    ) |>
    tidyr::pivot_wider(
        id_cols = c(geoid, pop, indicator),
        names_from = type,
        values_from = ptile,
        names_glue = "{type}_{.value}"
    )

usethis::use_data(ej_natl, overwrite = TRUE)
