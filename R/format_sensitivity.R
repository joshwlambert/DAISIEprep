#' Formats sensitivity data into tidy data
#'
#' @return tibble
#' @keywords internal
format_sensitivity <- function() {

  dna <- lapply(sensitivity_data, function(x) {
    lapply(x, "[[", 1)
  })

  complete <- lapply(sensitivity_data, function(x) {
    lapply(x, "[[", 2)
  })

  parameters <- lapply(sensitivity_data, function(x) {
    lapply(x, "[[", 3)
  })

  dna <- unlist(dna, recursive = FALSE)
  dna_clado <- sapply(dna, "[[", "lambda_c")
  dna_ext <- sapply(dna, "[[", "mu")
  dna_k <- sapply(dna, "[[", "K")
  dna_immig <- sapply(dna, "[[", "gamma")
  dna_ana <- sapply(dna, "[[", "lambda_a")

  complete <- unlist(complete, recursive = FALSE)
  complete_clado <- sapply(complete, "[[", "lambda_c")
  complete_ext <- sapply(complete, "[[", "mu")
  complete_k <- sapply(complete, "[[", "K")
  complete_immig <- sapply(complete, "[[", "gamma")
  complete_ana <- sapply(complete, "[[", "lambda_a")

  parameters <- unlist(parameters, recursive = FALSE)
  extraction_method <- sapply(parameters, "[[", "extraction_method")
  asr_method <- sapply(parameters, "[[", "asr_method")
  tie_preference <- sapply(parameters, "[[", "tie_preference")

  plotting_data_dna <- tibble::tibble(
    extraction_method = extraction_method,
    asr_method = asr_method,
    tie_preference = tie_preference,
    dna_clado = dna_clado,
    dna_ext = dna_ext,
    dna_immig = dna_immig,
    dna_ana = dna_ana
  )

  plotting_data_dna <- tidyr::unite(
    data = plotting_data_dna,
    col = extraction,
    extraction_method:tie_preference
  )

  plotting_data_dna <- tidyr::pivot_longer(
    data = plotting_data_dna,
    names_to = "parameter",
    dna_clado:dna_ana,
    values_to = "rates"
  )

  # check whether data using tie_preference of island or mainland makes a
  # difference to the rates estimated from DAISIE. If they are all identical
  # they can be removed from the data as the density plots will completely overlap

  which_asr_mk_island <- which(
    plotting_data_dna$extraction == "asr_mk_island"
  )
  which_asr_mk_mainland <- which(
    plotting_data_dna$extraction == "asr_mk_mainland"
  )
  identical_mk <- identical(
    plotting_data_dna[which_asr_mk_island, "rates"],
    plotting_data_dna[which_asr_mk_mainland, "rates"]
  )

  which_asr_parsimony_island <- which(
    plotting_data_dna$extraction == "asr_parsimony_island"
  )
  which_asr_parsimony_mainland <- which(
    plotting_data_dna$extraction == "asr_parsimony_mainland"
  )
  identical_parsimony <- identical(
    plotting_data_dna[which_asr_parsimony_island, "rates"],
    plotting_data_dna[which_asr_parsimony_mainland, "rates"]
  )


  if (identical_mk && identical_parsimony) {
    plotting_data_dna <- dplyr::slice(
      plotting_data_dna,
      -which(
        plotting_data_dna$extraction %in%
          c("asr_mk_mainland", "asr_parsimony_mainland")
      )
    )
  }
}
