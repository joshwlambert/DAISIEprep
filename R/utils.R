#' Rounds numbers using the round up method, rather than the round to the
#' nearest even number method used by the base function `round`.
#'
#' @inheritParams default_params_doc
#'
#' @return Numeric
round_up <- function(n, digits = 0) {
  sign <- sign(n)
  fac <- 10^digits
  n <- trunc(fac * abs(n) + 0.5) / fac
  n <- n * sign
  n
}
