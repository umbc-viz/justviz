#' @title Demographics and socio-economic indicators from the 2024 ACS
#' @description A dataset containing indicators from the US Census Bureau's 2024 American Community Survey 5-year estimates. These are given for several geographic levels, including the US, the state of Maryland, and every county and census tract in Maryland.
#' @format A data frame with `r nrow(acs)` rows and `r ncol(acs)` variables:
#' \describe{
#'   \item{level}{Factor. Geographic level (us, state, county, or tract).}
#'   \item{county}{Character. Name of the county for tracts, `NA` otherwise.}
#'   \item{name}{Character. The name of the geography, including FIPS codes for tracts.}
#'   \item{total_pop}{Numeric. Total population.}
#'   \item{ages00_17}{Numeric. Share of population ages 0-17.}
#'   \item{ages18_34}{Numeric. Share of population ages 18-34.}
#'   \item{ages35_64}{Numeric. Share of population ages 35-64.}
#'   \item{ages65plus}{Numeric. Share of population ages 65 and over.}
#'   \item{white}{Numeric. Share of population that is white.}
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
#'   \item{median_hh_income}{Numeric. Median household income in 2024 dollars.}
#'   \item{ages25plus}{Numeric. Population aged 25 and over.}
#'   \item{less_than_high_school}{Numeric. Share of population aged 25 and over with less than a high school diploma.}
#'   \item{high_school_grad}{Numeric. Share of population aged 25 and over with a high school diploma.}
#'   \item{some_college_or_aa}{Numeric. Share of population aged 25 and over with some college or an associate degree.}
#'   \item{bachelors}{Numeric. Share of population aged 25 and over with a bachelor's degree.}
#'   \item{grad_degree}{Numeric. Share of population aged 25 and over with a graduate degree.}
#'   \item{pov_status_determined}{Numeric. Population for whom poverty status is determined.}
#'   \item{poverty}{Numeric. Poverty rate, or the share of the population for whom poverty status is determined that lives in a household with income below the federal poverty level.}
#'   \item{low_income}{Numeric. Low-income rate, or the share of the population for whom poverty status is determined that lives in a household with income below 2 times the federal poverty level.}
#'   \item{total_housing_units}{Numeric. Number of housing units, including vacants.}
#'   \item{total_vacant_units}{Numeric. Share of housing units that are vacant for whatever reason.}
#'   \item{units_for_rent}{Numeric. Share of housing units that are vacant and for rent.}
#'   \item{units_for_sale}{Numeric. Share of housing units that are vacant and for sale.}
#'   \item{seasonal_units}{Numeric. Share of housing units that are empty and for seasonal use.}
#'   \item{area_sqmi}{Numeric. Land area in square miles.}
#'   \item{pop_density}{Numeric. Population per square mile.}
#' }
#' @examples
#'   head(acs)
#' @source Calculated from US Census Bureau. American Community Survey 2024 5-year estimates. Calculated by Camille with the [`tidycensus`](https://github.com/walkerke/tidycensus) and [`cwi`](https://github.com/CT-Data-Haven/cwi) packages.
#' @keywords ref-datasets
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
#' @keywords ref-datasets
"art_sf"


# #' @title Brownfields and national priority sites
# #' @description
# #' **Needs to be updated but state ArcGIS server is down**
# #' A `sf` data frame of basic information on brownfields and national priority list (superfund) sites in Maryland. This is a subset of data from the Maryland Department of the Environment's (MDE) Land Restoration Program, filtered for sites that are listed as brownfields, NPL sites, or both.
# #' @format An sf data frame with `r nrow(brownfields_sf)` rows and `r ncol(brownfields_sf)` variables:
# #' \describe{
# #'   \item{id}{Integer. An ID, identical to the object ID in the original dataset.}
# #'   \item{name}{Character. Site name listed in the MDE database.}
# #'   \item{address}{Character. Site address(es).}
# #'   \item{city}{Character. Town name.}
# #'   \item{is_ongoing_assess}{Logical, whether assessment of the site is listed as ongoing.}
# #'   \item{is_ongoing_remed}{Logical, whether remediation of the site is listed as ongoing.}
# #'   \item{is_archived}{Logical, whether the site is considered closed.}
# #'   \item{fy_open}{Numeric. Fiscal year cleanup process was opened.}
# #'   \item{fy_closed}{Numeric. Fiscal year cleanup process was closed, if applicable.}
# #'   \item{site_type}{Factor. The site type (brownfield, npl, or both).}
# #'   \item{geometry}{POINT. Location.}
# #' }
# #' @examples
# #'  head(brownfields_sf)
# #' @source Maryland Department of the Environment Land Restoration Program, available at [https://mdewin64.mde.state.md.us/LRP/index.html](https://mdewin64.mde.state.md.us/LRP/index.html)
# "brownfields_sf"

