#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`


#' @importFrom data.tree Clone
#' @export
data.tree::Clone


#' Floating comparision
#' @noRd
`%==%` <- function(x, y, tol = .Machine$double.eps^0.5) {
  abs(x - y) < tol
}


#' Formatting numbers as xxx,xxx.xx
#' @noRd
formatting <- function(x, digits = 2, zero = "-") {
  stopifnot(is.character(zero), length(zero) == 1L)
  res <- formatC(x, digits = digits, format = "f", big.mark = ",", big.interval = 3)
  res[is.na(x)] <- NA_character_
  res[x %==% 0.0] <- zero
  res
}
