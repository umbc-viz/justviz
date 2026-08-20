# Demographics and socio-economic indicators from the 2024 ACS

A dataset containing indicators from the US Census Bureau's 2024
American Community Survey 5-year estimates. These are given for several
geographic levels, including the US, the state of Maryland, and every
county and census tract in Maryland.

## Usage

``` r
acs
```

## Format

A data frame with 1486 rows and 41 variables:

- level:

  Factor. Geographic level (us, state, county, or tract).

- county:

  Character. Name of the county for tracts, `NA` otherwise.

- name:

  Character. The name of the geography, including FIPS codes for tracts.

- total_pop:

  Numeric. Total population.

- ages00_17:

  Numeric. Share of population ages 0-17.

- ages18_34:

  Numeric. Share of population ages 18-34.

- ages35_64:

  Numeric. Share of population ages 35-64.

- ages65plus:

  Numeric. Share of population ages 65 and over.

- white:

  Numeric. Share of population that is white.

- black:

  Numeric. Share of population that is Black.

- latino:

  Numeric. Share of population that is Latino.

- asian:

  Numeric. Share of population that is Asian.

- other_race:

  Numeric. Share of population that is of other race.

- diversity_idx:

  Numeric. Diversity index based on the preceding race/ethnicity
  columns. Uses Theil's H entropy.

- foreign_born:

  Numeric. Share of population that is foreign born.

- total_hh:

  Numeric. Total households.

- homeownership:

  Numeric. Homeownership rate.

- total_cost_burden:

  Numeric. Share of households that are cost burdened, based on HUD's
  standard that housing costs should be no more than 30% of a
  household's total income.

- total_severe_cost_burden:

  Numeric. Share of households that are severely cost burdened, or
  paying more than 50% of their income toward housing costs.

- owner_cost_burden:

  Numeric. Share of homeowners that are cost burdened.

- owner_severe_cost_burden:

  Numeric. Share of homeowners that are severely cost burdened.

- renter_cost_burden:

  Numeric. Share of renters that are cost burdened.

- renter_severe_cost_burden:

  Numeric. Share of renters that are severely cost burdened

- no_vehicle_hh:

  Numeric. Share of households without a vehicle.

- median_hh_income:

  Numeric. Median household income in 2024 dollars.

- ages25plus:

  Numeric. Population aged 25 and over.

- less_than_high_school:

  Numeric. Share of population aged 25 and over with less than a high
  school diploma.

- high_school_grad:

  Numeric. Share of population aged 25 and over with a high school
  diploma.

- some_college_or_aa:

  Numeric. Share of population aged 25 and over with some college or an
  associate degree.

- bachelors:

  Numeric. Share of population aged 25 and over with a bachelor's
  degree.

- grad_degree:

  Numeric. Share of population aged 25 and over with a graduate degree.

- pov_status_determined:

  Numeric. Population for whom poverty status is determined.

- poverty:

  Numeric. Poverty rate, or the share of the population for whom poverty
  status is determined that lives in a household with income below the
  federal poverty level.

- low_income:

  Numeric. Low-income rate, or the share of the population for whom
  poverty status is determined that lives in a household with income
  below 2 times the federal poverty level.

- total_housing_units:

  Numeric. Number of housing units, including vacants.

- total_vacant_units:

  Numeric. Share of housing units that are vacant for whatever reason.

- units_for_rent:

  Numeric. Share of housing units that are vacant and for rent.

- units_for_sale:

  Numeric. Share of housing units that are vacant and for sale.

- seasonal_units:

  Numeric. Share of housing units that are empty and for seasonal use.

- area_sqmi:

  Numeric. Land area in square miles.

- pop_density:

  Numeric. Population per square mile.

## Source

Calculated from US Census Bureau. American Community Survey 2024 5-year
estimates. Calculated by Camille with the
[`tidycensus`](https://github.com/walkerke/tidycensus) and
[`cwi`](https://github.com/CT-Data-Haven/cwi) packages.

## Examples

``` r
  head(acs)
#> # A tibble: 6 × 41
#>   level  county name    total_pop ages00_17 ages18_34 ages35_64 ages65plus white
#>   <fct>  <chr>  <chr>       <dbl>     <dbl>     <dbl>     <dbl>      <dbl> <dbl>
#> 1 us     NA     United… 334922499      0.22      0.23      0.38       0.17  0.57
#> 2 state  NA     Maryla…   6206011      0.22      0.22      0.39       0.17  0.47
#> 3 county NA     Allega…     67452      0.18      0.24      0.37       0.21  0.86
#> 4 county NA     Anne A…    598166      0.22      0.22      0.4        0.16  0.62
#> 5 county NA     Baltim…    850796      0.22      0.22      0.38       0.18  0.51
#> 6 county NA     Baltim…    573243      0.21      0.27      0.37       0.15  0.26
#> # ℹ 32 more variables: black <dbl>, latino <dbl>, asian <dbl>,
#> #   other_race <dbl>, diversity_idx <dbl>, foreign_born <dbl>, total_hh <dbl>,
#> #   homeownership <dbl>, total_cost_burden <dbl>,
#> #   total_severe_cost_burden <dbl>, owner_cost_burden <dbl>,
#> #   owner_severe_cost_burden <dbl>, renter_cost_burden <dbl>,
#> #   renter_severe_cost_burden <dbl>, no_vehicle_hh <dbl>,
#> #   median_hh_income <dbl>, ages25plus <dbl>, less_than_high_school <dbl>, …
```
