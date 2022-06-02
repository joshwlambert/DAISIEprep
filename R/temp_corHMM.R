# set.seed(1985)
# require(ape)
# require(expm)
# require(corHMM)
# data(primates)
# phy <- primates[[1]]
# phy <- multi2di(phy)
# data <- primates[[2]]
# plot(phy, show.tip.label = FALSE)
# data.sort <- data.frame(data[, 2], data[, 3], row.names = data[, 1])
# data.sort <- data.sort[phy$tip.label, ]
# tiplabels(pch = 16, col = data.sort[, 1] + 1, cex = 0.5)
# tiplabels(pch = 16, col = data.sort[, 2] + 3, cex = 0.5, offset = 0.5)
# MK_3state <- corHMM(phy = phy, data = data, rate.cat = 1)
# phy = MK_3state$phy
# data = MK_3state$data
# model = MK_3state$solution
# model[is.na(model)] <- 0
# diag(model) <- -rowSums(model)
# # run get simmap (can be plotted using phytools)
# simmap <- makeSimmap(tree = phy, data = data, model = model, rate.cat = 1, nSim = 1,
#                      nCores = 1)
# # we import phytools plotSimmap for plotting
# phytools::plotSimmap(simmap[[1]], fsize = 0.5)
