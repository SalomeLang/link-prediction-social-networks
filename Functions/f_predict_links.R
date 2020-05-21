# Copyright (c) 2015. All rights reserved.
####################################################################################################
# Proj: Link Prediction
# Desc: Extracts values from adj.data for unobserved edges in net.train
# Auth: Bublitz Stefan, Gaegauf Luca, Lang Salome, Sutter Pascal
# Date: 2015/12/07
####################################################################################################

ExtractUnobservedLinks <- function(net.train, adj.data){
# =======================================================================================
# Extract values from adj.data for unobserved links in net.train
# Arguments:
# - net.train: Network, for which links have to be predicted and therefore values from adj.data are needed
# - adj.data: Adjacency matrix, containing scores retrieved by a prediction algorithm
# Returned values/objects:
# - Returns a matrix, containing values from adj.data for all unobserved links in net.train, excluding
#     feedback loops
# Libraries required:
# - igraph
# =======================================================================================
  adj.train <- get.adjacency(net.train, sparse = FALSE)
  diag(adj.train) <- 1
  adj.data[adj.train == 0]
}