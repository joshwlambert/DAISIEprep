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

  unique_island_species <- unique(unlist(island_tbl@island_tbl$species))

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
    # oldest and largest clade index can differ if both clades have the same
    # number of species, which.max() returns first match which may differ from
    # oldest clade
    num_unique_clade_size <- length(unique(lengths(dup_island_tbl$species)))
    if (!identical(oldest_clade, largest_clade) && num_unique_clade_size > 1) {
      warning(
        "When removing duplicate species from nested clades in the island_tbl ",
        "the oldest clade and largest clade do not match and the clades ",
        "containing the duplicate species are different sizes. \n This is ",
        "likely due to the oldest clade already having duplicate species ",
        "removed."
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

  if (!all(unlist(island_tbl@island_tbl$species) %in% unique_island_species)) {
    stop(
      "When removing duplicate species from island_tbl the unique species ",
      "list does not match the island_tbl species list"
    )
  }

  return(island_tbl)
}
