# Average annual consumer spending, 2024

A dataset containing mean amounts of money spent on different categories
of goods each year, broken down by US household income quintile. The
data comes from the US Census Bureau's annual Consumer Expenditure
Survey. Dollar amounts are given for the year reported, not adjusted for
inflation.

## Usage

``` r
spending
```

## Format

A data frame with 101 rows and 11 variables:

- item:

  Character. The category of goods.

- l2:

  Character. The second level category of the item. `NA` if not
  applicable.

- l3:

  Character. The third level category of the item. `NA` if not
  applicable.

- l4:

  Character. The fourth level category of the item. `NA` if not
  applicable.

- l5:

  Character. The fifth level category of the item. `NA` if not
  applicable.

- qtotal:

  Numeric. The mean amount spent on the item by all households.

- q1:

  Numeric. The mean amount spent on the item by households in the first
  (lowest) income quintile.

- q2:

  Numeric. The mean amount spent on the item by households in the second
  income quintile.

- q3:

  Numeric. The mean amount spent on the item by households in the third
  income quintile.

- q4:

  Numeric. The mean amount spent on the item by households in the fourth
  income quintile.

- q5:

  Numeric. The mean amount spent on the item by households in the fifth
  (highest) income quintile.

## Source

US Census Bureau's Consumer Expenditure Survey, available from the
Bureau of Labor Statistics <https://www.bls.gov/cex/data.htm>

## Examples

``` r
 head(spending)
#> # A tibble: 6 × 11
#>   item             l2    l3    l4    l5    qtotal    q1    q2    q3    q4     q5
#>   <fct>            <fct> <fct> <fct> <fct>  <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl>
#> 1 Average annual … NA    NA    NA    NA     78535 35046 50054 66900 89972 150342
#> 2 Food             Food  NA    NA    NA     10169  5498  7400  9097 11845  16989
#> 3 Food at home     Food  Food… NA    NA      6224  3843  4952  5820  7162   9336
#> 4 Cereals and bak… Food  Food… Cere… NA       779   501   626   740   860   1166
#> 5 Cereals and cer… Food  Food… Cere… Cere…    240   156   191   223   270    359
#> 6 Bakery products  Food  Food… Cere… Bake…    539   345   435   517   589    807
```
