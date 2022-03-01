# library(DAISIEprep)
# library(ape)
# library(phylobase)
# library(ggtree)
# library(castor)
# set.seed(
#   1,
#   kind = "Mersenne-Twister",
#   normal.kind = "Inversion",
#   sample.kind = "Rejection"
# )
# phylo <- ape::rcoal(3)
# phylo$tip.label <- c("bird_a_1", "bird_a_2", "bird_b")
# ape::plot.phylo(phylo)
# phylo <- as(phylo, "phylo4")
# phylobase::plot(phylo)
# endemicity_status <- c("nonendemic", "nonendemic", "not_present")
# phylod <- phylobase::phylo4d(phylo, as.data.frame(endemicity_status))
# ggtree::ggtree(phylod) +
#   ggtree::geom_tippoint(
#     ggplot2::aes(colour = endemicity_status),
#     size = 3
#   ) +
#   ggtree::theme_tree2() +
#   ggtree::geom_tiplab(as_ylab = TRUE)
# tip_states <- as.numeric(grepl(pattern = "endemic", x = endemicity_status)) + 1
# phylo <- as(phylo, "phylo")
# asr <- castor::asr_max_parsimony(phylo, tip_states)
# colnames(asr$ancestral_likelihoods) <- c("not_present", "island")
# asr$ancestral_likelihoods
# node_states <- max.col(asr$ancestral_likelihoods, ties.method = "last")
# node_states <- gsub(pattern = "2", replacement = "island", x = node_states)
# node_states <- gsub(pattern = "1", replacement = "not_present", x = node_states)
# node_data <- data.frame(
#   island_status = node_states,
#   row.names = phylobase::nodeId(phylod, "internal")
# )
# phylod <- phylo4d(
#   phylo,
#   tip.data = as.data.frame(endemicity_status),
#   node.data = node_data
# )
# ggtree::ggtree(phylod) +
#   ggtree::geom_tippoint(
#     ggplot2::aes(colour = endemicity_status),
#     size = 3,
#   ) +
#   ggtree::geom_nodepoint(
#     ggplot2::aes(colour = island_status),
#     size = 3
#   ) +
#   ggtree::theme_tree2() +
#   ggtree::geom_tiplab(as_ylab = TRUE)
#
# node_ids <- phylobase::nodeId(phylod)[which(
#   !is.na(phylobase::tdata(phylod)$island_status)
# )]
#
# node_pies <- data.frame(
#   not_present = asr$ancestral_likelihoods[, "not_present"],
#   island = asr$ancestral_likelihoods[, "island"],
#   node = node_ids)
#
# pies <- ggtree::nodepie(node_pies, cols = 1:2)
#
# p <- ggtree::ggtree(phylod) +
#   ggtree::geom_tippoint(
#     ggplot2::aes(colour = endemicity_status),
#     size = 3
#   )
#
# ggtree::inset(tree_view = p, insets = pies, width = 0.3, height = 0.3)
#
# island_tbl <- extract_island_species(phylod = phylod, extraction_method = "asr")
