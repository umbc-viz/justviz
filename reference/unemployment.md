# Monthly unemployment rates

A dataset containing monthly unemployment rates from 2000 to 2025 for
Maryland, Baltimore city, and all counties in the state. The data comes
from the Bureau of Labor Statistics' Local Area Unemployment Statistics
(LAUS).

## Usage

``` r
unemployment
```

## Format

A data frame with 7800 rows and 3 variables:

- name:

  Character. The name of the location.

- date:

  Date. The month for which unemployment is reported.

- rate:

  Numeric. The reported unemployment rate.

## Source

U.S. Bureau of Labor Statistics, Local Area Unemployment Statistics via
API with the [`cwi`](https://github.com/CT-Data-Haven/cwi) package.
<https://www.bls.gov/lau/>

## Examples

``` r
 head(unemployment)
#> # A tibble: 6 × 3
#>   name                date        rate
#>   <chr>               <date>     <dbl>
#> 1 Maryland            2000-01-01 0.036
#> 2 Allegany County     2000-01-01 0.068
#> 3 Anne Arundel County 2000-01-01 0.031
#> 4 Baltimore County    2000-01-01 0.036
#> 5 Calvert County      2000-01-01 0.031
#> 6 Caroline County     2000-01-01 0.037
```
