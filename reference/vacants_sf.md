# Baltimore city vacant building notices, points

These are all current vacant building notices issued by Baltimore as of
2026-10-05 as individual points.

## Usage

``` r
vacants_sf
```

## Format

An sf data frame with 11481 rows and 4 variables:

- `objectid`:

  Integer. Unique ID

- `date_notice`:

  Date. The date the notice was posted.

- `blocklot`:

  Character. Block lot number within the city.

- `geometry`:

  POINT. Spatial location of the building for which the notice was
  posted. This uses the same CRS as the tracts shapefile so you can do a
  spatial join without reprojecting.

## Source

Open Data Baltimore portal. Vacant Building Notices, available at
[https://data.baltimorecity.gov/datasets/691d65a5f85640e6aaa46930bd9dc102_1](https://data.baltimorecity.gov/datasets/691d65a5f85640e6aaa46930bd9dc102_1/)

## Examples

``` r
 head(vacants_sf)
#> Simple feature collection with 6 features and 3 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: -76.64943 ymin: 39.28084 xmax: -76.64783 ymax: 39.28135
#> Geodetic CRS:  NAD83
#>   objectid date_notice blocklot                   geometry
#> 1        7  2026-05-28 0702 050 POINT (-76.64943 39.28084)
#> 2        9  2010-07-17 0702 052 POINT (-76.64934 39.28087)
#> 3       13  2008-06-26 0702 056 POINT (-76.64916 39.28093)
#> 4       15  2024-02-01 0703 002 POINT (-76.64783 39.28135)
#> 5       19  2021-11-05 0703 005 POINT (-76.64797 39.28131)
#> 6       24  2008-01-25 0703 010 POINT (-76.64819 39.28123)
 # date dataset was downloaded
 attr(vacants_sf, "last_updated")
#> [1] "2026-10-05"
```
