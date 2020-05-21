# Copyright (c) 2015. All rights reserved.
####################################################################################################
# Proj: Link Prediction
# Desc: Data processing
# Auth: Bublitz Stefan, Gaegauf Luca, Lang Salome, Sutter Pascal
# Date: 2015/12/07
####################################################################################################

ReadSlashdot0902 <- function(){
# Read data ########################################################################################
data.full <- fread("Input/Slashdot0902.txt", colClasses = c("double","double")) 
# Source: https://snap.stanford.edu/data/soc-Slashdot0811.html

# Format data ######################################################################################
# Change names
setnames(data.full, "# FromNodeId", "Source")
setnames(data.full, "ToNodeId", "Target")

# Reduce data set to make link prediction computationally feasible
data.full <- data.full[data.full$Source < 200 & data.full$Target < 200]

# Format class
data.full$Source <- as.character(data.full$Source)
data.full$Target <- as.character(data.full$Target)
data.full
}
