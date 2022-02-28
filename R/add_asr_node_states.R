#' Fits a model of ancestral state reconstruction of island presence
#'
#' @inheritParams default_params_doc
#'
#' @return An object of `phylo4d` class with tip and node data
#' @export
#'
#' @examples
#' \dontrun{
#' #WIP
#' }
add_asr_node_states <- function(phylod,
                                asr_method,
                                tie_preference = "island",
                                earliest_col = FALSE) {

  # add one as the asr method cannot handle zero as a state
  tip_states <-
    as.numeric(grepl(
      pattern = "endemic",
      x = phylobase::tipData(phylod)$endemicity_status
    )) + 1

  # castor asr functions require S3 phylo objects
  phylo <- methods::as(phylo, "phylo")

  if (asr_method == "parsimony") {
    asr <- castor::asr_max_parsimony(tree = phylo, tip_states = tip_states)
  } else if (asr_method == "mk") {
    asr <- castor::asr_mk_model(tree = phylo, tip_states = tip_states)
  }

  colnames(asr$ancestral_likelihoods) <- c("not_present", "island")

  if (isFALSE(earliest_col)) {
    if (tie_preference == "island") {
      node_states <- max.col(asr$ancestral_likelihoods, ties.method = "last")
    } else if (tie_preference == "mainland") {
      node_states <- max.col(asr$ancestral_likelihood, ties.method = "first")
    }
  } else if (isTRUE(earliest_col)) {
    # colonisation time is the first non-zero probability of island presence
    node_states <- apply(
      X = asr$ancestral_likelihoods,
      MARGIN = 1,
      FUN = function(x) {
        island_presense <- (x[2] > 0) + 1
      }
    )
  }

  # convert numeric to string
  node_states <- gsub(
    pattern = "2", replacement = "island", x = node_states
  )
  node_states <- gsub(
    pattern = "1", replacement = "not_present", x = node_states
  )

  # combine node data into phylod
  node_data <- data.frame(
    island_status = node_states,
    row.names = phylobase::nodeId(phylod, "internal")
  )

  tip_data <- data.frame(
    endemicity_status = phylobase::tipData(phylod)$endemicity_status,
    row.names = phylobase::nodeId(phylod, "tip")
  )

  phylod <- phylobase::phylo4d(
    phylo,
    tip.data = tip_data,
    node.data = node_data
  )

  # return phylod object
  phylod
}



