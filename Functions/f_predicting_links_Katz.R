# Copyright (c) 2015. All rights reserved.
####################################################################################################
# Proj: Link Prediction
# Desc: Predicting links using Katz similarity score
# Auth: Bublitz Stefan, Gaegauf Luca, Lang Salome, Sutter Pascal
# Date: 2015/12/07
####################################################################################################



PredictLinksKatz <- function(net.train){
# =======================================================================================
# Predict Links using the Katz Similarity Score
# Arguments:
# - net.train: Network, for which links have to be predicted
# Returned values/objects:
# - Returns a vector, containing Katz Similarity Scores for all unobserved links in net.train
# Libraries required:
# - igraph
# =======================================================================================
  adj.pred <- get.adjacency(net.train, sparse = FALSE)
  
  # Beta has to be smaller than reciprocal of largest eigenvalue of the adjacency matrix
  beta.max <- max(eigen(adj.pred)$values)
  katz.beta <<- reciprocal(beta.max) - (reciprocal(beta.max)/2)
  katz.max.path.length <<- 4 * diameter(net.train)
  
  # Initialize values at shortest path length
  round.beta <- katz.beta 
  round.adjacency <- adj.pred
  result <- round.beta * round.adjacency
  for(i in 2:katz.max.path.length) 
  {
    # Update values for increasing path length (first iteration is already set in previous lines)
    round.beta <- round.beta * katz.beta
    round.adjacency <- round.adjacency %*% adj.pred
    # Add new summand calculated in last iteration
    result <-  result + round.beta * round.adjacency
  }
  result
}