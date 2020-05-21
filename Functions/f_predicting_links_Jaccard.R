# Copyright (c) 2015. All rights reserved.
####################################################################################################
# Proj: Link Prediction
# Desc: Predicting links using the Jaccard Similarity
# Auth: Bublitz Stefan, Gaegauf Luca, Lang Salome, Sutter Pascal
# Date: 2015/12/07
####################################################################################################

PredictLinksJaccard <- function(net.train){
# =======================================================================================
# Predict Links using the Jaccard Similarity Score
# Arguments:
# - net.train: Network, for which links have to be predicted
# Returned values/objects:
# - Returns a vector, containing Jaccard Similarity Scores for all unobserved links in net.train
# Libraries required:
# - igraph
# =======================================================================================
  # Calculate Jaccard Similarity
  result <- similarity.jaccard(net.train, vids = V(net.train), mode = "all", loops = FALSE)
  result
}