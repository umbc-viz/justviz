# Census tracts for the Baltimore area

A dataset containing 2020 census tract boundaries for Baltimore and
surrounding counties. The data comes from the `tigris` package with
geometries simplified.

## Usage

``` r
tracts_sf
```

## Format

An sf data frame with 606 rows and 3 variables:

- county:

  Character. The name of the county where the census tract is located.

- geoid:

  Character. The FIPS code for the census tract.

- geometry:

  POLYGON. The geometric representation of the census tract boundary.

## Source

U.S. Census Bureau, TIGER boundary files via the
[`tigris`](https://github.com/walkerke/tigris/) package

## Examples

``` r
 head(tracts_sf)
#> Simple feature collection with 6 features and 2 fields
#> Geometry type: POLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -76.90842 ymin: 39.18808 xmax: -76.55189 ymax: 39.36854
#> Geodetic CRS:  NAD83
#>           county       geoid                       geometry
#> 1  Howard County 24027605601 POLYGON ((-76.90501 39.2135...
#> 2  Howard County 24027602305 POLYGON ((-76.85329 39.2790...
#> 3 Baltimore city 24510151200 POLYGON ((-76.65636 39.3365...
#> 4 Baltimore city 24510270702 POLYGON ((-76.57356 39.3685...
#> 5 Baltimore city 24510120201 POLYGON ((-76.60948 39.3309...
#> 6 Baltimore city 24510200701 POLYGON ((-76.68942 39.2935...
```
