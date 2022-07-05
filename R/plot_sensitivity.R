#' Plots
#'
#' @return ggplot2 object
#' @keywords internal
plot_sensitivity <- function(sensitivity_data) {

  sensitivity <- ggplot2::ggplot(sensitivity_data) +
    ggplot2::geom_density(
      mapping = ggplot2::aes(rates, fill = extraction),
      alpha = 0.5
    ) +
    ggplot2::scale_x_continuous(name = "Rate") +
    ggplot2::scale_y_continuous(name = "Density") +
    ggplot2::scale_fill_discrete(
      name = "Extraction Method",
      type = c("#FF0000", "#00A08A", "#F2AD00", "#F98400", "#5BBCD6"),
      labels = c("min", "ASR (parsimony)", "ASR (Mk)")) +
    ggplot2::theme_classic() +
    ggplot2::facet_wrap(
      facets = "parameter",
      scales = "free",
      labeller = ggplot2::as_labeller(c(
        dna_ana = "Anagenesis",
        dna_clado = "Cladogenesis",
        dna_ext = "Extinction",
        dna_immig =  "Colonisation")
      )
    ) +
    ggplot2::theme(strip.background = ggplot2::element_blank(),
                   strip.text = ggtext::element_markdown())


  # return sensitivity plot
  sensitivity
}




