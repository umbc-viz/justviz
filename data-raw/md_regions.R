# based on state tourism site, https://www.visitmaryland.org/article/maryland-regions
# if it doesn't end in "city", tack on "County"
regs <- list(
    "Western Maryland" = c("Garrett", "Allegany", "Washington"),
    "Capitol Region" = c("Frederick", "Montgomery", "Prince George's"),
    "Central Maryland" = c(
        "Anne Arundel",
        "Baltimore city",
        "Baltimore",
        "Carroll",
        "Harford",
        "Howard"
    ),
    "Southern Maryland" = c("Calvert", "Charles", "St. Mary's"),
    "Eastern Shore" = c(
        "Kent",
        "Queen Anne's",
        "Talbot",
        "Caroline",
        "Dorchester",
        "Wicomico",
        "Somerset",
        "Worcester",
        "Cecil"
    )
) |>
    purrr::map(\(x) ifelse(grepl(" city$", x), x, paste(x, "County")))

md_regions <- tibble::enframe(regs, name = "region", value = "county") |>
    tidyr::unnest(county) |>
    dplyr::arrange(region, county)

usethis::use_data(md_regions, overwrite = TRUE)
