#' @title Demographics and socio-economic indicators from the 2022 ACS
#' @description A dataset containing indicators from the US Census Bureau's 2022 American Community Survey 5-year estimates. These are given for several geographic levels, including the US, every metropolitan statistical area (MSA) in the country, the state of Maryland, and every county and census tract in Maryland.
#' @format A data frame with `r nrow(acs)` rows and `r ncol(acs)` variables:
#' \describe{
#'   \item{level}{Factor. Geographic level (us, msa, state, county, or tract).}
#'   \item{county}{Character. Name of the county for tracts, `NA` otherwise.}
#'   \item{name}{Character. The name of the geography, including FIPS codes for tracts.}
#'   \item{total_pop}{Numeric. Total population.}
#'   \item{white}{Numeric. Share of population that is White.}
#'   \item{black}{Numeric. Share of population that is Black.}
#'   \item{latino}{Numeric. Share of population that is Latino.}
#'   \item{asian}{Numeric. Share of population that is Asian.}
#'   \item{other_race}{Numeric. Share of population that is of other race.}
#'   \item{diversity_idx}{Numeric. Diversity index based on the preceding race/ethnicity columns. Uses Theil's H entropy.}
#'   \item{foreign_born}{Numeric. Share of population that is foreign born.}
#'   \item{total_hh}{Numeric. Total households.}
#'   \item{homeownership}{Numeric. Homeownership rate.}
#'   \item{total_cost_burden}{Numeric. Share of households that are cost burdened, based on HUD's standard that housing costs should be no more than 30% of a household's total income.}
#'   \item{total_severe_cost_burden}{Numeric. Share of households that are severely cost burdened, or paying more than 50% of their income toward housing costs.}
#'   \item{owner_cost_burden}{Numeric. Share of homeowners that are cost burdened.}
#'   \item{owner_severe_cost_burden}{Numeric. Share of homeowners that are severely cost burdened.}
#'   \item{renter_cost_burden}{Numeric. Share of renters that are cost burdened.}
#'   \item{renter_severe_cost_burden}{Numeric. Share of renters that are severely cost burdened}
#'   \item{no_vehicle_hh}{Numeric. Share of households without a vehicle.}
#'   \item{median_hh_income}{Numeric. Median household income in 2022 dollars.}
#'   \item{ages25plus}{Numeric. Population aged 25 and over.}
#'   \item{less_than_high_school}{Numeric. Share of population aged 25 and over with less than a high school diploma.}
#'   \item{high_school_grad}{Numeric. Share of population aged 25 and over with a high school diploma.}
#'   \item{some_college_or_aa}{Numeric. Share of population aged 25 and over with some college or an associate degree.}
#'   \item{bachelors}{Numeric. Share of population aged 25 and over with a bachelor's degree.}
#'   \item{grad_degree}{Numeric. Share of population aged 25 and over with a graduate degree.}
#'   \item{pov_status_determined}{Numeric. Population for whom poverty status is determined.}
#'   \item{poverty}{Numeric. Poverty rate, or the share of the population for whom poverty status is determined that lives in a household with income below the federal poverty level.}
#'   \item{low_income}{Numeric. Low-income rate, or the share of the population for whom poverty status is determined that lives in a household with income below 2 times the federal poverty level.}
#'   \item{area_sqmi}{Numeric. Land area in square miles.}
#'   \item{pop_density}{Numeric. Population per square mile.}
#' }
#' @examples
#'   head(acs)
#' @source Calculated from US Census Bureau. American Community Survey 2022 5-year estimates. Calculated by Camille with the [`tidycensus`](https://github.com/walkerke/tidycensus) and [`cwi`](https://github.com/CT-Data-Haven/cwi) packages.
"acs"


