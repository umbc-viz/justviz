# Baltimore city vacant building notices per tract

This is the count all current vacant building notices issued by
Baltimore as of 2026-10-05 per tract. This is just the points version of
the vacants data, joined with the tracts shapefile and aggregated. Note
that tracts without vacants won't appear here.

## Usage

``` r
vacants_by_tract
```

## Format

A data frame with 182 rows and 2 variables:

- `geoid`:

  Character. FIPS code for the census tract

- `n_vacants`:

  Integer. Count of vacant notices per tract

## Source

Point data from Open Data Baltimore portal. Vacant Building Notices,
available at
[https://data.baltimorecity.gov/datasets/691d65a5f85640e6aaa46930bd9dc102_1](https://data.baltimorecity.gov/datasets/691d65a5f85640e6aaa46930bd9dc102_1/).
Tract boundaries from U.S. Census Bureau, TIGER boundary files via the
[`tigris`](https://github.com/walkerke/tigris/) package

## Examples

``` r
 head(vacants_by_tract)
#> # A tibble: 6 × 2
#>   geoid       n_vacants
#>   <chr>           <int>
#> 1 24510010100         5
#> 2 24510010200         5
#> 3 24510010300         2
#> 4 24510010400         3
#> 5 24510010500         2
#> 6 24510020100         2
 # date dataset was downloaded
 attr(vacants_by_tract, "last_updated")
#> [1] "2026-10-05"
```
