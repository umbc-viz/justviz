# crosswalk from NHGIS modeled for converting 2010 data to 2020 geographies
# it's block level, so extract tract part of FIPS codes to make tract xwalk
# https://data2.nhgis.org/crosswalks/nhgis_blk2010_blk2020_ge_state/nhgis_blk2010_blk2020_ge_24.zip
xwalk_tract_10_to_20 <- readr::read_csv(file.path("data-raw", "files", "nhgis_blk2010_blk2020_ge_24.csv"),
                       col_types = "ccnn") |>
  janitor::clean_names() |>
  dplyr::mutate(dplyr::across(geoid10:geoid20, list(tract = \(x) substr(x, 1, 11)), .names = "{fn}_{col}")) |>
  dplyr::rename_with(\(x) stringr::str_remove(x, "_geoid")) |>
  dplyr::arrange(tract10, tract20) |>
  dplyr::group_by(tract20, tract10) |>
  dplyr::summarise(wt_total = sum(weight)) |>
  dplyr::mutate(weight = wt_total / sum(wt_total)) |>
  dplyr::select(-wt_total) |>
  dplyr::ungroup()

usethis::use_data(xwalk_tract_10_to_20, overwrite = TRUE)




asthma10 <- cdc |>
  dplyr::filter(indicator == "Current asthma", level == "tract")
