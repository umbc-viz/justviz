# Round a set of numbers so they'll add up to 100

This function takes a vector of numbers and rounds them to coerce them
to add up to 100. It works best for numbers with several decimal places
that are close to adding to 100. It's definitely not fool-proof, but can
help with situations like waffle charts where previous rounding may make
numbers not add up to exactly 100.

## Usage

``` r
round_sum100(x, digits = 0, verbose = FALSE)
```

## Arguments

- x:

  A numeric vector

- digits:

  Number of digits to use for rounding; you probably don't need to
  change this. Default: 0

- verbose:

  Logical; if `TRUE`, will print the sum, letting you confirm whether
  the numbers do indeed add to 100. Defaults `FALSE`.

## Value

A numeric vector that hopefully adds up to 100.

## Examples

``` r
round_sum100(c(9.2124, 40.292, 50.2), 0) # yay
#> [1]  9 41 50
round_sum100(c(0.24, 0.61, 0.15) * 100) # yay
#> [1] 24 61 15
round_sum100(c(0.24, 0.6, 0.15) * 100) # sad
#> [1] 24 60 15
```
