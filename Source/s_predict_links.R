# Copyright (c) 2015. All rights reserved.
####################################################################################################
# Proj: Link Prediction
# Desc: Predict Links using one of the provided functions
# Auth: Bublitz Stefan, Gaegauf Luca, Lang Salome, Sutter Pascal
# Date: 2015/12/07
####################################################################################################

# Function used for predicting links
# Available functions are: PredictLinksJaccard, PredictLinksKatz, PredictLinksLRW,
#   PredictLinksSRW, PredictLinksHSM
predicting.function <- PredictLinksJaccard

# Check Data Process ################################################################################
# Previous data processing has to create training networks and insert them into the list net.train

if (!exists("net.train") || typeof(net.train) != "list") {
  stop("Data processing not done correctly.")
}

# Link Prediction ##################################################################################
unobserved.predict <- foreach(j = 1:length(net.train), .packages = packages.loaded) %dopar% predicting.function(net.train[[j]])
#unobserved.predict <- lapply(net.train, predicting.function)

# Store information about algorithm for further use in evaluation
if (identical(predicting.function, PredictLinksKatz)) {
  algorithm.information <- c("Algorithm used: Katz Similarity Score")
} else if (identical(predicting.function, PredictLinksJaccard)) {
  algorithm.information <- c("Algorithm used: Jaccard Similarity Score")
} else if (identical(predicting.function, PredictLinksLRW)) {
  algorithm.information <- c("Algorithm used: Local Random Walk Similarity Score")
} else if (identical(predicting.function, PredictLinksSRW)) {
  algorithm.information <- c("Algorithm used: Superposed Random Walk Similarity Score")
} else if (identical(predicting.function, PredictLinksHSM)) {
  algorithm.information <- c("Algorithm used: Hierarchical Random Model")
}

