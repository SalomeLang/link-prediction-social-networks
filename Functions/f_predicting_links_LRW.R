# Copyright (c) 2015. All rights reserved.
####################################################################################################
# Proj: Link Prediction
# Desc: Predicting links using Superposed Random Walk
# Auth: Bublitz Stefan, Gaegauf Luca, Lang Salome, Sutter Pascal
# Date: 2015/12/07
####################################################################################################

lrw.number.of.steps <- 3

PredictLinksLRW <- function(net.train){
# =======================================================================================
# Predict links using the Superposed Random Walk Similarity Score
# Arguments:
# - net.train: Network, for which links have to be predicted
# Returned values/objects:
# - Returns a vector, containing Superposed Random Walk Similarity Scores for all unobserved
#    links in net.train
# Libraries required:
# - igraph
# =======================================================================================
  adj.full <- get.adjacency(net.train,sparse = FALSE)
  # Transition Probability Matrix, Entry in adjacency matrix divided by its degree
  transition <- adj.full / rowSums(adj.full)
  # Remove possible results from division by zero
  transition[is.nan(transition)] <- 0
  # Step zero for random walk is a vector with N entries (N number of vertices), where
  # xth element for node x is 1 and all others 0, comined for all nodes in network equal
  # to identity matrix
  walker.time.zero <- diag(length(V(net.train)))
  # Calculate Transition Probability Matrix for lrw.number.of.steps
  pr.after.steps <- t(transition) %^% lrw.number.of.steps
  # Multiple transition matrix with step zero of random walk
  pr.after.steps <- pr.after.steps %*% walker.time.zero
  # Calculate score according to Local Random Walk
  score.helper <- rowSums(adj.full) / (sum(adj.full)) * t(pr.after.steps)
  result <- score.helper + t(score.helper)
  # Extract unobserved links
  #result <- ExtractUnobservedLinks(net.train,result)
  result
}