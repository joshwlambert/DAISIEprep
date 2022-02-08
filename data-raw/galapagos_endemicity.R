# this is temp file to hold the file paths
# can be deleted when all the raw data files have been written

columbiformes_tree <- ape::read.nexus(
  file = system.file("extdata", "Columbiformes.tre", package = "DAISIEprep")
)

mimus_tree <- ape::read.nexus(
  file = system.file("extdata", "Mimus.tre", package = "DAISIEprep")
)
myiarchus_tree <- ape::read.nexus(
  file = system.file("extdata", "Myiarchus.tre", package = "DAISIEprep")
)
progne_tree <- ape::read.nexus(
  file = system.file("extdata", "Progne.tre", package = "DAISIEprep")
)

setophaga_tree <- ape::read.nexus(
  file = system.file("extdata", "Setophaga.tre", package = "DAISIEprep")
)
