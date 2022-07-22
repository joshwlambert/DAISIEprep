#' Reads in performance analysis results from inst/performance_data and formats
#' the data ready for plotting
#'
#' @return List of two data frames
#' @keywords internal
read_performance <- function() {
  # load all the files from the path
  performance_data_files <- list.files(
    path = system.file(
      "performance_data",
      package = "DAISIEprep",
      mustWork = TRUE
    )
  )
  if (length(performance_data_files) == 0) {
    stop("No results are in the results directory")
  } else {
    file_paths <- as.list(paste0(
      system.file("performance_data", package = "DAISIEprep", mustWork = TRUE),
      "/",
      performance_data_files
    ))

    empirical_file_path <- grep(pattern = "empirical", x = file_paths)
    performance_empirical <- file_paths[[empirical_file_path]]
    file_paths <- file_paths[-empirical_file_path]

    performance_data <- lapply(file_paths, readRDS)
    performance_empirical <- readRDS(performance_empirical)
  }

  # unpack list of results to merge tibbles
  performance_data_min <- lapply(performance_data, "[[", "performance_min")
  performance_data_asr <- lapply(performance_data, "[[", "performance_asr")

  # unpack list of empirical results
  performance_empirical_min_dna <- performance_empirical$times_min_dna
  performance_empirical_min_complete <- performance_empirical$times_min_complete
  performance_empirical_asr_dna <- performance_empirical$times_asr_dna
  performance_empirical_asr_complete <- performance_empirical$times_asr_complete

  # merge list of tibbles
  performance_data_min <- Reduce(rbind, performance_data_min)
  performance_data_asr <- Reduce(rbind, performance_data_asr)
  performance_empirical_min_dna <- Reduce(rbind, performance_empirical_min_dna)
  performance_empirical_min_complete <- Reduce(
    rbind,
    performance_empirical_min_complete
  )
  performance_empirical_asr_dna <- Reduce(rbind, performance_empirical_asr_dna)
  performance_empirical_asr_complete <- Reduce(
    rbind,
    performance_empirical_asr_complete
  )

  # change prob_on_island to factor for simulated data
  performance_data_min$prob_on_island <- factor(performance_data_min$prob_on_island)
  performance_data_asr$prob_on_island <- factor(performance_data_asr$prob_on_island)

  # change prob_endemic to factor for simulated data
  performance_data_min$prob_endemic <- factor(performance_data_min$prob_endemic)
  performance_data_asr$prob_endemic <- factor(performance_data_asr$prob_endemic)

  # change prob_on_island to factor for empirical data
  performance_empirical_min_dna$prob_on_island <- factor("DNA")
  performance_empirical_min_complete$prob_on_island <- factor("complete")
  performance_empirical_asr_dna$prob_on_island <- factor("DNA")
  performance_empirical_asr_complete$prob_on_island <- factor("complete")

  # change prob_endemic to factor for empirical data
  performance_empirical_min_dna$prob_endemic <- factor("DNA")
  performance_empirical_min_complete$prob_endemic <- factor("complete")
  performance_empirical_asr_dna$prob_endemic <- factor("DNA")
  performance_empirical_asr_complete$prob_endemic <- factor("complete")

  # convert to tibble
  performance_data_min <- tibble::as_tibble(performance_data_min)
  performance_data_asr <- tibble::as_tibble(performance_data_asr)
  performance_empirical_min_dna <- tibble::as_tibble(
    performance_empirical_min_dna
  )
  performance_empirical_min_complete <- tibble::as_tibble(
    performance_empirical_min_complete
  )
  performance_empirical_asr_dna <- tibble::as_tibble(
    performance_empirical_asr_dna
  )
  performance_empirical_asr_complete <- tibble::as_tibble(
    performance_empirical_asr_complete
  )

  # merge empirical data for min data
  performance_empirical_min <- dplyr::bind_rows(
    performance_empirical_min_dna,
    performance_empirical_min_complete,
    .id = "tree_type"
  )

  # merge empirical data for asr data
  performance_empirical_asr <- dplyr::bind_rows(
    performance_empirical_asr_dna,
    performance_empirical_asr_complete,
    .id = "tree_type"
  )

  # merge simulated and empirical data for min
  performance_data_min <- dplyr::bind_rows(
    performance_data_min,
    performance_empirical_min
  )

  # merge simulated and empirical data for asr
  performance_data_asr <- dplyr::bind_rows(
    performance_data_asr,
    performance_empirical_asr
  )

  # return list of sensitivity data for dna and complete
  list(
    performance_data_min = performance_data_min,
    performance_data_asr = performance_data_asr
  )
}
