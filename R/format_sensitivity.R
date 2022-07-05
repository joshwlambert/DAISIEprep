#' Formats sensitivity data into tidy data
#'
#' @return tibble
#' @keywords internal
format_sensitivity <- function(sensitivity_data) {

  # extract dna parameter estimates
  dna <- lapply(sensitivity_data, function(x) {
    lapply(x, "[[", 1)
  })

  # extract complete parameter estimates
  complete <- lapply(sensitivity_data, function(x) {
    lapply(x, "[[", 2)
  })

  # extract parameters
  parameters <- lapply(sensitivity_data, function(x) {
    lapply(x, "[[", 3)
  })

  # create a vector of parameter estimates for dna data
  dna <- unlist(dna, recursive = FALSE)
  dna_clado <- sapply(dna, "[[", "lambda_c")
  dna_ext <- sapply(dna, "[[", "mu")
  dna_k <- sapply(dna, "[[", "K")
  dna_immig <- sapply(dna, "[[", "gamma")
  dna_ana <- sapply(dna, "[[", "lambda_a")

  # create a vector of parameter estimates for complete data
  complete <- unlist(complete, recursive = FALSE)
  complete_clado <- sapply(complete, "[[", "lambda_c")
  complete_ext <- sapply(complete, "[[", "mu")
  complete_k <- sapply(complete, "[[", "K")
  complete_immig <- sapply(complete, "[[", "gamma")
  complete_ana <- sapply(complete, "[[", "lambda_a")

  # create a vector of parameters
  parameters <- unlist(parameters, recursive = FALSE)
  extraction_method <- sapply(parameters, "[[", "extraction_method")
  asr_method <- sapply(parameters, "[[", "asr_method")
  tie_preference <- sapply(parameters, "[[", "tie_preference")

  # store dna parameter estimates in tibble
  dna_data <- tibble::tibble(
    extraction_method = extraction_method,
    asr_method = asr_method,
    tie_preference = tie_preference,
    clado = dna_clado,
    ext = dna_ext,
    immig = dna_immig,
    ana = dna_ana
  )

  # store complete parameter estimates in tibble
  complete_data <- tibble::tibble(
    extraction_method = extraction_method,
    asr_method = asr_method,
    tie_preference = tie_preference,
    clado = complete_clado,
    ext = complete_ext,
    immig = complete_immig,
    ana = complete_ana
  )

  # merge extraction_method, asr_method and tie_preference for dna data
  dna_data <- tidyr::unite(
    data = dna_data,
    col = extraction,
    extraction_method:tie_preference
  )

  # merge extraction_method, asr_method and tie_preference for complete data
  complete_data <- tidyr::unite(
    data = complete_data,
    col = extraction,
    extraction_method:tie_preference
  )

  # tidy dna data
  dna_data <- tidyr::pivot_longer(
    data = dna_data,
    names_to = "parameter",
    clado:ana,
    values_to = "rates"
  )

  # tidy complete data
  complete_data <- tidyr::pivot_longer(
    data = complete_data,
    names_to = "parameter",
    clado:ana,
    values_to = "rates"
  )

  # check whether data using tie_preference of island or mainland makes a
  # difference to the rates estimated from DAISIE. If they are all identical
  # they can be removed from the data as the density plots will completely overlap

  which_asr_mk_island <- which(
    dna_data$extraction == "asr_mk_island"
  )
  which_asr_mk_mainland <- which(
    dna_data$extraction == "asr_mk_mainland"
  )
  identical_mk <- identical(
    dna_data[which_asr_mk_island, "rates"],
    dna_data[which_asr_mk_mainland, "rates"]
  )

  which_asr_parsimony_island <- which(
    dna_data$extraction == "asr_parsimony_island"
  )
  which_asr_parsimony_mainland <- which(
    dna_data$extraction == "asr_parsimony_mainland"
  )
  identical_parsimony <- identical(
    dna_data[which_asr_parsimony_island, "rates"],
    dna_data[which_asr_parsimony_mainland, "rates"]
  )


  if (identical_mk && identical_parsimony) {
    dna_data <- dplyr::slice(
      dna_data,
      -which(
        dna_data$extraction %in%
          c("asr_mk_mainland", "asr_parsimony_mainland")
      )
    )
  }

  which_asr_mk_island <- which(
    complete_data$extraction == "asr_mk_island"
  )
  which_asr_mk_mainland <- which(
    complete_data$extraction == "asr_mk_mainland"
  )
  identical_mk <- identical(
    complete_data[which_asr_mk_island, "rates"],
    complete_data[which_asr_mk_mainland, "rates"]
  )

  which_asr_parsimony_island <- which(
    complete_data$extraction == "asr_parsimony_island"
  )
  which_asr_parsimony_mainland <- which(
    complete_data$extraction == "asr_parsimony_mainland"
  )
  identical_parsimony <- identical(
    complete_data[which_asr_parsimony_island, "rates"],
    complete_data[which_asr_parsimony_mainland, "rates"]
  )


  if (identical_mk && identical_parsimony) {
    complete_data <- dplyr::slice(
      complete_data,
      -which(
        complete_data$extraction %in%
          c("asr_mk_mainland", "asr_parsimony_mainland")
      )
    )
  }

  # return a list of tibbles for dna and complete data
  list(
    dna_data = dna_data,
    complete_data = complete_data
  )
}
