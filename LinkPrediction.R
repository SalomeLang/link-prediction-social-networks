# Copyright (c) 2015. All rights reserved.
####################################################################################################
# Proj: Link Prediction
# Desc: Set up workspace, load functions, run scripts
# Auth: Bublitz Stefan, Gaegauf Luca, Lang Salome, Sutter Pascal
# Date: 2015/12/07
####################################################################################################
# Set up work space ################################################################################
# Clean workspace
rm(list = ls())

# Set working directory
getwd()
#~ does not work on my PC to detect relative path
#setwd(dir = "~/Dropbox/Link prediction/R Code/")
#Take 
script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)
# Load packages
library(igraph)
library(igraphdata)
library(data.table)
library(pROC)
library(dismo)
library(expm)
library(VGAM)
library(foreach)
library(doParallel)
library(pracma)

# Source relevant code #############################################################################

# a) Load functions ################################################################################

# Helper functions
# Create Training Network
source(file = "Functions/f_create_train_network.r")
# Extract unobserved links from a network
source(file = "Functions/f_extract_unobserved_edges.r")

# Data function
# Load data from egoFacebook file
source(file = "Functions/f_read_egoFacebook.r")
# Load data from igraph - kite
source(file = "Functions/f_read_kite.r")
# Load data from slashdot0811 file
source(file = "Functions/f_read_slashdot0811.r")
# Load data from slashdot0902 file
source(file = "Functions/f_read_slashdot0902.r")

# Link prediction functions
# Similarity based methods
# Jaccard
source(file = "Functions/f_predicting_links_Jaccard.r")
# Katz
source(file = "Functions/f_predicting_links_Katz.r")
# Local Random Walk
source(file = "Functions/f_predicting_links_LRW.r")
# Superposed Random Walk
source(file = "Functions/f_predicting_links_SRW.r")

# Maximum Likelihood Methods
# Hierarchical Structure Model
source(file = "Functions/f_predicting_links_HSM.r")

# Evaluation Methods
# Calculate ROC
source(file = "Functions/f_evaluate_roc.r")

# b) Source Files ##################################################################################

# I Read in data and divide it into folds for cross fold validation
source(file = "Source/s_load_and_process_data.r")

# II Specify function for predicting links
source(file = "Source/s_predict_links.r")

# III Evaluate predictions
source(file = "Source/s_evaluate_algorithm.r")