#' @title Public art in Baltimore
#' @description
#' A spatial points dataset of public art in and near Baltimore city. This comes from the city's open data portal. Some projects appear to be inside of buildings and therefore not visible from the outside, but much of this metadata is incomplete. Several art projects without coordinates included, or with coordinates outside of Baltimore city, Baltimore County, and Anne Arundel County were dropped.
#' @format An sf data frame with `r nrow(art_sf)` rows and `r ncol(art_sf)` variables:
#' \describe{
#'   \item{id}{Integer. An ID, identical to the object ID in the original dataset.}
#'   \item{county}{Character. County name where art is located.}
#'   \item{artist_last_name}{Character. Last name(s) of the artist(s).}
#'   \item{artist_first_name}{Character. First name(s) of the artist(s).}
#'   \item{title}{Character. Artwork title.}
#'   \item{date}{Character. Year of artwork, including some spans of multiple years.}
#'   \item{medium}{Character. Medium of artwork.}
#'   \item{location}{Character. Name of location or address.}
#'   \item{site}{Character. Description of location where art is situated.}
#'   \item{visibility}{Character. Description of level of visibility to public. This variable is very sparsely populated.}
#'   \item{access}{Character. Description of public access. This variable is very sparsely populated.}
#'   \item{geometry}{POINT. Location.}
#' }
#' @examples
#'  head(art_sf)
#' @source Open Baltimore data portal. Public Art Inventory, available at [https://data.baltimorecity.gov/datasets/baltimore::public-art-inventory](https://data.baltimorecity.gov/datasets/baltimore::public-art-inventory)
"art_sf"


#' @title Brownfields and national priority sites
#' @description
#' A `sf` data frame of basic information on brownfields and national priority list (superfund) sites in Maryland. This is a subset of data from the Maryland Department of the Environment's (MDE) Land Restoration Program, filtered for sites that are listed as brownfields, NPL sites, or both.
#' @format An sf data frame with `r nrow(brownfields_sf)` rows and `r ncol(brownfields_sf)` variables:
#' \describe{
#'   \item{id}{Integer. An ID, identical to the object ID in the original dataset.}
#'   \item{name}{Character. Site name listed in the MDE database.}
#'   \item{address}{Character. Site address(es).}
#'   \item{city}{Character. Town name.}
#'   \item{is_ongoing_assess}{Logical, whether assessment of the site is listed as ongoing.}
#'   \item{is_ongoing_remed}{Logical, whether remediation of the site is listed as ongoing.}
#'   \item{is_archived}{Logical, whether the site is considered closed.}
#'   \item{fy_open}{Numeric. Fiscal year cleanup process was opened.}
#'   \item{fy_closed}{Numeric. Fiscal year cleanup process was closed, if applicable.}
#'   \item{site_type}{Factor. The site type (brownfield, npl, or both).}
#'   \item{geometry}{POINT. Location.}
#' }
#' @examples
#' head(brownfields_sf)
#' @source Maryland Department of the Environment Land Restoration Program, available at [https://mdewin64.mde.state.md.us/LRP/index.html](https://mdewin64.mde.state.md.us/LRP/index.html)
"brownfields_sf"


#' @title Adult health data from the CDC
#' @description A dataset containing health indicators from the CDC's PLACES project for the US, Maryland, and the state's counties and census tracts. Where tract-level data couldn't be directly measured, values are modeled. This is the most recent data from the 2023 update. The denominator for all variables is the population of adults ages 18 and older, except missing health insurance, which is based on adults ages 18 to 64.
#' @format A data frame with `r nrow(cdc)` rows and `r ncol(cdc)` variables:
#' \describe{
#'   \item{level}{Factor. The level of the data (us, state, etc.).}
#'   \item{year}{Character. The year the data was collected.}
#'   \item{location}{Character. The location where the data was collected (US, Maryland, etc.).}
#'   \item{indicator}{Character. The health indicator being measured.}
#'   \item{value}{Numeric. The rate of the corresponding population.}
#'   \item{pop}{Numeric. The adult population size for the given location and year, used as the denominator.}
#' }
#' @examples
#'  head(cdc)
#' @source Centers for Disease Control and Prevention (CDC) PLACES Project. Data portal, definitions, and methodology are available at [https://www.cdc.gov/places/](https://www.cdc.gov/places/)
"cdc"

