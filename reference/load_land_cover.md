# Load land cover raster data

This is a helper function to load landcover raster data for the
Baltimore area. From the National Land Cover Database (NLCD) obtained
with ROpenSci's `FedData` package.

## Usage

``` r
load_land_cover()
```

## Source

<https://www.mrlc.gov/data/legends/national-land-cover-database-class-legend-and-description>

## Value

A raster of class
[`terra::SpatRaster`](https://rspatial.github.io/terra/reference/SpatRaster-class.html)
with 1 band.

## See also

[`FedData::get_nlcd`](https://docs.ropensci.org/FedData/reference/get_nlcd.html)

## Examples

``` r
landcover <- load_land_cover()
landcover
#> class       : SpatRaster
#> size        : 4214, 3273, 1  (nrow, ncol, nlyr)
#> resolution  : 30, 30  (x, y)
#> extent      : 1587750, 1685940, 1902390, 2028810  (xmin, xmax, ymin, ymax)
#> coord. ref. : NAD83 / Conus Albers (EPSG:5070)
#> source      : landcover.tif
#> color table : 1
#> categories  : Class, Color, Description
#> name        :                        Class
#> min value   :                   Open Water
#> max value   : Emergent Herbaceous Wetlands
if (FALSE) { # \dontrun{
  if (interactive()) {
    terra::plot(landcover)
  }
} # }
```
