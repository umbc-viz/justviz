# Maryland counties by region

A lookup table of each county's region within the state.

## Usage

``` r
md_regions
```

## Format

A data frame with 24 rows and 2 variables:

- region:

  Character. One of 5 regions in Maryland: Capitol Region, Central
  Maryland, Eastern Shore, Southern Maryland, and Western Maryland.

- county:

  Character. County name.

## Source

Maryland Office of Tourism,
<https://www.visitmaryland.org/article/maryland-regions>

## Examples

``` r
head(md_regions)
#> # A tibble: 6 × 2
#>   region           county                
#>   <chr>            <chr>                 
#> 1 Capitol Region   Frederick County      
#> 2 Capitol Region   Montgomery County     
#> 3 Capitol Region   Prince George's County
#> 4 Central Maryland Anne Arundel County   
#> 5 Central Maryland Baltimore County      
#> 6 Central Maryland Baltimore city        
```
