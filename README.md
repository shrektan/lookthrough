
<!-- README.md is generated from README.Rmd. Please edit that file -->
lookthrough
===========

[![CRAN status](https://www.r-pkg.org/badges/version/lookthrough)](https://cran.r-project.org/package=lookthrough) [![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental) [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/shrektan/lookthrough?branch=master&svg=true)](https://ci.appveyor.com/project/shrektan/lookthrough) [![Travis build status](https://travis-ci.org/shrektan/lookthrough.svg?branch=master)](https://travis-ci.org/shrektan/lookthrough) [![Coverage status](https://codecov.io/gh/shrektan/lookthrough/branch/master/graph/badge.svg)](https://codecov.io/github/shrektan/lookthrough?branch=master)

The goal of lookthrough is to help to view the assets exposure using the look-through approach.

Installation
------------

``` r
devtools::install_github("shrektan/lookthrough")
```

Example
-------

``` r
library(lookthrough)
data(lkthr_sample)
ptfs <- as_lkthr(lkthr_sample$ptfs)
funds <- as_lkthr(lkthr_sample$funds)
lkthr_match(ptfs, funds)
lkthr_set(ptfs, lkthr_sample$attributes)
print(ptfs, "exposure", "issuer", "guarantor")
#>                     levelName  exposure    issuer guarantor
#> 1  TOTAL                      24,900.00                    
#> 2   |--ptf1                    5,300.00                    
#> 3   |   |--asset1                300.00 company_a company_b
#> 4   |   |--fund2                 900.00                    
#> 5   |   |   |--asset5            230.77                    
#> 6   |   |   |--asset3             92.31 company_b company_d
#> 7   |   |   °--fund3             576.92                    
#> 8   |   |       |--asset3        384.62 company_b company_d
#> 9   |   |       |--asset7        144.23 company_g          
#> 10  |   |       °--fund1          48.08                    
#> 11  |   |           |--asset1     14.79 company_a company_b
#> 12  |   |           °--asset2     33.28 company_a company_c
#> 13  |   |--asset3                800.00 company_b company_d
#> 14  |   |--asset4                500.00 company_e          
#> 15  |   |--asset5                800.00                    
#> 16  |   °--fund3               2,000.00                    
#> 17  |       |--asset3          1,333.33 company_b company_d
#> 18  |       |--asset7            500.00 company_g          
#> 19  |       °--fund1             166.67                    
#> 20  |           |--asset1         51.28 company_a company_b
#> 21  |           °--asset2        115.38 company_a company_c
#> 22  |--ptf2                   10,700.00                    
#> 23  |   |--fund1                 800.00                    
#> 24  |   |   |--asset1            246.15 company_a company_b
#> 25  |   |   °--asset2            553.85 company_a company_c
#> 26  |   |--asset2                600.00 company_a company_c
#> 27  |   °--asset3              9,300.00 company_b company_d
#> 28  °--ptf3                    8,900.00                    
#> 29      |--asset5                900.00                    
#> 30      |--asset6              1,000.00                    
#> 31      |--asset7              2,000.00 company_g          
#> 32      °--fund3               5,000.00                    
#> 33          |--asset3          3,333.33 company_b company_d
#> 34          |--asset7          1,250.00 company_g          
#> 35          °--fund1             416.67                    
#> 36              |--asset1        128.21 company_a company_b
#> 37              °--asset2        288.46 company_a company_c
```

``` r
plot(ptfs)
#> PhantomJS not found. You can install it with webshot::install_phantomjs(). If it is installed, please make sure the phantomjs executable can be found via the PATH variable.
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-d56915a2250cd11365b2">{"x":{"diagram":"digraph {\n\ngraph [rankdir = \"LR\"]\n\n\n\n  \"1\" [label = \"TOTAL\n24,900.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"TOTAL\", fillcolor = \"#FFFFFF\"] \n  \"2\" [label = \"ptf1\n5,300.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"ptf1\", fillcolor = \"#FFFFFF\"] \n  \"3\" [label = \"asset1\n300.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_b\nissuer: company_a\", fillcolor = \"#FFFFFF\"] \n  \"4\" [label = \"fund2\n900.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund2\", fillcolor = \"GreenYellow\"] \n  \"5\" [label = \"asset5\n230.77\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"asset5\", fillcolor = \"GreenYellow\"] \n  \"6\" [label = \"asset3\n92.31\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_d\nissuer: company_b\", fillcolor = \"GreenYellow\"] \n  \"7\" [label = \"fund3\n576.92\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund3\", fillcolor = \"GreenYellow\"] \n  \"8\" [label = \"asset3\n384.62\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_d\nissuer: company_b\", fillcolor = \"GreenYellow\"] \n  \"9\" [label = \"asset7\n144.23\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"issuer: company_g\", fillcolor = \"GreenYellow\"] \n  \"10\" [label = \"fund1\n48.08\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund1\", fillcolor = \"GreenYellow\"] \n  \"11\" [label = \"asset1\n14.79\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_b\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n  \"12\" [label = \"asset2\n33.28\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_c\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n  \"13\" [label = \"asset3\n800.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_d\nissuer: company_b\", fillcolor = \"#FFFFFF\"] \n  \"14\" [label = \"asset4\n500.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"issuer: company_e\", fillcolor = \"#FFFFFF\"] \n  \"15\" [label = \"asset5\n800.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"asset5\", fillcolor = \"#FFFFFF\"] \n  \"16\" [label = \"fund3\n2,000.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund3\", fillcolor = \"GreenYellow\"] \n  \"17\" [label = \"asset3\n1,333.33\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_d\nissuer: company_b\", fillcolor = \"GreenYellow\"] \n  \"18\" [label = \"asset7\n500.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"issuer: company_g\", fillcolor = \"GreenYellow\"] \n  \"19\" [label = \"fund1\n166.67\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund1\", fillcolor = \"GreenYellow\"] \n  \"20\" [label = \"asset1\n51.28\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_b\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n  \"21\" [label = \"asset2\n115.38\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_c\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n  \"22\" [label = \"ptf2\n10,700.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"ptf2\", fillcolor = \"#FFFFFF\"] \n  \"23\" [label = \"fund1\n800.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund1\", fillcolor = \"GreenYellow\"] \n  \"24\" [label = \"asset1\n246.15\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_b\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n  \"25\" [label = \"asset2\n553.85\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_c\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n  \"26\" [label = \"asset2\n600.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_c\nissuer: company_a\", fillcolor = \"#FFFFFF\"] \n  \"27\" [label = \"asset3\n9,300.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_d\nissuer: company_b\", fillcolor = \"#FFFFFF\"] \n  \"28\" [label = \"ptf3\n8,900.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"ptf3\", fillcolor = \"#FFFFFF\"] \n  \"29\" [label = \"asset5\n900.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"asset5\", fillcolor = \"#FFFFFF\"] \n  \"30\" [label = \"asset6\n1,000.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"asset6\", fillcolor = \"#FFFFFF\"] \n  \"31\" [label = \"asset7\n2,000.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"issuer: company_g\", fillcolor = \"#FFFFFF\"] \n  \"32\" [label = \"fund3\n5,000.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund3\", fillcolor = \"GreenYellow\"] \n  \"33\" [label = \"asset3\n3,333.33\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_d\nissuer: company_b\", fillcolor = \"GreenYellow\"] \n  \"34\" [label = \"asset7\n1,250.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"issuer: company_g\", fillcolor = \"GreenYellow\"] \n  \"35\" [label = \"fund1\n416.67\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund1\", fillcolor = \"GreenYellow\"] \n  \"36\" [label = \"asset1\n128.21\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_b\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n  \"37\" [label = \"asset2\n288.46\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_c\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n\"1\"->\"2\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"1\"->\"22\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"1\"->\"28\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"2\"->\"3\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"2\"->\"4\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"2\"->\"13\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"2\"->\"14\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"2\"->\"15\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"2\"->\"16\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"22\"->\"23\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"22\"->\"26\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"22\"->\"27\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"28\"->\"29\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"28\"->\"30\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"28\"->\"31\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"28\"->\"32\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"4\"->\"5\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"4\"->\"6\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"4\"->\"7\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"16\"->\"17\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"16\"->\"18\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"16\"->\"19\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"23\"->\"24\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"23\"->\"25\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"32\"->\"33\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"32\"->\"34\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"32\"->\"35\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"7\"->\"8\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"7\"->\"9\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"7\"->\"10\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"19\"->\"20\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"19\"->\"21\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"35\"->\"36\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"35\"->\"37\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"10\"->\"11\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"10\"->\"12\" [arrowhead = \"vee\", penwidth = \"2\"] \n}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
``` r
company_a <- lkthr_filter(ptfs, function(node) { "company_a" %in% node$issuer })
print(company_a, "issuer", "exposure")
#>                     levelName    issuer exposure
#> 1  TOTAL                                2,331.41
#> 2   |--ptf1                               514.74
#> 3   |   |--asset1             company_a   300.00
#> 4   |   |--fund2                           48.08
#> 5   |   |   °--fund3                       48.08
#> 6   |   |       °--fund1                   48.08
#> 7   |   |           |--asset1 company_a    14.79
#> 8   |   |           °--asset2 company_a    33.28
#> 9   |   °--fund3                          166.67
#> 10  |       °--fund1                      166.67
#> 11  |           |--asset1     company_a    51.28
#> 12  |           °--asset2     company_a   115.38
#> 13  |--ptf2                             1,400.00
#> 14  |   |--fund1                          800.00
#> 15  |   |   |--asset1         company_a   246.15
#> 16  |   |   °--asset2         company_a   553.85
#> 17  |   °--asset2             company_a   600.00
#> 18  °--ptf3                               416.67
#> 19      °--fund3                          416.67
#> 20          °--fund1                      416.67
#> 21              |--asset1     company_a   128.21
#> 22              °--asset2     company_a   288.46
data.tree::Aggregate(company_a, "exposure", sum)
#> [1] 2331.41
company_a$ptf1$exposure
#> [1] 514.7436
```

``` r
plot(company_a)
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-b614dbb9894766955d28">{"x":{"diagram":"digraph {\n\ngraph [rankdir = \"LR\"]\n\n\n\n  \"1\" [label = \"TOTAL\n2,331.41\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"TOTAL\", fillcolor = \"#FFFFFF\"] \n  \"2\" [label = \"ptf1\n514.74\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"ptf1\", fillcolor = \"#FFFFFF\"] \n  \"3\" [label = \"asset1\n300.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_b\nissuer: company_a\", fillcolor = \"#FFFFFF\"] \n  \"4\" [label = \"fund2\n48.08\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund2\", fillcolor = \"GreenYellow\"] \n  \"5\" [label = \"fund3\n48.08\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund3\", fillcolor = \"GreenYellow\"] \n  \"6\" [label = \"fund1\n48.08\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund1\", fillcolor = \"GreenYellow\"] \n  \"7\" [label = \"asset1\n14.79\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_b\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n  \"8\" [label = \"asset2\n33.28\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_c\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n  \"9\" [label = \"fund3\n166.67\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund3\", fillcolor = \"GreenYellow\"] \n  \"10\" [label = \"fund1\n166.67\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund1\", fillcolor = \"GreenYellow\"] \n  \"11\" [label = \"asset1\n51.28\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_b\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n  \"12\" [label = \"asset2\n115.38\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_c\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n  \"13\" [label = \"ptf2\n1,400.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"ptf2\", fillcolor = \"#FFFFFF\"] \n  \"14\" [label = \"fund1\n800.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund1\", fillcolor = \"GreenYellow\"] \n  \"15\" [label = \"asset1\n246.15\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_b\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n  \"16\" [label = \"asset2\n553.85\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_c\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n  \"17\" [label = \"asset2\n600.00\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_c\nissuer: company_a\", fillcolor = \"#FFFFFF\"] \n  \"18\" [label = \"ptf3\n416.67\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"ptf3\", fillcolor = \"#FFFFFF\"] \n  \"19\" [label = \"fund3\n416.67\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund3\", fillcolor = \"GreenYellow\"] \n  \"20\" [label = \"fund1\n416.67\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"fund1\", fillcolor = \"GreenYellow\"] \n  \"21\" [label = \"asset1\n128.21\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_b\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n  \"22\" [label = \"asset2\n288.46\", style = \"filled,rounded\", shape = \"box\", fontcolor = \"black\", fontname = \"arial\", tooltip = \"guarantor: company_c\nissuer: company_a\", fillcolor = \"GreenYellow\"] \n\"1\"->\"2\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"1\"->\"13\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"1\"->\"18\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"2\"->\"3\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"2\"->\"4\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"2\"->\"9\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"13\"->\"14\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"13\"->\"17\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"18\"->\"19\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"4\"->\"5\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"9\"->\"10\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"14\"->\"15\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"14\"->\"16\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"19\"->\"20\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"5\"->\"6\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"10\"->\"11\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"10\"->\"12\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"20\"->\"21\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"20\"->\"22\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"6\"->\"7\" [arrowhead = \"vee\", penwidth = \"2\"] \n\"6\"->\"8\" [arrowhead = \"vee\", penwidth = \"2\"] \n}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
