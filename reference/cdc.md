# Adult health data from the CDC

A dataset containing health indicators from the CDC's PLACES project for
the US, Maryland, and the state's counties and census tracts. Where
tract-level data couldn't be directly measured, values are modeled. This
is the most recent data from the 2025 update. The denominator for all
variables is the population of adults ages 18 and older, except missing
health insurance, which is based on adults ages 18 to 64.

## Usage

``` r
cdc
```

## Format

A data frame with 14840 rows and 6 variables:

- level:

  Factor. The level of the data (us, state, etc.).

- year:

  Character. The year the data was collected.

- location:

  Character. The location where the data was collected (US, Maryland,
  etc.).

- indicator:

  Character. The health indicator being measured.

- value:

  Numeric. The rate of the corresponding population.

- pop:

  Numeric. The adult population size for the given location and year,
  used as the denominator.

## Source

Centers for Disease Control and Prevention (CDC) PLACES Project. Data
portal, definitions, and methodology are available at
<https://www.cdc.gov/places/>

## Examples

``` r
 head(cdc)
#> # A tibble: 6 × 6
#>   level year  location indicator                     value       pop
#>   <fct> <chr> <chr>    <chr>                         <dbl>     <dbl>
#> 1 us    2023  US       Health insurance               11   334914895
#> 2 us    2023  US       Cancer (non-skin) or melanoma   7.9 334914895
#> 3 us    2023  US       Frequent mental distress       15.6 334914895
#> 4 us    2022  US       Dental visit                   63.9 334914895
#> 5 us    2023  US       Diabetes                       12   334914895
#> 6 us    2023  US       Current asthma                  9.8 334914895
```
