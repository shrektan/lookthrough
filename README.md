
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lookthrough

[![CRAN
status](https://www.r-pkg.org/badges/version/lookthrough)](https://cran.r-project.org/package=lookthrough)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

The goal of lookthrough is to help to view the assets exposure using the
look-through approach.

## Installation

``` r
devtools::install_github("shrektan/lookthrough")
```

## Example

``` r
library(lookthrough)
data(lkthr_sample)
ptfs <- as_lkthr(lkthr_sample$ptfs)
funds <- as_lkthr(lkthr_sample$funds)
lkthr_set_relation(ptfs, funds)
purrr::iwalk(lkthr_sample$attributes, ~{
  purrr::invoke(lkthr_set_attr, .x = .x, assets = .y, ptfs= ptfs)
})
print(ptfs, "exposure", "issuer", "guarantor")
#>                 levelName   exposure    issuer guarantor
#> 1  ptfs                           NA                    
#> 2   ¦--ptf1                       NA                    
#> 3   ¦   ¦--asset1          300.00000 company_a company_b
#> 4   ¦   ¦--fund2           900.00000                    
#> 5   ¦   ¦   ¦--asset5      230.76923                    
#> 6   ¦   ¦   ¦--asset3       92.30769 company_b company_d
#> 7   ¦   ¦   °--fund3       576.92308                    
#> 8   ¦   ¦       ¦--asset3  419.58042 company_b company_d
#> 9   ¦   ¦       °--asset7  157.34266 company_g          
#> 10  ¦   ¦--asset3          800.00000 company_b company_d
#> 11  ¦   ¦--asset4          500.00000 company_e          
#> 12  ¦   ¦--asset5          800.00000                    
#> 13  ¦   °--fund3          2000.00000                    
#> 14  ¦       ¦--asset3     1454.54545 company_b company_d
#> 15  ¦       °--asset7      545.45455 company_g          
#> 16  ¦--ptf2                       NA                    
#> 17  ¦   ¦--fund1           800.00000                    
#> 18  ¦   ¦   ¦--asset1      246.15385 company_a company_b
#> 19  ¦   ¦   °--asset2      553.84615 company_a company_c
#> 20  ¦   ¦--asset2          600.00000 company_a company_c
#> 21  ¦   °--asset3         9300.00000 company_b company_d
#> 22  °--ptf3                       NA                    
#> 23      ¦--asset5          900.00000                    
#> 24      ¦--asset6         1000.00000                    
#> 25      ¦--asset7         2000.00000 company_g          
#> 26      °--fund3          5000.00000                    
#> 27          ¦--asset3     3636.36364 company_b company_d
#> 28          °--asset7     1363.63636 company_g
```

``` r
plot(ptfs)
```

![ptfs-plot](man/figures/ptfs-plot.jpeg)

``` r
company_a <- data.tree::Clone(ptfs)
repeat ({
  pruned <- data.tree::Prune(company_a, function(node) {
    !(data.tree::isLeaf(node) && !"company_a" %in% node$issuer)
  })
  if (pruned == 0) break
})
print(company_a, "issuer", "exposure")
#>            levelName    issuer exposure
#> 1 ptfs                               NA
#> 2  ¦--ptf1                           NA
#> 3  ¦   °--asset1     company_a 300.0000
#> 4  °--ptf2                           NA
#> 5      ¦--fund1                800.0000
#> 6      ¦   ¦--asset1 company_a 246.1538
#> 7      ¦   °--asset2 company_a 553.8462
#> 8      °--asset2     company_a 600.0000
data.tree::Aggregate(
  ptfs,
  "exposure",
  sum,
  filterFun = function(node)
    data.tree::isLeaf(node) && "company_a" %in% node$issuer
)
#> [1] 24900
```

``` r
plot(company_a)
```

![issuer-plot](man/figures/issuer-plot.jpeg)
