# uses cwi package which needs BLS API key
# with dummy dataset to get ratios
dummy <- data.frame(year = 1990:2022, value = 100)
cpi <- cwi::adj_inflation(dummy, value = value, year = year, base_year = 2022)
cpi <- dplyr::select(cpi, year, adj_factor22 = adj_factor)

usethis::use_data(cpi, overwrite = TRUE)
