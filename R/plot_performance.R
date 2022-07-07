plot_performance <- function() {

  # # tidy empirical data
  #
  # mean_times_min_dna <- performance_empirical$mean_times_min_dna
  # mean_times_min_complete <- performance_empirical$mean_times_min_complete
  # mean_times_asr_dna <- performance_empirical$mean_times_asr_dna
  # mean_times_asr_complete <- performance_empirical$mean_times_asr_complete
  #
  # extraction_method <- c(
  #   rep("min", length(mean_times_min_dna)),
  #   rep("min", length(mean_times_min_complete)),
  #   rep("asr", length(mean_times_asr_dna)),
  #   rep("asr", length(mean_times_asr_complete))
  # )
  #
  # tree_type <- c(
  #   rep("dna", length(mean_times_min_dna)),
  #   rep("complete", length(mean_times_min_complete)),
  #   rep("dna", length(mean_times_asr_dna)),
  #   rep("complete", length(mean_times_asr_complete))
  # )
  #
  # tree_size <- c(
  #   rep(4099, length(mean_times_min_dna)),
  #   rep(5911, length(mean_times_min_complete)),
  #   rep(4099, length(mean_times_asr_dna)),
  #   rep(5911, length(mean_times_asr_complete))
  # )
  #
  # mean_times <- c(
  #   mean_times_min_dna,
  #   mean_times_min_complete,
  #   mean_times_asr_dna,
  #   mean_times_asr_complete
  # )
  #
  # empirical_results <- tibble::tibble(
  #   mean_times = mean_times,
  #   extraction_method = extraction_method,
  #   tree_type = tree_type,
  #   tree_size = tree_size
  # )
  #
  # grouped_empirical_results <- dplyr::group_by(
  #   empirical_results,
  #   tree_size,
  #   tree_type
  # )
  #
  # mean_empirical_results <- dplyr::summarise(
  #   grouped_empirical_results,
  #   mean = mean(mean_times),
  #   .groups = "drop"
  # )
  # sd_empirical_results <- dplyr::summarise(
  #   grouped_empirical_results,
  #   sd = sd(mean_times),
  #   .groups = "drop"
  # )
  #
  # summary_empirical_results <- dplyr::right_join(
  #   mean_empirical_results,
  #   sd_empirical_results,
  #   by = c("tree_size", "tree_type")
  # )
  #
  # min <- lapply(performance_data, "[[", "min")
  #
  # asr <- lapply(performance_data, "[[", "asr")
  #
  # parameter <- lapply(performance_data, "[[", "parameter_index")
  #
  # parameter_space <- expand.grid(
  #   tree_size = c(10, 50, 100, 500, 1000, 5000, 10000),
  #   prob_on_island = c(0.2, 0.5),
  #   prob_endemic = c(0.2, 0.8)
  # )
  #
  # parameter <- lapply(parameter, function(x) {
  #   parameter_space[x, ]
  # })
  #
  # tree_size <- sapply(parameter, "[[", "tree_size")
  # prob_on_island <- sapply(parameter, "[[", "prob_on_island")
  # prob_endemic <- sapply(parameter, "[[", "prob_endemic")
  #
  # results <- tibble::tibble(
  #   tree_size = rep(tree_size, each = 10),
  #   prob_on_island = rep(prob_on_island, each = 10),
  #   prob_endemic = rep(prob_endemic, each = 10),
  #   time_min = unlist(min),
  #   time_asr = unlist(asr)
  # )
  #
  # results <- tidyr::pivot_longer(
  #   data = results,
  #   names_to = "extraction",
  #   time_min:time_asr,
  #   values_to = "time"
  # )
  #
  # grouped_results <- dplyr::group_by(results, tree_size, prob_on_island)
  # mean_results <- dplyr::summarise(
  #   grouped_results,
  #   mean = mean(time),
  #   .groups = "drop"
  # )
  # sd_results <- dplyr::summarise(
  #   grouped_results,
  #   sd = sd(time),
  #   .groups = "drop"
  # )
  #
  # summary_results <- dplyr::right_join(
  #   mean_results,
  #   sd_results,
  #   by = c("tree_size", "prob_on_island")
  # )
  #
  # summary_results$prob_on_island <- as.factor(summary_results$prob_on_island)
  #
  # performance_prob_on_island <- ggplot2::ggplot(data = summary_results) +
  #   ggplot2::geom_point(
  #     mapping = ggplot2::aes(
  #       x = tree_size,
  #       y = mean,
  #       colour = prob_on_island
  #     ),
  #     position = ggplot2::position_dodge(width = 0.5),
  #     size = 2,
  #   ) +
  #   ggplot2::geom_errorbar(
  #     mapping = ggplot2::aes(
  #       x = tree_size,
  #       y = mean,
  #       ymin = pmax(0.01, mean-sd),
  #       ymax = mean+sd,
  #       colour = prob_on_island
  #     ),
  #     position = ggplot2::position_dodge(width = 0.5),
  #     width = 0.3
  #   ) +
  #   ggplot2::theme_classic() +
  #   ggplot2::scale_x_continuous(
  #     name = "Tree Size (num. tips)",
  #     trans = "log",
  #     breaks = scales::breaks_log()
  #   ) +
  #   ggplot2::scale_y_continuous(
  #     name = "Mean run time (seconds)",
  #     trans = "log",
  #     breaks = scales::breaks_log(),
  #     labels = scales::comma_format(accuracy = 0.1)
  #   ) +
  #   ggplot2::scale_colour_discrete(
  #     name = "Probability on the island",
  #     type = c("#046C9A", "#D69C4E", "#ECCBAE", "#ABDDDE", "#000000"))
  #
  #
  # performance_prob_on_island <- performance_prob_on_island +
  #   ggplot2::geom_point(
  #     data = summary_empirical_results,
  #     mapping = ggplot2::aes(
  #       x = tree_size,
  #       y = mean,
  #       colour = tree_type),
  #     size = 2
  #   ) +
  #   ggplot2::geom_errorbar(
  #     data = summary_empirical_results,
  #     mapping = ggplot2::aes(
  #       x = tree_size,
  #       y = mean,
  #       ymin = mean-sd,
  #       ymax = mean+sd,
  #       colour = tree_type
  #     ),
  #     width = 0.3
  #   )
  #
  # grouped_results <- dplyr::group_by(results, tree_size, prob_endemic)
  # mean_results <- dplyr::summarise(
  #   grouped_results,
  #   mean = mean(time),
  #   .groups = "drop"
  # )
  # sd_results <- dplyr::summarise(
  #   grouped_results,
  #   sd = sd(time),
  #   .groups = "drop"
  # )
  #
  # summary_results <- dplyr::right_join(
  #   mean_results,
  #   sd_results,
  #   by = c("tree_size", "prob_endemic")
  # )
  #
  # summary_results$prob_endemic <- as.factor(summary_results$prob_endemic)
  #
  # performance_prob_endemic <- ggplot2::ggplot(data = summary_results) +
  #   ggplot2::geom_point(
  #     mapping = ggplot2::aes(
  #       x = tree_size,
  #       y = mean,
  #       colour = prob_endemic
  #     ),
  #     position = ggplot2::position_dodge(width = 0.5),
  #     size = 2,
  #   ) +
  #   ggplot2::geom_errorbar(
  #     mapping = ggplot2::aes(
  #       x = tree_size,
  #       y = mean,
  #       ymin = pmax(0, mean-sd),
  #       ymax = mean+sd,
  #       colour = prob_endemic
  #     ),
  #     position = ggplot2::position_dodge(width = 0.5),
  #     width = 0.3
  #   ) +
  #   ggplot2::theme_classic() +
  #   ggplot2::scale_x_continuous(
  #     name = "Tree Size (num. tips)",
  #     trans = "log",
  #     breaks = scales::breaks_log()
  #   ) +
  #   ggplot2::scale_y_continuous(
  #     name = "Mean run time (seconds)",
  #     trans = "log",
  #     breaks = scales::breaks_log(),
  #     labels = scales::comma_format(accuracy = 0.1)
  #   ) +
  #   ggplot2::scale_colour_discrete(
  #     name = "Probability endemic",
  #     type = c("#D8B70A", "#02401B"))

}
