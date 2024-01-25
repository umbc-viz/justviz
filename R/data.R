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
#' }
#' @source US Census Bureau. American Community Survey 2022 5-year estimates. Calculated by Camille with the [`tidycensus`] and [`cwi`] packages.
"acs"


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
#' @source Centers for Disease Control and Prevention (CDC) PLACES Project. Data portal, definitions, and methodology are available at [https://www.cdc.gov/places/](https://www.cdc.gov/places/)
"cdc"


#' @title EPA environmental justice index
#' @description A dataset containing environmental health risk factors from the EPA's EJSCREEN environment justice index for census tracts in Maryland. Values are calculated based on aggregations of risk factors, then given as nationwide percentiles. Columns starting with `"d"` are adjusted for one of two different definitions of vulnerable populations.
#' @format A data frame with `r nrow(ejscreen)` rows and `r ncol(ejscreen)` variables:
#' \describe{
#'   \item{tract}{Character. The tract FIPS code.}
#'   \item{indicator}{Factor. The environmental health risk factor, such as proximity to water treatment or air pollution-related cancers.}
#'   \item{value_ptile}{Integer. The nationwide percentile of indexed values.}
#'   \item{d2_ptile}{Integer. The percentile of indexed values scaled based on a two-factor demographic index (percent low-income and percent people of color).}
#'   \item{d5_ptile}{Integer. The percentile of indexed values scaled based on a five-factor demographic index (percent low-income, unemployment rate, percent limited English, percent without high school diploma, low life expectancy).}
#' }
#' @source Environmental Protection Agency (EPA) EJSCREEN Environment Justice Index. Data portal, definitions, and methodology are available at [https://www.epa.gov/ejscreen/technical-information-about-ejscreen](https://www.epa.gov/ejscreen/technical-information-about-ejscreen)
"ejscreen"


#' @title Shapefile of highways
#' @description An `sf` object containing highways (specifically keyed as motorways or trunks) in Baltimore city and surrounding counties from OpenStreetMap.
#' @format An sf data frame with `r nrow(highways_sf)` rows and `r ncol(highways_sf)` variables:
#' \describe{
#'   \item{osm_id}{Character. The OpenStreetMap ID for the highway; can be used to retrieve more metadata.}
#'   \item{name}{Character. The name of the highway, if labeled in the OSM database.}
#'   \item{lanes}{Numeric. The number of lanes on the highway.}
#'   \item{geometry}{LINESTRING. The geometric representation of the highway.}
#' }
#' @source OpenStreetMap database via the [`osmdata`] package.
"highways_sf"


#' @title Police stops in Connecticut
#' @description A dataset containing responses to questions about unfair treatment by police from the 2021 DataHaven Community Wellbeing Survey. The data is broken down by location, category, and group, with values for adults in Connecticut, New Haven, and the Greater New Haven area.
#' @format A data frame with `r nrow(police_stops)` rows and `r ncol(police_stops)` variables:
#' \describe{
#'   \item{name}{Character. The name of the location where the data was collected.}
#'   \item{category}{Factor. Category for which data are aggregated (total, gender, or race/ethnicity).}
#'   \item{group}{Factor. The group within the given category for which data are aggregated (Total, Male, Female, White, Black, Latino).}
#'   \item{ever_unfairly_stopped}{Numeric. The share of respondents who reported having ever been unfairly stopped, harassed, or abused by police.}
#'   \item{multiple_times_3yr}{Numeric. The share of respondents who reported this treatment having happened multiple times in the past 3 years.}
#' }
#' @source DataHaven Community Wellbeing Survey 2021, analyzed with Camille's packages [`cwi`] and [`dcws`]. [https://ctdatahaven.org/reports/datahaven-community-wellbeing-survey](https://ctdatahaven.org/reports/datahaven-community-wellbeing-survey)
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
#' @source U.S. Census Bureau, TIGER boundary files via the [`tigris`] package
"tracts_sf"


#' @title Monthly unemployment rates
#' @description A dataset containing monthly unemployment rates from 2000 to 2023 for Maryland, Baltimore city, and surrounding counties. The data comes from the Bureau of Labor Statistics' Local Area Unemployment Statistics (LAUS).
#' @format A data frame with `r nrow(unemployment)` rows and `r ncol(unemployment)` variables:
#' \describe{
#'   \item{name}{Character. The name of the location.}
#'   \item{date}{Date. The month for which unemployment is reported.}
#'   \item{reported_rate}{Numeric. The reported unemployment rate.}
#'   \item{adjusted_rate}{Numeric. The seasonally adjusted unemployment rate.}
#' }
#' @source U.S. Bureau of Labor Statistics, Local Area Unemployment Statistics via API with the [`cwi`] package. [https://www.bls.gov/lau/](https://www.bls.gov/lau/) Seasonal adjustment is done with the BLS' methodology using the [`feasts`] package.
"unemployment"