#' @title 2022-based CPI inflation adjustment factor
#' @description A table of inflation adjustment factors for the year 1990 to 2022. This can be used to adjust dollar values for inflation into 2022 dollars, based on annual consumer price index (CPI) values from the Bureau of Labor Statistics. Match your values to `cpi` by year, then divide your values by the adjustment factor. Because these are annual averages, it won't be appropriate for more granular time periods in the past few years. This adjusts to 2022 dollars to match the `spending` dataset.
#' @format A data frame with `r nrow(cpi)` rows and `r ncol(cpi)` variables:
#' \describe{
#'  \item{year}{Numeric. Year of data.}
#'  \item{adj_factor22}{Numeric. Factor by which to adjust dollar amounts to get 2022-based dollars.}
#' }
#' @examples
#'   head(cpi)
#'
#'   # to use cpi, join it to your data and divide values by the inflation factor
#'   set.seed(1)
#'   x <- data.frame(year = 2016:2022, value = round(rnorm(7, 100, 10)))
#'   x |>
#'     dplyr::left_join(cpi, by = "year") |>
#'     dplyr::mutate(adj_value = value / adj_factor22)
#' @source Bureau of Labor Statistics Consumer Price Index for All Urban Consumers (CPI-U) series CUUR0000SA0. [https://www.bls.gov/cpi/](https://www.bls.gov/cpi/)
"cpi"


#' @title EPA environmental justice index
#' @description A dataset containing environmental health risk factors from the EPA's EJSCREEN environment justice index for census tracts in Maryland. Values are calculated based on aggregations of risk factors, then given as percentiles. Columns starting with `"d"` are adjusted for one of two different definitions of vulnerable populations. The original dataset, `ejscreen`, was mistakenly described as the national percentiles, but is actually state-level percentiles, i.e. the percentiles of values _within the state of Maryland only_. To make nationwide percentiles available without breaking any code, the nationwide percentiles are in a separate dataframe called `ej_natl`. Both datasets have the same format.
#' @format For both `ejscreen` and `ej_natl`, a data frame with `r nrow(ejscreen)` rows and `r ncol(ejscreen)` variables:
#' \describe{
#'   \item{tract}{Character. The tract FIPS code.}
#'   \item{indicator}{Factor. The environmental health risk factor, such as proximity to water treatment or air pollution-related cancers.}
#'   \item{value_ptile}{Integer. The nationwide percentile of indexed values.}
#'   \item{d2_ptile}{Integer. The percentile of indexed values scaled based on a two-factor demographic index (percent low-income and percent people of color).}
#'   \item{d5_ptile}{Integer. The percentile of indexed values scaled based on a five-factor demographic index (percent low-income, unemployment rate, percent limited English, percent without high school diploma, low life expectancy).}
#' }
#' @examples
#' head(ejscreen)
#' @source Environmental Protection Agency (EPA) EJSCREEN Environment Justice Index. Data portal, definitions, and methodology are available at [https://www.epa.gov/ejscreen/technical-information-about-ejscreen](https://www.epa.gov/ejscreen/technical-information-about-ejscreen)
"ejscreen"

#' @rdname ejscreen
"ej_natl"


#' @title EPA environmental justice index trend
#' @description A dataset containing environmental health risk factors from the EPA's EJSCREEN environment justice index for block groups in Maryland for each year from 2018 to 2023. Values are calculated based on aggregations of risk factors, then given as nationwide percentiles. The column `d2_ptile` is adjusted for the EPA's two-factor definition of vulneration populations. While different years of this data are formatted differently, all indicators subset here are consistent except for underground storage, which is only available starting in 2021. Note also that block group definitions and their GEOIDs changed with the 2020 decennial census: 2018 to 2021 use 2010 block groups, while 2022 and 2023 use 2020 block groups. If joining with shapefiles from TIGER or elsewhere, you'll need one for 2010 block groups and one for 2020.
#' @seealso ejscreen
#' @format A data frame with `r nrow(ej_trend)` rows and `r ncol(ej_trend)` variables:
#' \describe{
#'    \item{year}{Numeric. Year of data.}
#'    \item{bg}{Character. The block group FIPS code.}
#'    \item{total_pop}{Numeric. Total population of the block group that year.}
#'    \item{indicator}{Factor. The environmental health risk factor, such as proximity to water treatment or air pollution-related cancers.}
#'   \item{value_ptile}{Integer. The nationwide percentile of indexed values.}
#'   \item{d2_ptile}{Integer. The percentile of indexed values scaled based on a two-factor demographic index (percent low-income and percent people of color).}
#' }
#' @examples
#' head(ej_trend)
#' @source Environmental Protection Agency (EPA) EJSCREEN Environment Justice Index. Data portal, definitions, and methodology are available at [https://www.epa.gov/ejscreen/technical-information-about-ejscreen](https://www.epa.gov/ejscreen/technical-information-about-ejscreen)
"ej_trend"


