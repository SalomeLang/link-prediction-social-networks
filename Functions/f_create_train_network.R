# Copyright (c) 2015. All rights reserved.
####################################################################################################
# Proj: Link Prediction
# Desc: Function to create a training network given a full network and edges to delete from it
# Auth: Bublitz Stefan, Gaegauf Luca, Lang Salome, Sutter Pascal
# Date: 2015/12/07
####################################################################################################

CreateTrainNetwork <- function(net.full,data.test){
# =======================================================================================
# Creates a training network
# Arguments:
# - net.full: graph object, containing whole network
# - data.test: List, containing edges which should be deleted from net.full
# Returned values/objects:
# - Returns a network containing all vertices from net.full, without edges defined in data.test
# Libraries required:
# - igraph
# =======================================================================================
  e <- apply(data.test, 1, paste, collapse = "|")
  e <- edges(e)
  net.train <- net.full-e
  net.train
}