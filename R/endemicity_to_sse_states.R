#' All possible endemicity statuses
#'
#' @export
all_endemicity_status <- function() {
  return(c("not_present", "endemic", "nonendemic"))
}

#' Extract tip states from a phylod object
#'
#' @inheritParams default_params_doc
#' @return an integer vector of tip states, as expected by SSE models
#'
#' @export
#'
get_sse_tip_states <- function(phylod, sse_model = "musse") {
  check_phylo_data(phylod)
  endemicity_status <- phylobase::tipData(phylod)$endemicity_status
  tip_states <- endemicity_to_sse_states(endemicity_status, sse_model)
  names(tip_states) <- phylobase::tipLabels(phylod)
  return(tip_states)
}

#' Convert endemicity to SSE states
#'
#' @param endemicity_status character vector with values "endemic", "nonendemic"
#' and/or "not_present"
#' @inheritParams default_params_doc
#' @return an integer vector of tip states, following the encoding expected by
#' the MuSSE/GeoSSE
#'
#' @export
#'
endemicity_to_sse_states <- function(endemicity_status, sse_model = "musse") {
  if (!sse_model %in% c("musse", "geosse")) {
    stop("sse_model should be either \"musse\" or \"geosse\".")
  }
  if (any(!endemicity_status %in% all_endemicity_status())) {
    stop("status should only be \"not_present\", \"endemic\" or \"nonendemic\"")
  }
  tip_states <- c()
  for (i in seq_along(endemicity_status)) {
    tip_states[i] <- which(all_endemicity_status() == endemicity_status[i])
  }
  if (sse_model == "geosse") {
    tip_states[tip_states == 3] <- 0
  }
  return(tip_states)
}

#' Convert SSE states back to endemicity status
#'
#' @param states integer vector of tip states, as expected by SSE models
#' @inheritParams default_params_doc
#' @return character vector with values "endemic", "nonendemic" and/or
#' "not_present"
#'
#' @export
sse_states_to_endemicity <- function(states, sse_model = "musse") {
  if (any(!as.numeric(states) %in% 1:3)) {
    stop("states should only be 1, 2, or 3")
  }
  if (!sse_model %in% c("musse", "geosse")) {
    stop("sse_model should be either \"musse\" or \"geosse\".")
  }
  if (sse_model == "geosse") {
    states[states == 3] <- 0
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
  exptd_col_names <- paste0(all_endemicity_status(), "_prob")
  if (any(!exptd_col_names %in% colnames(asr_df))) {
    stop("asr_df should contain columns \"not_present_prob\", \"endemic_prob\", \"nonendemic_prob\". ")
  }
  asr_df <- asr_df[, exptd_col_names]
  endemicity_status <- c()
  if (method == "max") {
    selected_states <- max.col(asr_df, ties.method = "last")
    for (i in seq_along(selected_states)) {
      endemicity_status[i] <- all_endemicity_status()[selected_states[i]]
    }
  } else if (method == "random") {
    for (i in seq_len(nrow(asr_df))) {
      selected_state <- sample(x = 1:3, size = 1, prob = asr_df[i, ])
      endemicity_status[i] <- all_endemicity_status()[selected_state]
    }
  } else {
    stop("Argument method should only be \"max\" or \"random\"")
  }
  return(endemicity_status)
}