#' @title Shapefile of highways
#' @description An `sf` object containing highways (specifically keyed as motorways or trunks) in Baltimore city and surrounding counties from OpenStreetMap.
#' @format An sf data frame with `r nrow(highways_sf)` rows and `r ncol(highways_sf)` variables:
#' \describe{
#'   \item{osm_id}{Character. The OpenStreetMap ID for the highway; can be used to retrieve more metadata.}
#'   \item{name}{Character. The name of the highway, if labeled in the OSM database.}
#'   \item{lanes}{Numeric. The number of lanes on the highway.}
#'   \item{geometry}{LINESTRING. The geometric representation of the highway.}
#' }
#' @examples
#'  head(highways_sf)
#' @source OpenStreetMap database via the [`osmdata`](https://github.com/ropensci/osmdata) package.
"highways_sf"


#' @title Shapefile of nonresidential areas
#' @description
#' An `sf` object of data from OpenStreetMap of large nonresidential areas in Maryland. There are several census tracts with very few households that coincide with industrial sites, prisons, and other nonresidential properties, and this is an attempt to identify some of them.
#' @format An sf data frame with `r nrow(nonres_sf)` rows and `r ncol(nonres_sf)` variables:
#' \describe{
#'   \item{type}{Factor. Site type: one of airport, industrial, military, prison, or protected area. These refer to the keys used to retrieve data from OSM, though some may have matched multiple keys (duplicates were removed).}
#'   \item{osm_id}{Character. The OpenStreetMap ID for the site; can be uesd to retrieve more metadata.}
#'   \item{name}{Character. The name of the site.}
#'   \item{geometry}{POLYGON. The boundaries of the site.}
#'   \item{is_low_res}{Logical. Gives whether the site intersects with a low-residential tract, defined as tracts with fewer than 500 households based on the 2022 ACS.}
#' }
#' @examples
#' head(nonres_sf)
#' @source OpenStreetMap database via the [`osmdata`](https://github.com/ropensci/osmdata) package, and American Community Survey 2022 5-year estimates via [`tidycensus`](https://github.com/walkerke/tidycensus).
"nonres_sf"


#' @title Police stops in Connecticut
#' @description A dataset containing responses to questions about unfair treatment by police from the 2021 DataHaven Community Wellbeing Survey. The data is broken down by location, category, and group, with values for adults in Connecticut, New Haven, and the Greater New Haven area.
#' @format A data frame with `r nrow(police_stops)` rows and `r ncol(police_stops)` variables:
#' \describe{
#'   \item{name}{Character. The name of the location where the data was collected.}
#'   \item{category}{Factor. Category for which data are aggregated (total, gender, or race/ethnicity).}
#'   \item{group}{Factor. The group within the given category for which data are aggregated (Total, Male, Female, White, Black, Latino).}
#'   \item{ever_unfairly_stopped}{Numeric. The share of respondents who reported having ever been unfairly stopped, harassed, or abused by police.}
#'   \item{multiple_times_3yr}{Numeric. The share of respondents who reported this treatment having happened multiple times in the past 3 years, out of the share who reported it having happened ever.}
#' }
#' @examples
#'  head(police_stops)
#' @source DataHaven Community Wellbeing Survey 2021, analyzed with Camille's packages [`cwi`](https://github.com/CT-Data-Haven/cwi) and `dcws` (not currently public). [https://ctdatahaven.org/reports/datahaven-community-wellbeing-survey](https://ctdatahaven.org/reports/datahaven-community-wellbeing-survey)
"police_stops"


