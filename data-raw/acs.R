year <- 2022

county_fips <- dplyr::filter(tidycensus::fips_codes, state == "MD") |>
  dplyr::select(county_code, county)

tbls <- c(cwi::basic_table_nums[c("race", "foreign_born", "tenure", "education", "median_income", "poverty", "vehicles")],
          list(housing_cost = "B25140"))
fetch <- purrr::map(tbls, cwi::multi_geo_acs, towns = NULL, state = "24", tracts = "all",
                    us = TRUE, msa = TRUE, new_england = FALSE,
                    year = year) |>
  purrr::map(cwi::label_acs, year = year) |>
  purrr::map(dplyr::filter, !grepl("Micro Area", name), !grepl(" PR ", name))

out <- list()

# race
out[["race"]] <- fetch$race |>
  # camiller::show_uniq(label) |>
  dplyr::group_by(year, level, name) |>
  camiller::add_grps(list(total_pop = 1, white = 3, black = 4, latino = 12, asian = 6, other_race = c(5, 7:9)),
                     group = label) |>
  camiller::calc_shares(group = label, digits = 2) |>
  dplyr::rename(group = label)

# immigration
out[["foreign_born"]] <- fetch$foreign_born |>
  # camiller::show_uniq(label) |>
  dplyr::group_by(year, level, name) |>
  camiller::add_grps(list(total_pop = 1, foreign_born = 5:6), group = label) |>
  camiller::calc_shares(group = label, digits = 2) |>
  dplyr::rename(group = label) |>
  dplyr::filter(group != "total_pop")

# homeownership
out[["homeownership"]] <- fetch$tenure |>
  dplyr::group_by(year, level, name) |>
  camiller::add_grps(list(total_hh = 1, homeownership = 2), group = label) |>
  camiller::calc_shares(group = label, digits = 2, denom = "total_hh") |>
  dplyr::rename(group = label)

# cost burden
out[["cost_burden"]] <- fetch$housing_cost |>
  cwi::separate_acs(into = c("tenure", "cost"), drop_total = TRUE) |>
  dplyr::filter(!is.na(tenure)) |>
  dplyr::mutate(cost = tidyr::replace_na(cost, "Total")) |>
  dplyr::group_by(year, level, name, cost = forcats::as_factor(cost)) |>
  # camiller::show_uniq(tenure) |>
  camiller::add_grps(list(total = 1:3, owner = 1:2, renter = 3), group = tenure) |>
  dplyr::group_by(year, level, name, tenure) |>
  # camiller::show_uniq(cost) |>
  camiller::add_grps(list(all_lvls = 1, cost_burden = 2, severe_cost_burden = 3), group = cost) |>
  camiller::calc_shares(group = cost, denom = "all_lvls", digits = 2) |>
  dplyr::ungroup() |>
  dplyr::mutate(group = paste(as.character(tenure), as.character(cost), sep = "_")) |>
  dplyr::select(year, level, name, group, estimate, share)


# households without vehicle
out[["vehicles"]] <- fetch$vehicles |>
  dplyr::filter(!grepl("household", label)) |>
  dplyr::group_by(year, level, name) |>
  camiller::add_grps(list(total_hh = 1, no_vehicle_hh = 2), group = label) |>
  camiller::calc_shares(group = label, denom = "total_hh", digits = 2) |>
  dplyr::rename(group = label) |>
  dplyr::filter(!is.na(share))

# median household income
out[["median_hh_income"]] <- fetch$median_income |>
  dplyr::mutate(group = "median_hh_income") |>
  dplyr::select(year, level, name, group, estimate)

# educational attainment -- 25+
out[["education"]] <- fetch$education |>
  dplyr::filter(!grepl("(B|b)orn", label)) |>
  dplyr::group_by(year, level, name) |>
  camiller::add_grps(list(ages25plus = 1, less_than_high_school = 2, high_school_grad = 3, some_college_or_aa = 4, bachelors = 5, grad_degree = 6), group = label) |>
  camiller::calc_shares(group = label, denom = "ages25plus", digits = 2) |>
  dplyr::rename(group = label)

# poverty & low-income rates
out[["poverty"]] <- fetch$poverty |>
  dplyr::group_by(year, level, name) |>
  camiller::add_grps(list(pov_status_determined = 1, poverty = 2:3, low_income = 2:7), group = label) |>
  camiller::calc_shares(group = label, denom = "pov_status_determined", digits = 2) |>
  dplyr::rename(group = label)


denoms <- c("total_pop", "total_hh", "median_hh_income", "ages25plus", "pov_status_determined")

acs <- out |>
  # purrr::map(dplyr::rename, value = dplyr::any_of("share")) |>
  dplyr::bind_rows(.id = "topic") |>
  dplyr::filter(!is.na(share) | group %in% denoms) |>
  dplyr::ungroup() |>
  tidyr::pivot_wider(id_cols = c(level, name), names_from = group, values_from = c(estimate, share), names_vary = "slowest") |>
  janitor::remove_empty("cols") |>
  dplyr::rename_with(\(x) stringr::str_remove(x, "^estimate_"), .cols = dplyr::any_of(paste("estimate", denoms, sep = "_"))) |>
  # dplyr::rename(total_pop = estimate_total_pop, total_hh = estimate_total_hh, median_hh_income = estimate_median_hh_income) |>
  dplyr::select(-dplyr::matches("estimate_")) |>
  dplyr::rename_with(\(x) stringr::str_remove(x, "share_")) |>
  dplyr::mutate(level = forcats::fct_relabel(level, stringr::str_remove, "^\\d_")) |>
  dplyr::filter(total_pop > 0) |>
  dplyr::mutate(county_code = substring(name, 3, 5)) |>
  dplyr::left_join(county_fips, by = "county_code") |>
  dplyr::select(-county_code)

# diversity index
acs$diversity_idx <- OasisR::HLoc(dplyr::select(acs, white:other_race))

acs <- acs |>
  dplyr::relocate(diversity_idx, .before = foreign_born) |>
  dplyr::relocate(county, .before = name)

usethis::use_data(acs, overwrite = TRUE)
