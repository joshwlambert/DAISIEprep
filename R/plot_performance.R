#' Plots performance results for a grouping variable (prob_on_island or
#' prob_endemic).
#'
#' @param performance_data Tibble of collated performance results
#' @param group_by A variable to partition by for plotting. Uses data masking
#' so variable does not need to be quoted.
#'
#' @return ggplot2 object
#' @importFrom rlang :=
#' @export
#'
#' @examples
#' performance_data <- DAISIEprep:::read_performance()
#' plot_performance(
#'   performance_data = performance_data$performance_data_asr,
#'   group_by = prob_on_island
#' )
#' plot_performance(
#'   performance_data = performance_data$performance_data_min,
#'   group_by = prob_endemic
#' )
plot_performance <- function(performance_data,
                             group_by) {

  # Fix build warnings
  tree_size <- NULL; rm(tree_size) # nolint
  median_time <- NULL; rm(median_time) # nolint
  sd <- NULL; rm(sd) # nolint

  # store parameter estimates and parameters in tibble
  performance_data <- tibble::as_tibble(performance_data)

  grouped_performance_data <- dplyr::group_by(
    performance_data,
    tree_size,
    {{ group_by }}
  )

  mean_performance_data <- dplyr::summarise(
    grouped_performance_data,
    mean = mean(median_time),
    .groups = "drop"
  )
  sd_performance_data <- dplyr::summarise(
    grouped_performance_data,
    sd = stats::sd(median_time),
    .groups = "drop"
  )

  group_by_var <- rlang::set_names(rlang::as_string(rlang::ensym(group_by)))

  summary_performance_data <- dplyr::right_join(
    mean_performance_data,
    sd_performance_data,
    by = c("tree_size", group_by_var)
  )

  summary_performance_data <- dplyr::mutate(
    summary_performance_data,
    "{{ group_by }}" := factor({{ group_by }}),
    .keep = "unused"
  )

  # create legend title depending on grouping variable
  if (grepl(pattern = "island", x = group_by_var)) {
    legend_title <- "Probability on the island"
  } else {
    legend_title <- "Probability endemic"
  }

  # create plot
  performance_plot <- ggplot2::ggplot(summary_performance_data) +
    ggplot2::geom_point(
      mapping = ggplot2::aes(
        x = tree_size,
        y = mean,
        colour = {{ group_by }}
      ),
      position = ggplot2::position_dodge(width = 0.5),
      size = 2
    ) +
    ggplot2::geom_errorbar(
      mapping = ggplot2::aes(
        x = tree_size,
        y = mean,
        ymin = mean-sd,
        ymax = mean+sd,
        colour = {{ group_by }}
      ),
      position = ggplot2::position_dodge(width = 0.5),
      width = 0.3
    ) +
    ggplot2::theme_classic() +
    ggplot2::scale_x_continuous(
      name = "Tree Size (number of tips)",
      trans = "log",
      breaks = scales::breaks_log()
    ) +
    ggplot2::scale_y_continuous(
      name = "Mean run time (seconds)",
      trans = "log",
      breaks = scales::breaks_log()
    ) +
    ggplot2::scale_colour_discrete(
      name = legend_title,
      type = c("#046C9A", "#D69C4E", "#ECCBAE", "#ABDDDE", "#000000")
    )

  # return performance plot
  performance_plot
}
