#' Reads in the results from the sensitivity analysis saved in the
#' inst/sensitivity_data folder
#'
#' @return List of of lists with parameter estimates for the mammal DNA-only
#' phylogeny, mammal complete phylogeny and the parameter set used
#' @keywords internal
read_sensitivity <- function() {
  # load all the files from the path
  sensitivity_data_files <- list.files(
    path = system.file(
      "sensitivity_data",
      package = "DAISIEprep",
      mustWork = TRUE
    )
  )
  if (length(sensitivity_data_files) == 0) {
    stop("No results are in the results directory")
  } else {
    file_paths <- as.list(paste0(
      system.file("sensitivity_data", package = "DAISIEprep", mustWork = TRUE),
      "/",
      sensitivity_data_files
    ))
    sensitivity_data <- lapply(file_paths, readRDS)
  }

  # unpack list of results to merge tibbles
  sensitivity_dna <- lapply(sensitivity_data, "[[", "sensitivity_dna")
  sensitivity_complete <- lapply(sensitivity_data, "[[", "sensitivity_complete")

  # merge list of tibbles
  sensitivity_dna <- Reduce(rbind, sensitivity_dna)
  sensitivity_complete <- Reduce(rbind, sensitivity_complete)

  # return list of sensitivity data for dna and complete
  list(
    sensitivity_dna = sensitivity_dna,
    sensitivity_complete = sensitivity_complete
  )
}
