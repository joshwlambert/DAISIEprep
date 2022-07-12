#' Plots
#'
#' @return ggplot2 object
#' @keywords internal
plot_sensitivity <- function(sensitivity_data,
                             pairwise_diffs = FALSE) {

  # Fix build warnings
  extraction <- NULL; rm(extraction) # nolint
  extraction_method <- NULL; rm(extraction_method) # nolint
  tie_preference <- NULL; rm(tie_preference) # nolint
  parameter <- NULL; rm(parameter) # nolint
  phylo_index <- NULL; rm(phylo_index) # nolint
  rates <- NULL; rm(rates) # nolint

  # store parameter estimates and parameters in tibble
  sensitivity_data <- tibble::as_tibble(sensitivity_data)

  # merge extraction_method, asr_method and tie_preference
  sensitivity_data <- tidyr::unite(
    data = sensitivity_data,
    col = extraction,
    extraction_method:tie_preference
  )

  # remove carrying capacity for plotting
  sensitivity_data <- dplyr::filter(sensitivity_data, parameter != "k")

  if (pairwise_diffs) {

    sensitivity_data <- dplyr::bind_cols(
      sensitivity_data,
      phylo_index = as.factor(rep(1:100, each = 12))
    )

    sensitivity <- ggplot2::ggplot(data = sensitivity_data) +
      ggplot2::geom_point(mapping = ggplot2::aes(
        x = phylo_index,
        y = rates,
        colour = extraction
      )) +
      ggplot2::scale_y_continuous(
        name = "Rates",
        breaks = scales::log_breaks(),
        trans = "log") +
      ggplot2::scale_x_discrete(
        name = "Phylogeny from posterior distribution"
      ) +
      ggplot2::scale_color_discrete(
        name = "Extraction Method",
        type = c("#FF0000", "#00A08A", "#F2AD00", "#F98400", "#5BBCD6"),
        labels = c("ASR (Mk)", "ASR (parsimony)", "min")
      ) +
      ggplot2::facet_wrap(
        facets = "parameter",
        scales = "free", labeller = ggplot2::as_labeller(c(
          ana = "Anagenesis",
          clado = "Cladogenesis",
          ext = "Extinction",
          immig =  "Colonisation")
        ), strip.position = "bottom"
      ) +
      ggplot2::theme_classic() +
      ggplot2::theme(
        strip.background = ggplot2::element_blank(),
        strip.placement = "outside",
        axis.text.x = ggplot2::element_blank()
      )

  } else {

  sensitivity <- ggplot2::ggplot(sensitivity_data) +
    ggplot2::geom_density(
      mapping = ggplot2::aes(rates, fill = extraction),
      alpha = 0.5
    ) +
    ggplot2::scale_x_continuous(name = "Rate", breaks = scales::log_breaks(),
                                trans = "log") +
    ggplot2::scale_y_continuous(name = "Density") +
    ggplot2::scale_fill_discrete(
      name = "Extraction Method",
      type = c("#FF0000", "#00A08A", "#F2AD00", "#F98400", "#5BBCD6"),
      labels = c("min", "ASR (Mk)", "ASR (parsimony)")) +
    ggplot2::theme_classic() +
    ggplot2::facet_wrap(
      facets = "parameter",
      scales = "free",
      labeller = ggplot2::as_labeller(c(
        ana = "Anagenesis",
        clado = "Cladogenesis",
        ext = "Extinction",
        immig =  "Colonisation")
      ),
      strip.position = "bottom"
    ) +
    ggplot2::theme(
      strip.background = ggplot2::element_blank(),
      strip.placement = "outside"
    )
}

  # return sensitivity plot
  sensitivity
}




