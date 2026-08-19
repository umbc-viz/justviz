# copied from prep for DataHaven's community index
# create extract of IPUMS data, wait while it's prepared, then download
# need separate script to do analysis
dir_out <- file.path("data-raw", "files")
year <- 2024

extract_desc <- stringr::str_glue(
    "Batch extract of {year} ACS related to wages for MD"
)
sample <- stringr::str_glue("us{year}c")

vars <- c(
    "YEAR",
    "MULTYEAR",
    "SAMPLE",
    "SERIAL",
    "CBSERIAL",
    "CLUSTER",
    "STATEFIP",
    "PUMA",
    "STRATA",
    "GQ",
    "PERNUM",
    "PERWT",
    "RELATE",
    "AGE",
    "SEX",
    "RACE",
    "HISPAN",
    "EDUC",
    "LABFORCE",
    "OCC",
    "WKSWORK2",
    "INCTOT",
    "INCWAGE",
    "INCEARN",
    "UHRSWORK"
)

history <- ipumsr::get_extract_history("usa", how_many = 50) |>
    # purrr::map(\(x) x[c("description", "number", "status", "samples", "variables", "download_links")]) |>
    purrr::map_dfr(function(x) {
        df <- tibble::as_tibble(x[c(
            "description",
            "number",
            "status",
            "collection"
        )])
        df$samples <- list(names(x[["samples"]]))
        df$variables <- list(names(x[["variables"]]))
        df$has_links <- length(x[["download_links"]]) > 0
        df$obj <- list(x)
        df
    }) |>
    dplyr::filter(description == extract_desc) |>
    dplyr::slice_max(number)

if (nrow(history) == 0) {
    # rerun
    state <- ipumsr::var_spec("STATEFIP", case_selections = "24")
    variables <- rlang::set_names(vars) |>
        purrr::map(ipumsr::var_spec)
    variables[["STATEFIP"]] <- state
    ipumsr::define_extract_micro(
        collection = "usa",
        description = extract_desc,
        samples = sample,
        variables = variables
    ) |>
        ipumsr::submit_extract() |>
        ipumsr::wait_for_extract() |>
        ipumsr::download_extract(download_dir = dir_out)
} else {
    # otherwise just download
    num <- sprintf("%05d", history$number)
    fn <- stringr::str_glue("{history$collection}_{num}.xml")
    path <- file.path(dir_out, fn)
    id <- paste(history$collection, history$number, sep = ":")

    if (file.exists(path)) {
        path
    } else if (history$has_links) {
        ipumsr::download_extract(id, download_dir = dir_out)
    } else {
        # resubmit, then download
        ipumsr::get_extract_info(id) |>
            ipumsr::submit_extract() |>
            ipumsr::wait_for_extract() |>
            ipumsr::download_extract(download_dir = dir_out)
    }
}

# rename files so they don't have extract number
file.rename(
    file.path(dir_out, sprintf("usa_%05d.dat.gz", max(history$number))),
    file.path(dir_out, "usa_ipums_wages.dat.gz")
)
file.rename(
    file.path(dir_out, sprintf("usa_%05d.xml", max(history$number))),
    file.path(dir_out, "usa_ipums_wages.xml")
)
