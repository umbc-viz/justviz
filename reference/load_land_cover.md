# Load land cover raster data

This is a helper function to load one of two types of raster data for
the Baltimore area. Both are land cover data from the National Land
Cover Database (NLCD) obtained with ROpenSci's `FedData` package. The
"canopy" data is the percentage of each pixel that is covered by tree
canopy, for vegetation-related land cover types. The "impervious" data
is the percentage of each pixel that is considered an impervious
surface, for urban developed land cover types. Both files originally
were downloaded as 30m x 30m rasters with values ranging from 1 to 255
and `NA` at pixels of other land cover types. Both were then downsampled
to 90m x 90m, scaled to percentages, and `NA` values were replaced with
0.

## Usage

``` r
load_land_cover(type = c("canopy", "impervious"))
```

## Source

<https://www.mrlc.gov/data/legends/national-land-cover-database-class-legend-and-description>

## Arguments

- type:

  String, type of land cover raster to return. Either "canopy" or
  "impervious".

## Value

A raster of class
[`terra::SpatRaster`](https://rspatial.github.io/terra/reference/SpatRaster-class.html)
with 1 band.

## See also

[`FedData::get_nlcd`](https://docs.ropensci.org/FedData/reference/get_nlcd.html)

## Examples

``` r
canopy <- load_land_cover("canopy")
canopy
#> class       : SpatRaster
#> size        : 1393, 1052, 1  (nrow, ncol, nlyr)
#> resolution  : 90, 90  (x, y)
#> extent      : 1587735, 1682415, 1902705, 2028075  (xmin, xmax, ymin, ymax)
#> coord. ref. : NAD83 / Conus Albers (EPSG:5070)
#> source(s)   : memory
#> varname     : canopy
#> name        : mrlc_download__nlcd_tcc_conus_2021_v2021-4
#> min value   :                                          0
#> max value   :                                          1
if (FALSE) { # \dontrun{
  if (interactive()) {
    terra::plot(canopy)
  }
} # }
```
