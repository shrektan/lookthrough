#' lookthrough: look-through the portfolio exposure
#'
#' The portfolio may invest in collective investment undertakings (ICU) or
#' investments packaged such as funds. In such case, only using the look-through
#' approach can the managers have a true undertanding of the portfolio exposure.
#' lookthrough is a simple package that helps you understand the exposure and
#' calculate aggregated numbers.
#'
#' The implementation takes advantage of the
#' [data.tree](https://github.com/gluc/data.tree) package, which is suitable for
#' this kind of problems. I strongly suggest you skim the vignettes of data.tree
#' (see the references below) to have a better understanding of how this package works.
#'
#' @references
#' * [Quick introduction to data.tree](https://cran.r-project.org/web/packages/data.tree/vignettes/data.tree.html)
#' * [Example applications of data.tree](https://cran.r-project.org/web/packages/data.tree/vignettes/applications.html)
#' * [Solvency II Information Note 9 - Look-through of Collective Investment Undertakings in template S.06.03](https://www.centralbank.ie/docs/default-source/Regulation/industry-market-sectors/insurance-reinsurance/solvency-ii/communications/solvency-ii-information-notes/solvency-ii-information-note-9-look-through-of-collective-investment-undertakings-in-template-s-06-03.pdf?sfvrsn=2)
"_PACKAGE"



#' @export
as_lkthr <- function(x, ...) {
  UseMethod("as_lkthr")
}


#' @export
as_lkthr.data.frame <- function(
  x, mapping = c(ptf = "PTF", asset = "ASSET", exposure = "EXPOSURE")
) {
  stopifnot(
    is.character(mapping),
    length(mapping) == 3L,
    c("ptf", "asset", "exposure") %in% names(mapping)
  )
  stopifnot(
    is.character(ptfs <- x[[mapping["ptf"]]]),
    is.character(assets <- x[[mapping["asset"]]]),
    is.numeric(exposures <- x[[mapping["exposure"]]]),
  )
  res <- data.tree::Node$new("ptfs")
  for (i in seq_along(ptfs)) {
    ptf <- ptfs[[i]]
    if (is.null(node_ptf <- data.tree::FindNode(res, ptf))) {
      node_ptf <- res$AddChild(ptf)
    }
    node_asset <- data.tree::FindNode(node_ptf, assets[i])
    node_asset$Set(exposure = exposures[i])
  }
  class(res) <- c("lkthr", class(res))
  res
}


#' @export
as_lkthr.list <- function(x, ...) {
  res <- data.tree::Node$new("ptfs")
  for (i in seq_along(x)) {
    ptf <- x[[i]]
    node_ptf <- res$AddChild(names(x)[i])
    for (j in seq_along(ptf)) {
      node_asset <- node_ptf$AddChild(names(ptf)[j])
      node_asset$Set(exposure = ptf[[j]])
    }
  }
  class(res) <- c("lkthr", class(res))
  res
}


#' @export
is_lkthr <- function(x) {
  inherits(x, "lkthr")
}


#' @export
lkthr_set_relation <- function(ptfs, funds) {
  stopifnot(
    is_lkthr(ptfs), is_lkthr(funds)
  )
  count <- NULL
  while (!identical(count, ptfs$totalCount)) {
    count <- ptfs$totalCount
    purrr::iwalk(funds$children, ~{
      fund <- .x
      fund_name <- .y
      fund_exposure <- data.tree::Aggregate(fund, "exposure", sum)
      ptfs$Do(fun = function(lkthr_asset) {
        asset_exposure <- lkthr_asset$exposure
        purrr::walk(fund$children, ~{
          node <- lkthr_asset$AddChildNode(data.tree::Clone(.x))
          node$exposure <- node$exposure * asset_exposure / fund_exposure
        })
      }, filterFun = function(node) {
        data.tree::isLeaf(node) && fund_name %in% node$name
      })
    })
  }
  invisible(ptfs)
}


#' @export
lkthr_set_attr <- function(ptfs, assets, ...) {
  stopifnot(
    is_lkthr(ptfs), is.character(assets)
  )
  ptfs$Do(function(node) {
    node$Set(...)
  }, filterFun = function(node) {
    data.tree::isLeaf(node) && node$name %in% assets
  })
}
