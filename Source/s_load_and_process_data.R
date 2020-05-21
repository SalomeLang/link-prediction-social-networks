# Copyright (c) 2015. All rights reserved.
####################################################################################################
# Proj: Link Prediction
# Desc: Data processing
# Auth: Bublitz Stefan, Gaegauf Luca, Lang Salome, Sutter Pascal
# Date: 2015/12/07
####################################################################################################

# Set up muticore support
workers <- makeCluster(detectCores())
clusterExport(workers, c("LBrand"))
registerDoParallel(workers)

# Need Vector of loaded packages
packages.loaded <- search()
packages.loaded <- substring(packages.loaded[substr(packages.loaded, 1L, 8L) == "package:"], 9)

# Import data ######################################################################################
# Currently supported data sources: ReadEgoFacebook(), ReadKite(), ReadSlashdot0811(), ReadSlashdot0902 
data.import <- ReadEgoFacebook

# Read in data 
data.full <- data.import()

# Data processing ##################################################################################
# Use cross fold validation to reduce statistical bias
number.folds <- 10
set.seed(1234)
folds <- kfold(data.full, k = number.folds)

# Network consisting of all edges from the data set
net.full <- graph.edgelist(el = as.matrix(data.full), directed = FALSE)

# List consisting of number.folds entries, each entry containing a network with all vertices from 
#   the data set, but only a subset of its edges (1 fold being deleted)
net.train <- foreach(j = 1:number.folds, .packages = packages.loaded,.export ) %dopar% CreateTrainNetwork(net.full, data.full[folds == j, ])

# Store information about algorithm for further use in evaluation
if (identical(data.import, ReadKite)) {
  data.information <- c("Dataset used: Kite")
} else if (identical(data.import, ReadEgoFacebook)) {
  data.information <- c("Dataset used: EgoFacebook")
} else if (identical(data.import, ReadSlashdot0811)) {
  data.information <- c("Dataset used: Slashdot0811")
} else if (identical(data.import, ReadSlashdot0902)) {
  data.information <- c("Dataset used: Slashdot0902")
}