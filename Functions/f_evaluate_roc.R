# Copyright (c) 2015. All rights reserved.
####################################################################################################
# Proj: Link Prediction
# Desc: Data processing
# Auth: Bublitz Stefan, Gaegauf Luca, Lang Salome, Sutter Pascal
# Date: 2015/12/07
####################################################################################################

EvaluateROC <- function(adj.real, adj.predicted){
  result <- roc(as.vector(adj.real), as.vector(adj.predicted), plot = TRUE)
  result
}