#' @title Average annual consumer spending
#' @description A dataset containing mean amounts of money spent on different categories of goods each year, broken down by US household income quintile. The data comes from the US Census Bureau's annual Consumer Expenditure Survey. Dollar amounts are given for the year reported, not adjusted for inflation.
#' @format A data frame with `r nrow(spending)` rows and `r ncol(spending)` variables:
#' \describe{
#'   \item{year}{Numeric. The year of the survey.}
#'   \item{item}{Character. The category of goods.}
#'   \item{qtotal}{Numeric. The mean amount spent on the item by all households.}
#'   \item{q1}{Numeric. The mean amount spent on the item by households in the first (lowest) income quintile.}
#'   \item{q2}{Numeric. The mean amount spent on the item by households in the second income quintile.}
#'   \item{q3}{Numeric. The mean amount spent on the item by households in the third income quintile.}
#'   \item{q4}{Numeric. The mean amount spent on the item by households in the fourth income quintile.}
#'   \item{q5}{Numeric. The mean amount spent on the item by households in the fifth (highest) income quintile.}
#'   \item{l2}{Character. The second level category of the item. `NA` if not applicable.}
#'   \item{l3}{Character. The third level category of the item. `NA` if not applicable.}
#'   \item{l4}{Character. The fourth level category of the item. `NA` if not applicable.}
#'   \item{l5}{Character. The fifth level category of the item. `NA` if not applicable.}
#' }
#' @examples
#'  head(spending)
#' @source US Census Bureau's Consumer Expenditure Survey, available from the Bureau of Labor Statistics [https://www.bls.gov/cex/data.htm](https://www.bls.gov/cex/data.htm)
"spending"


#' @title Census tracts for the Baltimore area
#' @description A dataset containing 2020 census tract boundaries for Baltimore and surrounding counties. The data comes from the `tigris` package with geometries simplified.
#' @format An sf data frame with `r nrow(tracts_sf)` rows and `r ncol(tracts_sf)` variables:
#' \describe{
#'   \item{county}{Character. The name of the county where the census tract is located.}
#'   \item{geoid}{Character. The FIPS code for the census tract.}
#'   \item{geometry}{POLYGON. The geometric representation of the census tract boundary.}
#' }
#' @examples
#'  head(tracts_sf)
#' @source U.S. Census Bureau, TIGER boundary files via the [`tigris`](https://github.com/walkerke/tigris/) package
"tracts_sf"


#' @title Monthly unemployment rates
#' @description A dataset containing monthly unemployment rates from 2000 to 2023 for Maryland, Baltimore city, and all counties in the state. The data comes from the Bureau of Labor Statistics' Local Area Unemployment Statistics (LAUS).
#' @format A data frame with `r nrow(unemployment)` rows and `r ncol(unemployment)` variables:
#' \describe{
#'   \item{name}{Character. The name of the location.}
#'   \item{date}{Date. The month for which unemployment is reported.}
#'   \item{reported_rate}{Numeric. The reported unemployment rate.}
#'   \item{adjusted_rate}{Numeric. The seasonally adjusted unemployment rate.}
#' }
#' @examples
#'  head(unemployment)
#' @source U.S. Bureau of Labor Statistics, Local Area Unemployment Statistics via API with the [`cwi`](https://github.com/CT-Data-Haven/cwi) package. [https://www.bls.gov/lau/](https://www.bls.gov/lau/) Seasonal adjustment is done with the BLS' methodology via [`feasts::X_13ARIMA_SEATS`].
"unemployment"


