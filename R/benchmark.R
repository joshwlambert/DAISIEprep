#' Performance analysis of the extract_island_species() function
#' Uses system.time() for timing for reasons explained here:
#' https://radfordneal.wordpress.com/2014/02/02/inaccurate-results-from-microbenchmark/
#'
#' @param tree_size_range stub
#' @param num_points stub
#' @param prob_on_island stub
#' @param prob_endemic stub
#' @param replicates stub
#' @param extraction_method stub
#' @param asr_method stub
#' @param tie_preference stub
#' @param log_scale stub
#'
#' @return Data frame
#' @export
#'
#' @examples
#' \dontrun{
#' #WIP
#' }
benchmark <- function(tree_size_range,
                      num_points,
                      prob_on_island,
                      prob_endemic,
                      replicates,
                      extraction_method,
                      asr_method,
                      tie_preference,
                      log_scale = TRUE) {

  if (log_scale) {
    tree_size <- exp(seq(from = log(10), to = log(10000), length.out = num_points))
    tree_size <- round(tree_size)
  } else {
    tree_size <- exp(seq(from = 10, to = 10000, length.out = num_points))
    tree_size <- round(tree_size)
  }

  parameter_space <- expand.grid(
    tree_size = tree_size,
    prob_on_island = prob_on_island,
    prob_endemic = prob_endemic
  )

  times_list <- list()
  for (i in seq_len(nrow(parameter_space))) {

    message("Parameter set: ", i, " of ", nrow(parameter_space))

    mean_times <- c()
    for (j in seq_len(replicates)) {

      message("Replicate: ", j, " of ", replicates)

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
      phylod <- DAISIEprep::add_asr_node_states(
        phylod = phylod,
        asr_method = asr_method,
        tie_preference = tie_preference
      )

      # run extraction
      min_time <- system.time(for (n in 1:3) {
        island_tbl_min <- DAISIEprep::extract_island_species(
          phylod = phylod,
          extraction_method = extraction_method,
          island_tbl = NULL,
          include_not_present = FALSE
        )
      })

      mean_times[j] <- min_time["elapsed"] / 3
    }
    times_list[[i]] <- list(min = mean_times_min, asr = mean_times_asr)
  }

  # convert list to data frame
  results <- data.frame(
    parameter_space = rep(1:nrow(parameter_space), each = 2),
    tree_size = rep(parameter_space$tree_size, each = 2),
    prob_on_island = rep(parameter_space$prob_on_island, each = 2),
    prob_endemic = rep(parameter_space$prob_endemic, each = 2),
    extraction_method = rep(c("min", "asr"), nrow(parameter_space))
  )

  times <- unlist(lapply(times_list, function(x) {lapply(x, FUN =  median)}))

  #convert from nanoseconds to seconds
  times <- times / 1e9

  results$mean_time <- times

  # return results
  results
}