#' @title Adult health data from the CDC
#' @description A dataset containing health indicators from the CDC's PLACES project for the US, Maryland, and the state's counties and census tracts. Where tract-level data couldn't be directly measured, values are modeled. This is the most recent data from the 2025 update. The denominator for all variables is the population of adults ages 18 and older, except missing health insurance, which is based on adults ages 18 to 64.
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
#' @keywords ref-datasets
"cdc"


#' @title EPA environmental justice index
#' @description A dataset containing environmental health risk factors from the EPA's EJSCREEN environment justice index for census tracts in Maryland. Values are calculated based on aggregations of risk factors, then given as percentiles compared to all tracts across the US. Columns starting with `"d"` are adjusted for one of two different definitions of vulnerable populations.
#' @format A data frame with `r nrow(ej_natl)` rows and `r ncol(ej_natl)` variables:
#' \describe{
#'   \item{tract}{Character. The tract FIPS code.}
#'   \item{indicator}{Factor. The environmental health risk factor, such as proximity to water treatment or air pollution-related cancers.}
#'   \item{value_ptile}{Integer. The nationwide percentile of indexed values.}
#'   \item{d2_ptile}{Integer. The percentile of indexed values scaled based on a two-factor demographic index (percent low-income and percent people of color).}
#'   \item{d5_ptile}{Integer. The percentile of indexed values scaled based on a five-factor demographic index (percent low-income, unemployment rate, percent limited English, percent without high school diploma, low life expectancy).}
#' }
#' @examples
#' head(ej_natl)
#' @source Environmental Protection Agency (EPA) EJSCREEN Environment Justice Index. ~~Data portal, definitions, and methodology are available at [https://www.epa.gov/ejscreen/technical-information-about-ejscreen](https://www.epa.gov/ejscreen/technical-information-about-ejscreen)~~ Removed in early 2025 from EPA servers by DOGE, but many people and organizations host backup copies. For this package, the data comes from an archive at Harvard Dataverse. EPA. (2024). Environmental justice mapping and screening tool (EJScreen) (Version 4.0) \[Dataset\]. Harvard Dataverse. https://doi.org/10.7910/DVN/RLR5AX
#' @seealso [EJSCREEN technical docs](https://dataverse.harvard.edu/file.xhtml?fileId=10775982&version=4.0)
#' @rdname ej_natl
#' @keywords ref-datasets
"ej_natl"


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
#' @keywords ref-datasets
"highways_sf"


#' @title Average annual consumer spending, 2024
#' @description A dataset containing mean amounts of money spent on different categories of goods each year, broken down by US household income quintile. The data comes from the US Census Bureau's annual Consumer Expenditure Survey. Dollar amounts are given for the year reported, not adjusted for inflation.
#' @format A data frame with `r nrow(spending)` rows and `r ncol(spending)` variables:
#' \describe{
#'   \item{item}{Character. The category of goods.}
#'   \item{l2}{Character. The second level category of the item. `NA` if not applicable.}
#'   \item{l3}{Character. The third level category of the item. `NA` if not applicable.}
#'   \item{l4}{Character. The fourth level category of the item. `NA` if not applicable.}
#'   \item{l5}{Character. The fifth level category of the item. `NA` if not applicable.}
#'   \item{qtotal}{Numeric. The mean amount spent on the item by all households.}
#'   \item{q1}{Numeric. The mean amount spent on the item by households in the first (lowest) income quintile.}
#'   \item{q2}{Numeric. The mean amount spent on the item by households in the second income quintile.}
#'   \item{q3}{Numeric. The mean amount spent on the item by households in the third income quintile.}
#'   \item{q4}{Numeric. The mean amount spent on the item by households in the fourth income quintile.}
#'   \item{q5}{Numeric. The mean amount spent on the item by households in the fifth (highest) income quintile.}
#' }
#' @examples
#'  head(spending)
#' @source US Census Bureau's Consumer Expenditure Survey, available from the Bureau of Labor Statistics [https://www.bls.gov/cex/data.htm](https://www.bls.gov/cex/data.htm)
#' @keywords ref-datasets
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
#' @keywords ref-datasets
"tracts_sf"


