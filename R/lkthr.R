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
#' this kind of problems. The users are supposed to be familiared with the data.tree
#' package. For those who are not, I strongly suggest to skim the vignettes of data.tree
#' (see the references below).
#'
#' @references
#' * [Quick introduction to data.tree](https://CRAN.R-project.org/package=data.tree/vignettes/data.tree.html)
#' * [Example applications of data.tree](https://CRAN.R-project.org/package=data.tree/vignettes/applications.html)
#' * [Solvency II Information Note 9 - Look-through of Collective Investment Undertakings in template S.06.03](https://www.centralbank.ie/docs/default-source/Regulation/industry-market-sectors/insurance-reinsurance/solvency-ii/communications/solvency-ii-information-notes/solvency-ii-information-note-9-look-through-of-collective-investment-undertakings-in-template-s-06-03.pdf?sfvrsn=2)
#' * [Solvency II Look-Through](http://www.dilloneustace.ie/download/1/Publications/Insurance/Solvency\%20II\%20Look-Through.pdf)
#'
"_PACKAGE"


#' lkthr sample data
#'
#' A dataset contains artifical ptf positions, fund positions and
#' asset issuers / guarantors.
#'
#' @usage data(lkthr_sample)
#' @author Xianying Tan
"lkthr_sample"



#' Make a lkthr(abbr of lookthrough) object
#'
#' @param x A `list` or a `data.frame` contains position info. If
#'   `x` is a `list`, it should contain three levels of each represents
#'   the `PTF`, `ASSET` and `EXPOSURE`.
#' @param mapping A named character vector whose names are `ptf`,
#'  `asset` and `exposure`used only when `x` is a `data.frame`,
#'  It's used to map the `data.frame` columns.
#' @param ... Other arguments being passed to the patched functions.
#'
#' @return A `lkthr` object. Essentially it's a [data.tree::Node].
#'
#' @export
as_lkthr <- function(x, ...) {
  UseMethod("as_lkthr")
}


#' @rdname as_lkthr
#' @export
as_lkthr.data.frame <- function(
  x, mapping = c(ptf = "PTF", asset = "ASSET", exposure = "EXPOSURE"), ...
) {
  stopifnot(
    is.character(mapping),
    length(mapping) == 3L,
    c("ptf", "asset", "exposure") %in% names(mapping)
  )
  stopifnot(
    is.character(ptfs <- x[[mapping["ptf"]]]),
    is.character(assets <- x[[mapping["asset"]]]),
    is.numeric(exposures <- x[[mapping["exposure"]]])
  )
  tbl <- do.call(data.frame, args = c(
    list(
      "__PATH__" = paste("ptfs", ptfs, assets, sep = "|"),
      exposure = exposures,
      stringsAsFactors = FALSE,
      check.names = FALSE
    ),
    x[, colnames(x)[!colnames(x) %in% mapping], drop = FALSE]
  ))
  res <- data.tree::FromDataFrameTable(
    tbl, pathName = "__PATH__", pathDelimiter = "|"
  )
  class(res) <- c("lkthr", class(res))
  lkthr_recal_exposure(res)
  res
}


#' @rdname as_lkthr
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
  lkthr_recal_exposure(res)
  res
}


is_lkthr <- function(x) {
  inherits(x, "lkthr")
}


#' Match the portfolio and the funds
#'
#' The fund position will be appended the asset by compare the name.
#'
#' It's a by reference operation and will alter the `ptfs` input. You
#' can call [data.tree::Clone()] in order not to change the original value.
#'
#' @param ptfs A `lkthr` object contains the ptf position.
#' @param funds A `lkthr` object contains the fund position.
#' @param max_layer The maximum look-through layers that's allowed to perform.
#'
#' @return The altered `ptfs` invisibly.
#'
#' @export
lkthr_match <- function(ptfs, funds, max_layer = 5L) {
  stopifnot(
    is_lkthr(ptfs), is_lkthr(funds), is.numeric(max_layer)
  )
  layer <- 1L
  count <- NULL
  while (!identical(count, ptfs$totalCount) && layer < max_layer) {
    count <- ptfs$totalCount
    layer <- layer + 1L
    purrr::iwalk(funds$children, ~{
      fund_node <- .x
      fund_name <- .y
      fund_exposure <- data.tree::Aggregate(fund_node, "exposure", sum)
      ptfs$Do(fun = function(lkthr_asset) {
        asset_exposure <- lkthr_asset$exposure
        purrr::walk(fund_node$children, ~{
          node <- lkthr_asset$AddChildNode(data.tree::Clone(.))
          node$exposure <- node$exposure * asset_exposure / fund_exposure
        })
      }, filterFun = function(node) {
        data.tree::isLeaf(node) && fund_name %in% node$name
      })
    })
  }
  invisible(ptfs)
}


#' Set the assets' attributes
#'
#' Set character or numeric attributes to each asset. Again,
#' it's a by reference function.
#'
#' @inheritParams lkthr_match
#'
#' @param attr A named `list`. The asset will be match by
#'  its names.
#'
#' @return The altered `ptfs` invisibly.
#'
#' @export
lkthr_set <- function(ptfs, attr) {
  stopifnot(
    is_lkthr(ptfs), is.list(attr), !is.null(names(attr))
  )
  purrr::imap(attr, ~{
    ptfs$Do(function(node) {
      purrr::invoke(node$Set, .x = .x)
    }, filterFun = function(node) {
      data.tree::isLeaf(node) && node$name %in% .y
    })
  })
  invisible(ptfs)
}


#' Filter on condition
#'
#' Filter the `lkthr` tree by the attributes on leafs.
#'
#' @inheritParams lkthr_match
#'
#' @param fun A binary function with only one param `node`.
#'
#' @return A `lkthr` object.
#'
#' @export
lkthr_filter <- function(ptfs, fun) {
  stopifnot(is.function(fun), is_lkthr(ptfs))
  res <- data.tree::Clone(ptfs)
  repeat ({
    pruned <- data.tree::Prune(res, function(node) {
      !data.tree::isLeaf(node) || fun(node)
    })
    if (pruned == 0) break
  })
  lkthr_recal_exposure(res)
  res
}


lkthr_recal_exposure <- function(ptfs) {
  stopifnot(is_lkthr(ptfs))
  ptfs$Do(function(node) {
    node$exposure <- data.tree::Aggregate(node, attribute = "exposure", aggFun = sum)
  }, traversal = "post-order")
  invisible(ptfs)
}
