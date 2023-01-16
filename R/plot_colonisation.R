#' Plots a dot plot (cleveland dot plot when include_crown_age = TRUE) of the
#' stem and potentially crown ages of a community of island colonists.
#'
#' @inheritParams default_params_doc
#'
#' @return `ggplot` object
#' @export
#'
#' @examples
#' set.seed(
#'   1,
#'   kind = "Mersenne-Twister",
#'   normal.kind = "Inversion",
#'   sample.kind = "Rejection"
#' )
#' phylo <- ape::rcoal(10)
#' phylo$tip.label <- c("bird_a", "bird_b", "bird_c", "bird_d", "bird_e",
#'                      "bird_f", "bird_g", "bird_h", "bird_i", "bird_j")
#' phylo <- phylobase::phylo4(phylo)
#' endemicity_status <- sample(
#'   c("not_present", "endemic", "nonendemic"),
#'   size = length(phylobase::tipLabels(phylo)),
#'   replace = TRUE,
#'   prob = c(0.6, 0.2, 0.2)
#' )
#' phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
#' island_tbl <- extract_island_species(phylod, extraction_method = "min")
#' plot_colonisation(island_tbl, island_age = 2)
plot_colonisation <- function(island_tbl,
                               island_age,
                               include_crown_age = TRUE) {

  # write check for island_tbl is correct class, island_age is numeric and include_crown_age is boolean
  if (!inherits(island_tbl, "Island_tbl")) {
    stop("island_tbl must be an object of class Island_tbl")
  }
  if (!is.numeric(island_age)) {
    stop("island_age must be numeric")
  }
  if (!is.logical(include_crown_age)) {
    stop("include_crown_age must be either TRUE or FALSE")
  }


  # convert island_tbl to daisie_datatable
  daisie_datatable <- as_daisie_datatable(
    island_tbl = island_tbl,
    island_age = island_age
  )

  # generate clade names for each branching time for tidy data
  clade_names <- c()
  colonisation_times <- c()
  stem_or_crown_age <- c()
  for (i in seq_len(nrow(daisie_datatable))) {
    island_clade <- length(daisie_datatable$Branching_times[[i]]) > 1
    if (island_clade && include_crown_age) {
      clade_names <- c(clade_names, rep(daisie_datatable$Clade_name[i], 2))
      temp_colonisation_time <- daisie_datatable$Branching_times[[i]][1]
      temp_crown_age <- daisie_datatable$Branching_times[[i]][2]
      if (temp_colonisation_time > island_age) {
        if (temp_crown_age > island_age) {
          colonisation_times <- c(
            colonisation_times,
            island_age
          )
          stem_or_crown_age <- c(stem_or_crown_age, "stem")
        } else {
          colonisation_times <- c(
            colonisation_times,
            c(island_age, temp_crown_age)
          )
          stem_or_crown_age <- c(stem_or_crown_age, c("stem", "crown"))
        }
      } else {
        colonisation_times <- c(
          colonisation_times,
          daisie_datatable$Branching_times[[i]][1:2]
        )
        stem_or_crown_age <- c(stem_or_crown_age, c("stem", "crown"))
      }
    } else {
      clade_names <- c(clade_names, daisie_datatable$Clade_name[i])
      temp_colonisation_time <- daisie_datatable$Branching_times[[i]][1]
      if (temp_colonisation_time > island_age) {
        colonisation_times <- c(
          colonisation_times,
          island_age
        )
      } else {
        colonisation_times <- c(
          colonisation_times,
          daisie_datatable$Branching_times[[i]][1]
        )
      }
      stem_or_crown_age <- c(stem_or_crown_age, "stem")
    }
  }

  # make colonisation data frame for plotting
  colonisations <- data.frame(
    clade_names = gsub(pattern = "_", replacement = " ", x = clade_names),
    colonisation_times = colonisation_times,
    stem_or_crown_age = stem_or_crown_age
  )

  # make maximum
  max_xlim <- max(colonisations$branching_times, island_age)

  if (!all(colonisations$stem_or_crown_age == "stem")) {
    p <- ggplot2::ggplot(data = colonisations) +
      ggplot2::geom_line(mapping = ggplot2::aes(
        x = colonisation_times,
        y = stats::reorder(clade_names, colonisation_times),
        group = clade_names)) +
      ggplot2::geom_point(mapping = ggplot2::aes(
        x = colonisation_times,
        y = stats::reorder(clade_names, colonisation_times),
        colour = stem_or_crown_age),
        size = 3
      ) +
      ggplot2::geom_vline(
        xintercept = island_age,
        linetype = "dashed",
        colour = "grey"
      ) +
      ggplot2::theme_classic() +
      ggplot2::ylab("Island colonist") +
      ggplot2::xlab("Colonisation time (Million years ago)") +
      ggplot2::labs(colour = "Colonisation type") +
      ggplot2::scale_x_continuous(
        limits = c(max_xlim, 0),
        trans = "reverse"
      ) +
      ggplot2::scale_y_discrete(limits = rev) +
      ggplot2::theme(legend.position = c(0.3, 0.8)) +
      ggplot2::scale_color_brewer(
        palette = "Set1",
        labels = c("Crown Age", "Stem age")
      )
  } else {
    p <- ggplot2::ggplot(data = colonisations) +
      ggplot2::geom_point(mapping = ggplot2::aes(
        x = colonisation_times,
        y = stats::reorder(clade_names, colonisation_times),
        colour = stem_or_crown_age),
        size = 3
      ) +
      ggplot2::geom_vline(
        xintercept = island_age,
        linetype = "dashed",
        colour = "grey"
      ) +
      ggplot2::theme_classic() +
      ggplot2::ylab("Island colonist") +
      ggplot2::xlab("Colonisation time (Million years ago)") +
      ggplot2::labs(colour = "Colonisation type") +
      ggplot2::scale_x_continuous(
        limits = c(max_xlim, 0),
        trans = "reverse"
      ) +
      ggplot2::scale_y_discrete(limits = rev) +
      ggplot2::theme(legend.position = c(0.3, 0.8)) +
      ggplot2::scale_color_brewer(
        palette = "Set1",
        labels = c("Stem age")
      )
  }

  # return plot
  p
}