#' @title Collection of trash by Mr. Trash Wheel and friends
#' @description
#' Amounts of trash collected by each of the 4 trash wheels in Baltimore's harbor, marked by date. Includes total weight and volume, then estimates of counts of items by type. Values may be `NA` if counts of an item were not available for a trash wheel.
#' @format A data frame with `r nrow(trashwheel)` rows and `r ncol(trashwheel)` variables:
#' \describe{
#'   \item{name}{Factor. Name of trash wheel.}
#'   \item{dumpster}{Numeric. Dumpster number within the trash wheel.}
#'   \item{date}{Date of counting.}
#'   \item{weight_tons}{Numeric. Total weight of trash collected in tons.}
#'   \item{volume_cubic_yards}{Numeric. Total volume of trash collected in cubic yards.}
#'   \item{plastic_bottles}{Numeric. Estimated number of plastic bottles collected.}
#'   \item{polystyrene}{Numeric. Estimated number of pieces of polystyrene collected.}
#'   \item{cigarette_butts}{Numeric. Estimated number of cigarette butts collected.}
#'   \item{glass_bottles}{Numeric. Estimated number of glass bottles collected.}
#'   \item{plastic_bags}{Numeric. Estimated number of plastic bags collected.}
#'   \item{wrappers}{Numeric. Estimated number of wrappers collected.}
#'   \item{sports_balls}{Numeric. Estimated number of sports balls collected.}
#' }
#' @examples
#'   head(trashwheel)
#' @source Waterfront Partnership of Baltimore. (2026). Trash Interception. Mr. Trash Wheel. https://www.mrtrashwheel.com/trash-interception
#' @keywords ref-datasets
"trashwheel"

#' @title Monthly unemployment rates
#' @description A dataset containing monthly unemployment rates from 2000 to 2025 for Maryland, Baltimore city, and all counties in the state. The data comes from the Bureau of Labor Statistics' Local Area Unemployment Statistics (LAUS).
#' @format A data frame with `r nrow(unemployment)` rows and `r ncol(unemployment)` variables:
#' \describe{
#'   \item{name}{Character. The name of the location.}
#'   \item{date}{Date. The month for which unemployment is reported.}
#'   \item{rate}{Numeric. The reported unemployment rate.}
#' }
#' @examples
#'  head(unemployment)
#' @source U.S. Bureau of Labor Statistics, Local Area Unemployment Statistics via API with the [`cwi`](https://github.com/CT-Data-Haven/cwi) package. [https://www.bls.gov/lau/](https://www.bls.gov/lau/)
#' @keywords ref-datasets
"unemployment"


#' @title Median wages by demographic
#' @description A dataset containing median individual earnings by various dimensions (sex, race, education, etc.) for Maryland, for adults ages 25 and up with positive earnings. The data is calculated from the 2024 American Community Survey (ACS) Public Use Microdata Sample (PUMS) data via the Integrated Public Use Microdata Series (IPUMS).
#' @format A data frame with `r nrow(wages)` rows and `r ncol(wages)` variables:
#' \describe{
#'   \item{dimension}{Factor. The dimension across which values are calculated.}
#'   \item{status}{Factor. Worker status: all workers, full-time workers, or part-time workers. Some groups are only available for full-time workers.}
#'   \item{sex}{Factor. The sex of the individuals.}
#'   \item{race_eth}{Factor. The race/ethnicity of the individuals.}
#'   \item{edu}{Factor. The education level of the individuals.}
#'   \item{count}{Numeric. The estimated number of individuals in the group.}
#'   \item{sample_n}{Numeric. The sample size used for estimates.}
#'   \item{earn_q20}{Numeric. The 20th percentile of earnings.}
#'   \item{earn_q25}{Numeric. The 25th percentile of earnings.}
#'   \item{earn_q50}{Numeric. The 50th percentile (median) earnings.}
#'   \item{earn_q75}{Numeric. The 75th percentile of earnings.}
#'   \item{earn_q80}{Numeric. The 80th percentile of earnings.}
#' }
#' @examples
#'  head(wages)
#' @source U.S. Census Bureau, American Community Survey, Integrated Public Use Microdata Series [https://usa.ipums.org/usa/](https://usa.ipums.org/usa/). Analyzed using the [`srvyr`](https://github.com/gergness/srvyr) package.
#' @keywords ref-datasets
"wages"