#' @title Vacancy rates and correlated housing measures
#' @description A dataset containing vacancy rates and other values related to housing for tracts in Baltimore; Stamford, CT; and New Haven, CT. The data comes from the 2022 American Community Survey (ACS).
#' @format A data frame with `r nrow(vacant)` rows and `r ncol(vacant)` variables:
#' \describe{
#'   \item{state}{Character. The state FIPS code.}
#'   \item{city}{Character. The city name.}
#'   \item{county}{Character. The 3-digit county FIPS code.}
#'   \item{geoid}{Character. The tract FIPS code.}
#'   \item{total_units}{Numeric. The total number of housing units.}
#'   \item{vacants}{Numeric. The number of vacant housing units.}
#'   \item{med_rent}{Numeric. The median rent for renter-occupied housing units.}
#'   \item{med_housing_value}{Numeric. The median housing value for owner-occupied housing units.}
#'   \item{vacancy_rate}{Numeric. The vacancy rate.}
#'   \item{area_sqmi}{Numeric. The area in square miles.}
#'   \item{housing_density}{Numeric. The housing density (total units per square mile).}
#' }
#' @source US Census Bureau. American Community Survey 2022 5-year estimates. Calculated by Camille with the [`tidycensus`] and [`cwi`] packages.
"vacant"


#' @title Median wages by PUMA
#' @description A dataset containing median individual earnings by sex for all Public Use Microdata Areas (PUMAs) in the US, for adults ages 25 and up working full time with positive earnings. The data is calculated from the 2022 American Community Survey (ACS) Public Use Microdata Sample (PUMS) data via the Integrated Public Use Microdata Series (IPUMS). PUMAs are areas of at least 100,000 people.
#' @format A data frame with `r nrow(wages_by_puma)` rows and `r ncol(wages_by_puma)` variables:
#' \describe{
#'   \item{statefip}{Character. The state FIPS code.}
#'   \item{geoid}{Character. The PUMA FIPS code.}
#'   \item{sex}{Character. The sex of the individuals.}
#'   \item{count}{Numeric. The number of individuals.}
#'   \item{earn}{Numeric. The median earnings.}
#' }
#' @source U.S. Census Bureau, American Community Survey, Integrated Public Use Microdata Series [https://usa.ipums.org/usa/](https://usa.ipums.org/usa/). Analyzed using the [`srvyr`] package.
"wages_by_puma"


#' @title Median wages by demographic
#' @description A dataset containing median individual earnings by various dimensions (education, occupation, etc.) for the US and Maryland, for adults ages 25 and up with positive earnings. The data is calculated from the 2022 American Community Survey (ACS) Public Use Microdata Sample (PUMS) data via the Integrated Public Use Microdata Series (IPUMS).
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
#' @source U.S. Census Bureau, American Community Survey, Integrated Public Use Microdata Series [https://usa.ipums.org/usa/](https://usa.ipums.org/usa/). Analyzed using the [`srvyr`] package.
"wages"


#' @title Predictions of youth risks in Connecticut
#' @description A dataset containing Likert-style responses to questions about different outcomes for youth in their area, from the 2021 DataHaven Community Wellbeing Survey. The data is broken down by category, group, and response with values for adults in Connecticut.
#' @format A data frame with `nrow(youth_risks)` rows and `ncol(youth_risks)` variables:
#' \describe{
#'   \item{code}{Character. The code for the question.}
#'   \item{question}{Character. The question about the predicted outcome for youth.}
#'   \item{category}{Factor. The category of the respondent (e.g., total, gender).}
#'   \item{group}{Factor. The group of the respondent (e.g., Connecticut, male, female).}
#'   \item{response}{Factor. The response to the question (almost certain, very likely, a toss up, not very likely, or not at all likely).}
#'   \item{value}{Numeric. The share of respondents giving the response.}
#' }
#' @source DataHaven Community Wellbeing Survey 2021, analyzed with Camille's packages [`cwi`] and [`dcws`]. [https://ctdatahaven.org/reports/datahaven-community-wellbeing-survey](https://ctdatahaven.org/reports/datahaven-community-wellbeing-survey)
"youth_risks"
