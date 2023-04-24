#' Performance analysis of the extract_island_species() function
#' Uses system.time() for timing for reasons explained here:
#' https://radfordneal.wordpress.com/2014/02/02/inaccurate-results-from-microbenchmark/ # nolint
#'
#' @inheritParams default_params_doc
#'
#' @return Data frame
#' @export
benchmark <- function(phylod,
                      tree_size_range,
                      num_points,
                      prob_on_island,
                      prob_endemic,
                      replicates,
                      extraction_method,
                      asr_method,
                      tie_preference,
                      log_scale = TRUE,
                      parameter_index = NULL,
                      verbose = FALSE) {

  if (is.null(phylod)) {
    if (log_scale) {
      tree_size <- exp(seq(
        from = log(tree_size_range[1]),
        to = log(tree_size_range[2]),
        length.out = num_points
      ))
    } else {
      tree_size <- seq(
        from = tree_size_range[1],
        to = tree_size_range[2],
        length.out = num_points
      )
    }

    # round tree size to integer
    tree_size <- round(tree_size)
  } else {
    tree_size <- phylobase::nTips(phylod)
  }

  parameter_space <- expand.grid(
    tree_size = tree_size,
    prob_on_island = prob_on_island,
    prob_endemic = prob_endemic,
    extraction_method = extraction_method,
    asr_method = asr_method,
    tie_preference = tie_preference,
    stringsAsFactors = FALSE
  )

  if ("min" %in% extraction_method) {

    # get the rows with extraction method = "min"
    min_rows <- which(parameter_space$extraction_method == "min")

    # set asr_method and tie_preference in min rows to NA
    parameter_space[min_rows, c("asr_method", "tie_preference")] <- NA_character_

    # remove duplicated rows
    parameter_space <- unique(parameter_space)
  }

  times_list <- list()

  # if parameter index is not given loop over each parameter set
  if (is.null(parameter_index)) {
    parameter_index <- seq_len(nrow(parameter_space))
  }

  for (i in parameter_index) {

    if (verbose) message("Parameter set: ", i, " of ", nrow(parameter_space))

    mean_times <- c()
    for (j in seq_len(replicates)) {

      if (verbose) message("Replicate: ", j, " of ", replicates)

      if (is.null(phylod)) {
        # simulate phylogeny
        phylo <- ape::rphylo(
          n = parameter_space$tree_size[i],
          birth = 0.1,
          death = 0
        )

        # generate a set of unique tip labels that conform to standard
        tip_labels <- expand.grid(letters, letters, letters)
        tip_labels <- do.call(paste0, tip_labels)
        tip_labels <- tip_labels[1:parameter_space$tree_size[i]]
        tip_labels <- paste("bird", tip_labels, sep = "_")
        phylo$tip.label <- tip_labels

        prob_not_present <- 1 - parameter_space$prob_on_island[i]
        prob_endemic <-
          parameter_space$prob_endemic[i] * parameter_space$prob_on_island[i]
        prob_nonendemic <-
          (1 - parameter_space$prob_endemic[i]) *
          parameter_space$prob_on_island[i]


        empty_island <- TRUE
        while (empty_island) {
          # generate tip states under uniform sampling
          endemicity_status <- sample(
            x = c("endemic", "nonendemic", "not_present"),
            size = parameter_space$tree_size[i],
            replace = TRUE,
            prob = c(prob_endemic, prob_nonendemic, prob_not_present)
          )
          if (any(endemicity_status != "not_present")) {
            empty_island <- FALSE
          }
        }

        # add not present outgroup
        phylo <- DAISIEprep::add_outgroup(phylo)
        endemicity_status <- c("not_present", endemicity_status)

        # format data for DAISIEprep
        sim_phylod <- phylobase::phylo4d(
          phylo,
          as.data.frame(endemicity_status)
        )

        if (parameter_space$extraction_method[i] == "asr") {
          sim_phylod <- DAISIEprep::add_asr_node_states(
            phylod = sim_phylod,
            asr_method = parameter_space$asr_method[i],
            tie_preference = parameter_space$tie_preference[i]
          )
        }
      } else {
        # assign phylod for benchmarking
        sim_phylod <- phylod
      }

      # run extraction
      time <- system.time(for (n in 1:3) {
        island_tbl <- DAISIEprep::extract_island_species(
          phylod = sim_phylod,
          extraction_method = parameter_space$extraction_method[i],
          island_tbl = NULL,
          include_not_present = FALSE
        )
      })

      mean_times[j] <- time["elapsed"] / 3
    }
    times_list[[i]] <- list(
      mean_times = mean_times,
      parameters = parameter_space[i, ]
    )
  }

  # remove any element elements from list
  times_list[sapply(times_list, is.null)] <- NULL

  # extract data
  mean_times <- lapply(times_list, "[[", "mean_times")
  params <- lapply(times_list, "[[", "parameters")

  # create a vector of median time for each run
  median_time <- vapply(mean_times, stats::median, FUN.VALUE = numeric(1))

  #convert from nanoseconds to seconds
  median_time <- median_time / 1e9

  tree_size <- sapply(params, "[[", "tree_size")
  prob_on_island <- sapply(params, "[[", "prob_on_island")
  prob_endemic <- sapply(params, "[[", "prob_endemic")
  extraction_method <- sapply(params, "[[", "extraction_method")
  asr_method <- sapply(params, "[[", "asr_method")
  tie_preference <- sapply(params, "[[", "tie_preference")

  # convert list to data frame
  performance <- data.frame(
    tree_size = tree_size,
    prob_on_island = prob_on_island,
    prob_endemic = prob_endemic,
    extraction_method = extraction_method,
    asr_method = asr_method,
    tie_preference = tie_preference,
    median_time = median_time
  )

  # return performance data
  performance
}
