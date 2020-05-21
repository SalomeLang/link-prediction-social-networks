# Copyright (c) 2015. All rights reserved.
####################################################################################################
# Proj: Link Prediction
# Desc: Predicting links using Superposed Random Walk
# Auth: Bublitz Stefan, Gaegauf Luca, Lang Salome, Sutter Pascal
# Date: 2015/12/07
####################################################################################################

srw.number.of.steps <- 3

PredictLinksSRW <- function(net.train){
# =======================================================================================
# Predict links using the Superposed Random Walk Similarity Score
# Arguments:
# - net.train: Network, for which links have to be predicted
# Returned values/objects:
# - Returns a matrix, containing Superposed Random Walk Similarity Scores for all
#    links in net.train
# Libraries required:
# - igraph
# =======================================================================================
  adj.full <- get.adjacency(net.train, sparse = FALSE)
  # Transition Probability Matrix, Entry in adjacency matrix divided by its degree
  transition <- adj.full / rowSums(adj.full)
  # Remove possible results from division by zero
  transition[is.nan(transition)] <- 0
  # Step zero for random walk is a vector with N entries (N number of vertices), where
  # xth element for node x is 1 and all others 0, comined for all nodes in network equal
  # to identity matrix
  walker.time.zero <- diag(length(V(net.train)))
  result <- 0
  for (i in 1:srw.number.of.steps) {
    # Multiply transposed transition matrix with vector from last step
    if(i == 1) {
      pr.after.steps <- t(transition) %*% walker.time.zero
    } else {
      pr.after.steps <- t(transition) %*% pr.after.steps
    }
    # Use it to calculate next summand for the result
    score.helper <- rowSums(adj.full) / (sum(adj.full)) * t(pr.after.steps)
    score.helper <- score.helper + t(score.helper)
    result <- result + score.helper
  }
  result
}