#' @title Vacancy rates and correlated housing measures
#' @description A dataset containing vacancy rates and other values related to housing for tracts in Baltimore; Stamford, CT; and New Haven, CT. The data comes from the 2022 American Community Survey (ACS). This was updated to include all tracts in Maryland, though Maryland tracts not in Baltimore city will have `NA` in the city column.
#' @format A data frame with `r nrow(vacant)` rows and `r ncol(vacant)` variables:
#' \describe{
#'   \item{state}{Character. The state FIPS code.}
#'   \item{city}{Character. The city name.}
#'   \item{county}{Character. The 3-digit county FIPS code.}
#'   \item{county_name}{Character. Full county name.}
#'   \item{geoid}{Character. The tract FIPS code.}
#'   \item{total_units}{Numeric. The total number of housing units.}
#'   \item{vacants}{Numeric. The number of vacant housing units.}
#'   \item{med_rent}{Numeric. The median rent for renter-occupied housing units.}
#'   \item{med_housing_value}{Numeric. The median housing value for owner-occupied housing units.}
#'   \item{vacancy_rate}{Numeric. The vacancy rate.}
#'   \item{area_sqmi}{Numeric. The area in square miles.}
#'   \item{housing_density}{Numeric. The housing density (total units per square mile).}
#' }
#' @examples
#'  head(vacant)
#' @source Calculated from US Census Bureau. American Community Survey 2022 5-year estimates. Calculated by Camille with the [`tidycensus`](https://github.com/walkerke/tidycensus) and [`cwi`](https://github.com/CT-Data-Haven/cwi) packages.
"vacant"


#' @title Median wages by PUMA
#' @description A dataset containing median individual earnings by sex for all Public Use Microdata Areas (PUMAs) in the US, for adults ages 25 and up working full time with positive earnings. The data is calculated from the 2021 American Community Survey (ACS) Public Use Microdata Sample (PUMS) data via the Integrated Public Use Microdata Series (IPUMS). PUMAs are areas of at least 100,000 people.
#' @format A data frame with `r nrow(wages_by_puma)` rows and `r ncol(wages_by_puma)` variables:
#' \describe{
#'   \item{statefip}{Character. The state FIPS code.}
#'   \item{geoid}{Character. The PUMA FIPS code.}
#'   \item{sex}{Character. The sex of the individuals.}
#'   \item{count}{Numeric. The number of individuals.}
#'   \item{earn}{Numeric. The median earnings.}
#' }
#' @examples
#'  head(wages_by_puma)
#' @source U.S. Census Bureau, American Community Survey, Integrated Public Use Microdata Series [https://usa.ipums.org/usa/](https://usa.ipums.org/usa/). Analyzed using the [`srvyr`](https://github.com/gergness/srvyr) package.
"wages_by_puma"


#' @title Median wages by demographic
#' @description A dataset containing median individual earnings by various dimensions (education, occupation, etc.) for the US and Maryland, for adults ages 25 and up with positive earnings. The data is calculated from the 2021 American Community Survey (ACS) Public Use Microdata Sample (PUMS) data via the Integrated Public Use Microdata Series (IPUMS).
#' @format A data frame with `r nrow(wages)` rows and `r ncol(wages)` variables:
#' \describe{
#'   \item{dimension}{Factor. The dimension across which values are calculated.}
#'   \item{name}{Factor. The name of the region (US or Maryland).}
#'   \item{sex}{Factor. The sex of the individuals.}
#'   \item{race_eth}{Factor. The race/ethnicity of the individuals.}
#'   \item{edu}{Factor. The education level of the individuals.}
#'   \item{occ_group}{Factor. The occupation group of the individuals.}
#'   \item{univ}{Factor. Universe of workers, whether the denominator is all workers or full-time only.}
#'   \item{is_fulltime}{Logical. Whether the individual is a full-time worker. `NA` if distinction isn't included.}
#'   \item{count}{Numeric. The number of individuals in the group.}
#'   \item{earn_q20}{Numeric. The 20th percentile of earnings.}
#'   \item{earn_q25}{Numeric. The 25th percentile of earnings.}
#'   \item{earn_q50}{Numeric. The 50th percentile (median) earnings.}
#'   \item{earn_q75}{Numeric. The 75th percentile of earnings.}
#'   \item{earn_q80}{Numeric. The 80th percentile of earnings.}
#'   \item{sample_n}{Numeric. The sample size.}
#' }
#' @examples
#'  head(wages)
#' @source U.S. Census Bureau, American Community Survey, Integrated Public Use Microdata Series [https://usa.ipums.org/usa/](https://usa.ipums.org/usa/). Analyzed using the [`srvyr`](https://github.com/gergness/srvyr) package.
"wages"


