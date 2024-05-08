#' Remove any duplicated species from the `island_tbl` after `"asr"` extraction
#'
#' @description
#' Removes any duplicates species from the `island_tbl` by choosing to either
#' have duplicated species be in smaller, more recently colonised clade(s) and
#' removing them from the larger, older clade(s)
#' (`nested_asr_species = "split"`), or removing the smaller, more recently
#' colonised clade(s) in favour of leaving them in the larger, older clade(s)
#' (`nested_asr_species = "group"`).
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `Island_tbl` class
#' @keywords internal
rm_duplicate_island_species <- function(island_tbl,
                                        phylod,
                                        nested_asr_species,
                                        include_not_present) {

  if (anyDuplicated(unlist(island_tbl@island_tbl$species)) == 0L) {
    return(island_tbl)
  }

  while(anyDuplicated(unlist(island_tbl@island_tbl$species)) != 0L) {

    island_species <- island_tbl@island_tbl$species
    duplicate_species <- duplicated(unlist(island_species))
    duplicate_species_name <- unlist(island_species)[duplicate_species]
    # subset to first or only duplicated species, while loop with get to others
    duplicate_species_name <- duplicate_species_name[1]
    duplicate_species_clade <- vapply(
      island_species,
      function(x, duplicate_species_name) duplicate_species_name %in% x,
      FUN.VALUE = logical(1),
      duplicate_species_name = duplicate_species_name
    )
    dup_island_tbl <- island_tbl@island_tbl[duplicate_species_clade, ]

    oldest_clade <- which.max(dup_island_tbl$col_time)
    largest_clade <- which.max(lengths(dup_island_tbl$species))
    if (!identical(oldest_clade, largest_clade)) {
      stop(
        "When removing duplicate species from island_tbl the nested clade",
        "is not the oldest or largest"
      )
    }

    if (nested_asr_species == "split") {
      # remove species name from species col
      clade_names <- setdiff(
        dup_island_tbl$species[[oldest_clade]],
        duplicate_species_name
      )
      # get clade from extracted species
      clade <- as.numeric(names(
        phylod@label[which(phylod@label %in% clade_names)]
      ))
      names(clade) <- clade_names

      if (length(clade) == 1) {
        if (dup_island_tbl$status[oldest_clade] == "nonendemic") {
          # extract singleton nonendemic
          island_colonist <- extract_nonendemic(
            phylod = phylod,
            species_label = dup_island_tbl$clade_name[oldest_clade]
          )
        } else if (dup_island_tbl$status[oldest_clade] == "endemic") {
          #extract singleton endemic
          island_colonist <- extract_endemic_singleton(
            phylod = phylod,
            species_label = dup_island_tbl$clade_name[oldest_clade]
          )
        } else {
          stop(
            "Endemicity status not recognised when removing duplicate species."
          )
        }
      } else if (length(clade) > 1) {
        # re-extact clade without duplicated species
        island_colonist <- extract_asr_clade(
          phylod = phylod,
          species_label = dup_island_tbl$clade_name[oldest_clade],
          clade = clade,
          include_not_present = include_not_present
        )
      } else {
        stop("Size of island clade after removing duplicates is zero.")
      }

      # remove previously extracted clade
      clade_row <- which(duplicate_species_clade)[oldest_clade]
      island_tbl@island_tbl <- island_tbl@island_tbl[-clade_row, ]
      # bind data from island_colonist class into island_tbl class
      island_tbl <- bind_colonist_to_tbl(
        island_colonist = island_colonist,
        island_tbl = island_tbl
      )

    } else if (nested_asr_species == "group") {
      clade_row <- which.min(lengths(dup_island_tbl$species))
      recent_col <- which(duplicate_species_clade)[clade_row]
      # remove row with recent colonist
      island_tbl@island_tbl <- island_tbl@island_tbl[-recent_col, ]
      row.names(island_tbl@island_tbl) <- NULL
    }
  }

  return(island_tbl)
}
