# Maryland Climate Vulnerability Score

Tract-level values going into the state Department of the Environment's
Climate Vulnerability Score. Similar to EJSCREEN, the score scales risks
of environmental hazards based on vulnerable socio-economic populations.
The subset of data here just includes tree canopy cover, urban heat
islands, drought risk, and flood storm surge, plus the overall score
percentile.

## Usage

``` r
climate
```

## Format

A data frame with 1463 rows and 6 variables:

- geoid:

  Character. The tract FIPS code.

- tcc:

  Numeric. Tree canopy coverage as a percentage of land area that is
  tree canopy.

- drought:

  Integer. Ranking of area and intensity of drought conditions, with
  higher numbers as more severe risk.

- uhi:

  Integer. Presence of urban heat island compared to other parts of the
  same city, with higher numbers as more severe heat.

- flood_ss:

  Integer. Ranking of historical and predicted flood storm surge
  impacts, with higher numbers as higher risk.

- cvs_pctl:

  Numeric. Percentile of tract-level Climate Vulnerability Score.

## Source

Maryland iMAP Data Catalog. MD Climate Vulnerability Score, available at
[https://data.imap.maryland.gov/datasets/maryland::md-climate-vulnerability-score](https://data.imap.maryland.gov/datasets/maryland::md-climate-vulnerability-score/about).
See methodology at
<https://mde.maryland.gov/programs/air/Climate-in-md/Documents/Climate%20Vulnerability/CSNA_%C2%A7_1-702_Methodology_1.5.pdf>

## Examples

``` r
 head(climate)
#>         geoid   tcc drought uhi flood_ss cvs_pctl
#> 1 24003731103 0.667       3   1        3     7.66
#> 2 24003707001 0.624       3   2        3    17.78
#> 3 24003740800 0.497       3   1        4    44.19
#> 4 24003702402 0.588       3   1        4    25.03
#> 5 24003731303 0.694       3   1        3     8.55
#> 6 24003730603 0.589       3   1        3    22.85
```
