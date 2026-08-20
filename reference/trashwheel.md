# Collection of trash by Mr. Trash Wheel and friends

Amounts of trash collected by each of the 4 trash wheels in Baltimore's
harbor, marked by date. Includes total weight and volume, then estimates
of counts of items by type. Values may be `NA` if counts of an item were
not available for a trash wheel.

## Usage

``` r
trashwheel
```

## Format

A data frame with 1313 rows and 12 variables:

- name:

  Factor. Name of trash wheel.

- dumpster:

  Numeric. Dumpster number within the trash wheel.

- date:

  Date of counting.

- weight_tons:

  Numeric. Total weight of trash collected in tons.

- volume_cubic_yards:

  Numeric. Total volume of trash collected in cubic yards.

- plastic_bottles:

  Numeric. Estimated number of plastic bottles collected.

- polystyrene:

  Numeric. Estimated number of pieces of polystyrene collected.

- cigarette_butts:

  Numeric. Estimated number of cigarette butts collected.

- glass_bottles:

  Numeric. Estimated number of glass bottles collected.

- plastic_bags:

  Numeric. Estimated number of plastic bags collected.

- wrappers:

  Numeric. Estimated number of wrappers collected.

- sports_balls:

  Numeric. Estimated number of sports balls collected.

## Source

Waterfront Partnership of Baltimore. (2026). Trash Interception. Mr.
Trash Wheel. https://www.mrtrashwheel.com/trash-interception

## Examples

``` r
  head(trashwheel)
#> # A tibble: 6 × 12
#>   name        dumpster date       weight_tons volume_cubic_yards plastic_bottles
#>   <fct>          <dbl> <date>           <dbl>              <dbl>           <dbl>
#> 1 Mr. Trash …        1 2014-05-16        4.31                 18            1450
#> 2 Mr. Trash …        2 2014-05-16        2.74                 13            1120
#> 3 Mr. Trash …        3 2014-05-16        3.45                 15            2450
#> 4 Mr. Trash …        4 2014-05-17        3.1                  15            2380
#> 5 Mr. Trash …        5 2014-05-17        4.06                 18             980
#> 6 Mr. Trash …        6 2014-05-20        2.71                 13            1430
#> # ℹ 6 more variables: polystyrene <dbl>, cigarette_butts <dbl>,
#> #   glass_bottles <dbl>, plastic_bags <dbl>, wrappers <dbl>, sports_balls <dbl>
```
