# Copyright (c) 2015. All rights reserved.
####################################################################################################
# Proj: Link Prediction
# Desc: Data processing
# Auth: Bublitz Stefan, Gaegauf Luca, Lang Salome, Sutter Pascal
# Date: 2015/12/07
####################################################################################################

ReadEgoFacebook <- function(){
# Read data ########################################################################################
data.full <- fread("Input/facebook_combined.csv") 
# Source: https://snap.stanford.edu/data/egonets-Facebook.html

# Format data ######################################################################################
# Change names
setnames(data.full, "V1", "Source")
setnames(data.full, "V2", "Target")
#str(facebook)

# Format class
data.full$Source <- as.character(data.full$Source)
data.full$Target <- as.character(data.full$Target)
data.full
}
