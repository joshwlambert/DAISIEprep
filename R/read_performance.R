read_performance <- function() {
  # load all the files from the path
  performance_data_files <- list.files(
    path = system.file("performance_data", package = "DAISIEprepExtra")
  )
  if (length(performance_data_files) == 0) {
    stop("No results are in the results directory")
  } else {
    file_paths <- as.list(paste0(
      system.file("performance_data", package = "DAISIEprepExtra"),
      "/",
      performance_data_files
    ))

    empirical_file_path <- grep(pattern = "empirical", x = file_paths)
    performance_empirical <- file_paths[[empirical_file_path]]
    file_paths <- file_paths[-empirical_file_path]

    performance_data <- lapply(file_paths, readRDS)
    performance_empirical <- readRDS(performance_empirical)
  }
}
