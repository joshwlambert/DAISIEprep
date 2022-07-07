#' Performance analysis of the extract_island_species() function
#' Uses system.time() for timing for reasons explained here:
#' https://radfordneal.wordpress.com/2014/02/02/inaccurate-results-from-microbenchmark/
#'
#' @inheritParams default_params_doc
#'
#' @return Data frame
#' @export
#'
#' @examples
#' \dontrun{
#' #WIP
#' }
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
                      parameter_index = NULL) {

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
    tie_preference = tie_preference
  )


  times_list <- list()

  # if parameter index is not given loop over each parameter set
  if (is.null(parameter_index)) {
    parameter_index <- seq_len(nrow(parameter_space))
  }

  for (i in parameter_index) {

    message("Parameter set: ", i, " of ", nrow(parameter_space))

    mean_times <- c()
    for (j in seq_len(replicates)) {

      message("Replicate: ", j, " of ", replicates)

      if (is.null(phylod)) {
        # simulate phylogeny
        phylo <- ape::rcoal(n = parameter_space$tree_size[i])

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
          (1 - parameter_space$prob_endemic[i]) * parameter_space$prob_on_island[i]


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
        phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))

        if (extraction_method == "asr") {
          phylod <- DAISIEprep::add_asr_node_states(
            phylod = phylod,
            asr_method = asr_method,
            tie_preference = tie_preference
          )
        }
      }

      # run extraction
      time <- system.time(for (n in 1:3) {
        island_tbl <- DAISIEprep::extract_island_species(
          phylod = phylod,
          extraction_method = extraction_method,
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

  # extract data
  mean_times <- lapply(times_list, "[[", "mean_times")
  params <- lapply(times_list, "[[", "parameters")

  # remove any element elements from list
  mean_times[sapply(mean_times, is.null)] <- NULL

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
