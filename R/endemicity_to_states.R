#' All possible endemicity statuses
#'
#' @export
all_endemicity_status <- function() {
  return(c("not_present", "nonendemic", "endemic"))
}

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
      replacement = all_endemicity_status()[i],
      x = states
    )
  }
  return(states)
}


#' Select endemicity status from ancestral states probabilities
#'
#' Selects a state for each node (both internal nodes, i.e. ancestral states,
#' and tips, if included) from a table of probabilities.
#'
#' @param asr_df a data frame containing at least these three columns:
#' not_present_prob | endemic_prob | nonendemic_prob (in any order). Each column
#' should contain the estimated probability of the state for each node (rows)
#' and these columns should sum to 1.
#' @param method "max" or "random". "max" will select the state with highest
#' probability (selecting last state in event of a tie), while "random" will
#' sample the states randomly with the probabilities as weight for each state.
#'
#' @return a character vector, with the selected endemicity status for each node.
#' @export
select_endemicity_status <- function(asr_df, method = "max") {
  col_names <- paste0(all_endemicity_status(), "_prob")
  asr_df <- asr_df[, col_names]
  if (method == "max") {
    asr_states <- max.col(asr_df, ties.method = "last")
  } else if (method == "random") {
    asr_states <- c()
    for (i in 1:nrow(asr_df)) {
      state <- sample(x = 1:3, size = 1, prob = asr_df[i, ])
      asr_states[i] <- state
    }
  } else {
    stop("Argument method should only be \"max\" or \"random\"")
  }
  endemicity_status <- states_to_endemicity(asr_states)
  return(endemicity_status)
}
