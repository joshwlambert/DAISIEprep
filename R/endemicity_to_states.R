#' Extract tip states from a phylod object
#'
#' @inheritParams default_params_doc
#' @return an integer vector of tip states, as expected by SSE models
#'
#' @export
#'
get_tip_states <- function(phylod) {
  check_phylo_data(phylod)
  endemicity_status <- phylobase::tipData(phylod)$endemicity_status
  tip_states <- endemicity_to_states(endemicity_status)
  return(tip_states)
}

#' Convert endemicity to SSE states
#'
#' @param endemicity_status character vector with values "endemic", "nonendemic"
#' and/or "not_present"
#' @return an integer vector of tip states, as expected by SSE models
#'
#' @export
#'
endemicity_to_states <- function(endemicity_status) {
  tip_states <- c()
  for (i in seq_along(endemicity_status)) {
    if (grepl(pattern = "^not_present$", x = endemicity_status[i])) {
      tip_states[i] <- 1
    } else if (grepl(pattern = "^nonendemic$", x = endemicity_status[i])) {
      tip_states[i] <- 2
    } else if (grepl(pattern = "^endemic$", x = endemicity_status[i])) {
      tip_states[i] <- 3
    } else {
      stop("endemicity_status should always be one of \"not_present\", \"nonendemic\" or \"endemic\".")
    }
  }
  return(tip_states)
}

#' All possible endemicity statuses
#'
#' @export
all_endemicity_status <- function() {
  return(c("not_present", "nonendemic", "endemic"))
}

#' Convert SSE states back to endemicity status
#'
#' @param states integer vector of tip states, as expected by SSE models
#' @return character vector with values "endemic", "nonendemic" and/or
#' "not_present"
#'
#' @export
states_to_endemicity <- function(states) {
  if (any(!as.numeric(states) %in% 1:3)) {
    stop("states should always be 1, 2, or 3")
  }
  for (i in 1:3) {
    states <- gsub(
      pattern = as.character(i),
      replacement = all_endemicity_status[i],
      x = states
    )
  }
  return(states)
}