#' @title 2010 to 2020 tract crosswalk
#' @description
#' The Census Bureau updates the boundaries of its geographies, such as tracts, after every decennial census. To convert values based on one year's geographies to another year's geographies, you need what's called a crosswalk, or a table of weights to use for averaging values. Unfortunately, many results of the 2020 census were delayed, so some datasets are still put out with 2010 geographies, while others have updated to 2020. The CDC Places data still uses 2010 boundaries, so if you want to merge data from `cdc` to data from any of the other tract-level datasets, you'll need to use this crosswalk. See the example below.
#' @format A data frame with `r nrow(xwalk_tract_10_to_20)` rows and `r ncol(xwalk_tract_10_to_20)` variables:
#' \describe{
#'    \item{tract20}{Character. Tract GEOID based on 2020 geographies.}
#'    \item{tract10}{Character. Tract GEOID based on 2010 geographies.}
#'    \item{weight}{Numeric. Weight to use in converting values based on 2010 geographies into ones based on 2020 geographies. Use this as the weight for weighted mean calculations.}
#' }
#' @examples
#' head(xwalk_tract_10_to_20)
#'
#' # Here's an example walkthrough of how you would prepare the CDC data to join
#' # it with another dataset---I'll use the EJSCREEN data. I'm filtering each of
#' # these for the indicators I'm interested in, which are asthma from CDC and
#' # traffic from EJSCREEN.
#'
#' library(dplyr)
#'
#' # filter cdc data for just asthma
#' asthma10 <- cdc |>
#'   filter(indicator == "Current asthma", level == "tract") |>
#'   select(tract10 = location, asthma = value, pop)
#'
#' # calculate values based on 2020 geographies:
#' # - average asthma rate is calculated as a weighted mean of rates
#' # - average adult population is calculated as a weighted sum of counts
#' # (I'm not actually using adult pop for anything, just here as an example of weighting counts)
#' asthma20 <- asthma10 |>
#'   inner_join(xwalk_tract_10_to_20, by = "tract10") |>
#'   group_by(tract20) |>
#'   summarise(asthma = weighted.mean(asthma, weight),
#'             adult_pop = sum(pop * weight))
#'
#' # filter ejscreen for just traffic, rename value column accordingly
#' traffic <- ejscreen |>
#'   filter(indicator == "traffic") |>
#'   select(tract20 = tract, traffic_value_ptile = value_ptile)
#'
#' # join both data frames now that they have geographies in common
#' traffic |>
#'   inner_join(asthma20, by = "tract20")
#' @source Block-to-block crosswalk from IPUMS NHGIS, University of Minnesota, www.nhgis.org.
"xwalk_tract_10_to_20"


#' @title Predictions of youth risks in Connecticut
#' @description A dataset containing Likert-style responses to questions about different outcomes for youth in their area, from the 2021 DataHaven Community Wellbeing Survey. The data is broken down by category, group, and response with values for adults in Connecticut.
#' @format A data frame with `r nrow(youth_risks)` rows and `r ncol(youth_risks)` variables:
#' \describe{
#'   \item{code}{Character. The code for the question.}
#'   \item{question}{Character. The question about the predicted outcome for youth.}
#'   \item{category}{Factor. The category of the respondent (e.g., total, gender).}
#'   \item{group}{Factor. The group of the respondent (e.g., Connecticut, male, female).}
#'   \item{response}{Factor. The response to the question (almost certain, very likely, a toss up, not very likely, or not at all likely).}
#'   \item{value}{Numeric. The share of respondents giving the response.}
#' }
#' @examples
#'  head(youth_risks)
#' @source DataHaven Community Wellbeing Survey 2021, analyzed with Camille's packages [`cwi`](https://github.com/CT-Data-Haven/cwi) and `dcws` (not currently public). [https://ctdatahaven.org/reports/datahaven-community-wellbeing-survey](https://ctdatahaven.org/reports/datahaven-community-wellbeing-survey)
"youth_risks"
