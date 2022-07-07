#' Plots
#'
#' @return ggplot2 object
#' @keywords internal
plot_sensitivity <- function(sensitivity_data) {


  # # store parameter estimates and parameters in tibble
  # sensitivity_data <- tibble::as_tibble(sensitivity_data)
  #
  # # merge extraction_method, asr_method and tie_preference for dna data
  # dna_data <- tidyr::unite(
  #   data = dna_data,
  #   col = extraction,
  #   extraction_method:tie_preference
  # )
  #
  # # merge extraction_method, asr_method and tie_preference for complete data
  # complete_data <- tidyr::unite(
  #   data = complete_data,
  #   col = extraction,
  #   extraction_method:tie_preference
  # )
  #
  #
  #
  # # tidy complete data
  # complete_data <- tidyr::pivot_longer(
  #   data = complete_data,
  #   names_to = "parameter",
  #   clado:ana,
  #   values_to = "rates"
  # )
  #
  # # check whether data using tie_preference of island or mainland makes a
  # # difference to the rates estimated from DAISIE. If they are all identical
  # # they can be removed from the data as the density plots will completely overlap
  #
  # which_asr_mk_island <- which(
  #   dna_data$extraction == "asr_mk_island"
  # )
  # which_asr_mk_mainland <- which(
  #   dna_data$extraction == "asr_mk_mainland"
  # )
  # identical_mk <- identical(
  #   dna_data[which_asr_mk_island, "rates"],
  #   dna_data[which_asr_mk_mainland, "rates"]
  # )
  #
  # which_asr_parsimony_island <- which(
  #   dna_data$extraction == "asr_parsimony_island"
  # )
  # which_asr_parsimony_mainland <- which(
  #   dna_data$extraction == "asr_parsimony_mainland"
  # )
  # identical_parsimony <- identical(
  #   dna_data[which_asr_parsimony_island, "rates"],
  #   dna_data[which_asr_parsimony_mainland, "rates"]
  # )
  #
  #
  # if (identical_mk && identical_parsimony) {
  #   dna_data <- dplyr::slice(
  #     dna_data,
  #     -which(
  #       dna_data$extraction %in%
  #         c("asr_mk_mainland", "asr_parsimony_mainland")
  #     )
  #   )
  # }
  #
  # which_asr_mk_island <- which(
  #   complete_data$extraction == "asr_mk_island"
  # )
  # which_asr_mk_mainland <- which(
  #   complete_data$extraction == "asr_mk_mainland"
  # )
  # identical_mk <- identical(
  #   complete_data[which_asr_mk_island, "rates"],
  #   complete_data[which_asr_mk_mainland, "rates"]
  # )
  #
  # which_asr_parsimony_island <- which(
  #   complete_data$extraction == "asr_parsimony_island"
  # )
  # which_asr_parsimony_mainland <- which(
  #   complete_data$extraction == "asr_parsimony_mainland"
  # )
  # identical_parsimony <- identical(
  #   complete_data[which_asr_parsimony_island, "rates"],
  #   complete_data[which_asr_parsimony_mainland, "rates"]
  # )
  #
  #
  # if (identical_mk && identical_parsimony) {
  #   complete_data <- dplyr::slice(
  #     complete_data,
  #     -which(
  #       complete_data$extraction %in%
  #         c("asr_mk_mainland", "asr_parsimony_mainland")
  #     )
  #   )
  # }
  #
  # # return a list of tibbles for dna and complete data
  # list(
  #   dna_data = dna_data,
  #   complete_data = complete_data
  # )
  #
  # sensitivity <- ggplot2::ggplot(sensitivity_data) +
  #   ggplot2::geom_density(
  #     mapping = ggplot2::aes(rates, fill = extraction),
  #     alpha = 0.5
  #   ) +
  #   ggplot2::scale_x_continuous(name = "Rate") +
  #   ggplot2::scale_y_continuous(name = "Density") +
  #   ggplot2::scale_fill_discrete(
  #     name = "Extraction Method",
  #     type = c("#FF0000", "#00A08A", "#F2AD00", "#F98400", "#5BBCD6"),
  #     labels = c("min", "ASR (parsimony)", "ASR (Mk)")) +
  #   ggplot2::theme_classic() +
  #   ggplot2::facet_wrap(
  #     facets = "parameter",
  #     scales = "free",
  #     labeller = ggplot2::as_labeller(c(
  #       dna_ana = "Anagenesis",
  #       dna_clado = "Cladogenesis",
  #       dna_ext = "Extinction",
  #       dna_immig =  "Colonisation")
  #     )
  #   ) +
  #   ggplot2::theme(strip.background = ggplot2::element_blank())
  #
  #
  # # return sensitivity plot
  # sensitivity
}




