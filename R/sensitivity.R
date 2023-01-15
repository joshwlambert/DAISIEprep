#' Runs a sensitivity analysis to test the influences of changing the data
#' on the parameter estimates for the DAISIE maximum likelihood inference model
#'
#' @inheritParams default_params_doc
#'
#' @return Data frame of parameter estimates and the parameter setting used
#' when inferring them
#' @export
#'
#' @examples
#' \dontrun{
#' #WIP
#' }
sensitivity <- function(phylo,
                        island_species,
                        extraction_method,
                        asr_method,
                        tie_preference,
                        island_age,
                        num_mainland_species,
                        verbose = FALSE) {

  # convert trees to phylo4 objects
  phylo <- phylobase::phylo4(phylo)

  # create endemicity status data frame
  endemicity_status <- DAISIEprep::create_endemicity_status(
    phylo = phylo,
    island_species = island_species
  )

  # combine tree and endemicity status
  phylod <- phylobase::phylo4d(
    phylo,
    endemicity_status
  )

  # create parameter space from input
  parameter_space <- expand.grid(
    extraction_method = extraction_method,
    asr_method = asr_method,
    tie_preference = tie_preference,
    island_age = island_age,
    num_mainland_species = num_mainland_species
  )

  if ("min" %in% extraction_method) {

    # get the rows with extraction method = "min"
    min_rows <- which(parameter_space$extraction_method == "min")

    # set asr_method and tie_preference in min rows to NA
    parameter_space[min_rows, c("asr_method", "tie_preference")] <- NA_character_

    # remove duplicated rows
    parameter_space <- unique(parameter_space)
  }

  ml_list <- list()
  for (i in seq_len(nrow(parameter_space))) {

    if (verbose) message("Parameter set: ", i, " of ", nrow(parameter_space))

    if (parameter_space$extraction_method[i] == "asr") {
      phylod <- DAISIEprep::add_asr_node_states(
        phylod = phylod,
        asr_method = parameter_space$asr_method[i]
      )
    }

    # extract island community
    island_tbl <- DAISIEprep::extract_island_species(
      phylod = phylod,
      extraction_method = parameter_space$extraction_method[i]
    )

    # convert to daisie data list
    daisie_data_list <- DAISIEprep::create_daisie_data(
      data = island_tbl,
      island_age = parameter_space$island_age[i],
      num_mainland_species = parameter_space$num_mainland_species[i]
    )

    ml <- DAISIE::DAISIE_ML_CS(
      datalist = daisie_data_list,
      initparsopt = c(1, 1, 200, 0.1, 1),
      idparsopt = 1:5,
      parsfix = NULL,
      idparsfix = NULL,
      ddmodel = 11,
      jitter = 1e-5
    )

    ml_list[[i]] <- list(
      ml = ml,
      parameters = parameter_space[i, ]
    )
  }

  # extract data
  ml <- lapply(ml_list, "[[", "ml")
  params <- lapply(ml_list, "[[", "parameters")

  # create a vector of parameter estimates from data
  clado <- sapply(ml, "[[", "lambda_c")
  ext <- sapply(ml, "[[", "mu")
  k <- sapply(ml, "[[", "K")
  immig <- sapply(ml, "[[", "gamma")
  ana <- sapply(ml, "[[", "lambda_a")

  extraction_method <- sapply(params, "[[", "extraction_method")
  asr_method <- sapply(params, "[[", "asr_method")
  tie_preference <- sapply(params, "[[", "tie_preference")
  island_age <- sapply(params, "[[", "island_age")
  num_mainland_species <- sapply(params, "[[", "num_mainland_species")

  sensitivity <- data.frame(
    extraction_method = extraction_method,
    asr_method = asr_method,
    tie_preference = tie_preference,
    clado = clado,
    ext = ext,
    k = k,
    immig = immig,
    ana = ana
  )

  # tidy data
  sensitivity <- tidyr::pivot_longer(
    data = sensitivity,
    names_to = "parameter",
    clado:ana,
    values_to = "rates"
  )

  # return sensitivity data frame
  sensitivity
}
