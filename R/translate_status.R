#' Takes a string of the various ways the island species status can be and
#' returns a uniform all lower-case string of the same status to make handling
#' statuses easier in other function
#'
#' @inheritParams default_params_doc
#'
#' @return Character string
#' @export
#'
#' @examples
#' translate_status("Endemic")
translate_status <- function(status) {

  status <- gsub(pattern = "_", replacement = "", x = status)
  status <- gsub(pattern = "-", replacement = "", x = status)

  if (any(grepl("^endemic$", status, ignore.case = TRUE))) {
    return("endemic")
  }

  if (any(grepl("^nonendemic$", status, ignore.case = TRUE))) {
    return("nonendemic")
  }

  if (any(grepl("^endemicmaxage$", status, ignore.case = TRUE))) {
    return("endemic_max_age")
  }

  if (any(grepl("^nonendemicmaxage$", status, ignore.case = TRUE))) {
    return("nonendemic_max_age")
  }

  if (any(grepl("^endemic&nonendemic$", status, ignore.case = TRUE))) {
    return("endemic&nonendemic")
  }

  if (any(grepl("^endemicmaxageminage$", status, ignore.case = TRUE))) {
    return("endemic_max_age_min_age")
  }

  if (any(grepl("^nonendemicmaxageminage$", status, ignore.case = TRUE))) {
    return("nonendemic_max_age_min_age")
  }

  stop("Status not recognised")
}
