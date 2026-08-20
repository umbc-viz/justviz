# Public art in Baltimore

A spatial points dataset of public art in and near Baltimore city. This
comes from the city's open data portal. Some projects appear to be
inside of buildings and therefore not visible from the outside, but much
of this metadata is incomplete. Several art projects without coordinates
included, or with coordinates outside of Baltimore city, Baltimore
County, and Anne Arundel County were dropped.

## Usage

``` r
art_sf
```

## Format

An sf data frame with 672 rows and 12 variables:

- id:

  Integer. An ID, identical to the object ID in the original dataset.

- county:

  Character. County name where art is located.

- artist_last_name:

  Character. Last name(s) of the artist(s).

- artist_first_name:

  Character. First name(s) of the artist(s).

- title:

  Character. Artwork title.

- date:

  Character. Year of artwork, including some spans of multiple years.

- medium:

  Character. Medium of artwork.

- location:

  Character. Name of location or address.

- site:

  Character. Description of location where art is situated.

- visibility:

  Character. Description of level of visibility to public. This variable
  is very sparsely populated.

- access:

  Character. Description of public access. This variable is very
  sparsely populated.

- geometry:

  POINT. Location.

## Source

Open Baltimore data portal. Public Art Inventory, available at
<https://data.baltimorecity.gov/datasets/baltimore::public-art-inventory>

## Examples

``` r
 head(art_sf)
#>   id         county artist_last_name artist_first_name   title date
#> 1  1 Baltimore city          Streett            Tylden   Sails 1978
#> 2  2 Baltimore city           Russum              Olin Unknown 1969
#> 3  3 Baltimore city           Benson         J. Arthur Unknown 1973
#> 4  5 Baltimore city       McCullough             Donna    <NA> 1989
#> 5  6 Baltimore city        Alexander          Patricia Unknown <NA>
#> 6  7 Baltimore city           Farber              Saul Unknown 1980
#>                      medium                 location                 site
#> 1                    copper             Patterson HS  Second story window
#> 2              ceramic tree              Callaway ES            Stairwell
#> 3 concrete and corten steel              Westport ES           Playground
#> 4                     mural      141 S. Central Ave.                 <NA>
#> 5             ceramic tiles Lexington Market Station Covers ceiling beams
#> 6             stained glass          Broadway Market               Window
#>   visibility access            geometry
#> 1       <NA>   <NA> -76.59190, 39.28823
#> 2       <NA>   <NA> -76.68362, 39.34557
#> 3       <NA>   <NA> -76.63833, 39.26211
#> 4       <NA>   <NA> -76.59947, 39.28932
#> 5       <NA>   <NA> -76.62102, 39.29191
#> 6       <NA>   <NA> -76.59190, 39.28823
```
