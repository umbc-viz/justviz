# Median wages by demographic

A dataset containing median individual earnings by various dimensions
(sex, race, education, etc.) for Maryland, for adults ages 25 and up
with positive earnings. The data is calculated from the 2024 American
Community Survey (ACS) Public Use Microdata Sample (PUMS) data via the
Integrated Public Use Microdata Series (IPUMS).

## Usage

``` r
wages
```

## Format

A data frame with 59 rows and 12 variables:

- dimension:

  Factor. The dimension across which values are calculated.

- status:

  Factor. Worker status: all workers, full-time workers, or part-time
  workers. Some groups are only available for full-time workers.

- sex:

  Factor. The sex of the individuals.

- race_eth:

  Factor. The race/ethnicity of the individuals.

- edu:

  Factor. The education level of the individuals.

- count:

  Numeric. The estimated number of individuals in the group.

- sample_n:

  Numeric. The sample size used for estimates.

- earn_q20:

  Numeric. The 20th percentile of earnings.

- earn_q25:

  Numeric. The 25th percentile of earnings.

- earn_q50:

  Numeric. The 50th percentile (median) earnings.

- earn_q75:

  Numeric. The 75th percentile of earnings.

- earn_q80:

  Numeric. The 80th percentile of earnings.

## Source

U.S. Census Bureau, American Community Survey, Integrated Public Use
Microdata Series <https://usa.ipums.org/usa/>. Analyzed using the
[`srvyr`](https://github.com/gergness/srvyr) package.

## Examples

``` r
 head(wages)
#> # A tibble: 6 × 12
#>   dimension status      sex   race_eth edu     count sample_n earn_q20 earn_q25
#>   <fct>     <fct>       <fct> <fct>    <fct>   <dbl>    <int>    <dbl>    <dbl>
#> 1 total     all_workers total total    total 2892611   135999    30881    36436
#> 2 total     part_time   total total    total  632931    30715     9716    12005
#> 3 total     full_time   total total    total 2259680   105284    42874    48582
#> 4 by_sex    all_workers men   total    total 1487580    68775    36000    41295
#> 5 by_sex    all_workers women total    total 1405031    67224    26796    32155
#> 6 by_sex    part_time   men   total    total  264368    12389    10294    12860
#> # ℹ 3 more variables: earn_q50 <dbl>, earn_q75 <dbl>, earn_q80 <dbl>
```
