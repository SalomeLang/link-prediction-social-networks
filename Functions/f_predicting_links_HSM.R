# Copyright (c) 2015. All rights reserved.
####################################################################################################
# Proj: Link Prediction
# Desc: Predicting links using Hierarchical Structure Model
# Auth: Bublitz Stefan, Gaegauf Luca, Lang Salome, Sutter Pascal
# Date: 2015/12/07

hsm.number.of.samples <- 1000

PredictLinksHSM <- function(net.train){
  # =======================================================================================
  # Predict links using the Hierarchical Structure Model
  # Arguments:
  # - net.train: Network, for which links have to be predicted
  # Returned values/objects:
  # - Returns a matrix, containing prediction values obtained using the Hierarchical
  #     Structure Model for all links in net.train
  # Libraries required:
  # - igraph
  # =======================================================================================
  # Calculate prediction
  prediction <- hrg.predict(net.train, num.samples = hsm.number.of.samples)
  # Create adjacency matrix to display results
  number.nodes <- length(V(net.train))
  result <- matrix(0, number.nodes, number.nodes)
  # Update predicted edges as bidirectional
  result[prediction$edges[, 1:2]] <- prediction$prob
  result[prediction$edges[, 2:1]] <- prediction$prob
  # Extract unobserved links
  result
}