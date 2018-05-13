
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
#>                     levelName   exposure    issuer guarantor
#> 1  ptfs                               NA                    
#> 2   ¦--ptf1                           NA                    
#> 3   ¦   ¦--asset1              300.00000 company_a company_b
#> 4   ¦   ¦--fund2               900.00000                    
#> 5   ¦   ¦   ¦--asset5          230.76923                    
#> 6   ¦   ¦   ¦--asset3           92.30769 company_b company_d
#> 7   ¦   ¦   °--fund3           576.92308                    
#> 8   ¦   ¦       ¦--asset3      384.61538 company_b company_d
#> 9   ¦   ¦       ¦--asset7      144.23077 company_g          
#> 10  ¦   ¦       °--fund1        48.07692                    
#> 11  ¦   ¦           ¦--asset1   14.79290 company_a company_b
#> 12  ¦   ¦           °--asset2   33.28402 company_a company_c
#> 13  ¦   ¦--asset3              800.00000 company_b company_d
#> 14  ¦   ¦--asset4              500.00000 company_e          
#> 15  ¦   ¦--asset5              800.00000                    
#> 16  ¦   °--fund3              2000.00000                    
#> 17  ¦       ¦--asset3         1333.33333 company_b company_d
#> 18  ¦       ¦--asset7          500.00000 company_g          
#> 19  ¦       °--fund1           166.66667                    
#> 20  ¦           ¦--asset1       51.28205 company_a company_b
#> 21  ¦           °--asset2      115.38462 company_a company_c
#> 22  ¦--ptf2                           NA                    
#> 23  ¦   ¦--fund1               800.00000                    
#> 24  ¦   ¦   ¦--asset1          246.15385 company_a company_b
#> 25  ¦   ¦   °--asset2          553.84615 company_a company_c
#> 26  ¦   ¦--asset2              600.00000 company_a company_c
#> 27  ¦   °--asset3             9300.00000 company_b company_d
#> 28  °--ptf3                           NA                    
#> 29      ¦--asset5              900.00000                    
#> 30      ¦--asset6             1000.00000                    
#> 31      ¦--asset7             2000.00000 company_g          
#> 32      °--fund3              5000.00000                    
#> 33          ¦--asset3         3333.33333 company_b company_d
#> 34          ¦--asset7         1250.00000 company_g          
#> 35          °--fund1           416.66667                    
#> 36              ¦--asset1      128.20513 company_a company_b
#> 37              °--asset2      288.46154 company_a company_c
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
company_a$Do(function(node) {
  if (!node$isLeaf) node$exposure <- NULL
})
print(company_a, "issuer", "exposure")
#>                     levelName    issuer  exposure
#> 1  ptfs                                        NA
#> 2   ¦--ptf1                                    NA
#> 3   ¦   ¦--asset1             company_a 300.00000
#> 4   ¦   ¦--fund2                               NA
#> 5   ¦   ¦   °--fund3                           NA
#> 6   ¦   ¦       °--fund1                       NA
#> 7   ¦   ¦           ¦--asset1 company_a  14.79290
#> 8   ¦   ¦           °--asset2 company_a  33.28402
#> 9   ¦   °--fund3                               NA
#> 10  ¦       °--fund1                           NA
#> 11  ¦           ¦--asset1     company_a  51.28205
#> 12  ¦           °--asset2     company_a 115.38462
#> 13  ¦--ptf2                                    NA
#> 14  ¦   ¦--fund1                               NA
#> 15  ¦   ¦   ¦--asset1         company_a 246.15385
#> 16  ¦   ¦   °--asset2         company_a 553.84615
#> 17  ¦   °--asset2             company_a 600.00000
#> 18  °--ptf3                                    NA
#> 19      °--fund3                               NA
#> 20          °--fund1                           NA
#> 21              ¦--asset1     company_a 128.20513
#> 22              °--asset2     company_a 288.46154
data.tree::Aggregate(company_a, "exposure", sum)
#> [1] 2331.41
```

``` r
plot(company_a)
```

![issuer-plot](man/figures/issuer-plot.jpeg)
