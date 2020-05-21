# Copyright (c) 2015. All rights reserved.
####################################################################################################
# Proj: Link Prediction
# Desc: Predict links using one of the implemented algorithm and evaluate the chosen algorithm
#    using ROC and Precision plot
# Auth: Bublitz Stefan, Gaegauf Luca, Lang Salome, Sutter Pascal
# Date: 2015/12/07
####################################################################################################

# Evaluate Alogrithm ###############################################################################
# Supported evaluation functions are: EvaluateROC

evalutation.function <- EvaluateROC

# II Compute the plot
net.full.adjacency <- get.adjacency(net.full,sparse = FALSE)
plots.roc <- foreach(j = 1:number.folds, .packages = packages.loaded) %dopar% evalutation.function(net.full.adjacency, unobserved.predict[[j]])

roc.sensitivities <- lapply(1:length(net.train), function(x) plots.roc[[x]]$sensitivities)
roc.specificities <- lapply(1:length(net.train), function(x) plots.roc[[x]]$specificities)
# Try and error leads to 0.7 be a good fit to reality
plot.roc <- smooth.spline(1 - unlist(roc.specificities), unlist(roc.sensitivities), spar = 0.7)

# III Save plots in pdf file

# a) Create directory for plot (if it does not exist)
current.time <- Sys.time()
date <-  strptime(current.time, "%Y-%m-%d")
path.output <- paste(script.dir, "Output", date, sep = "/")
if (!dir.exists(path.output)) {
  dir.create(path.output)
}

# b) Save plot in output directory
time <-  format(current.time, "%H.%M.%OS")
file.plot <- paste(time, "plots", "png", sep = ".")
file.plot <- paste(path.output, file.plot, sep = "/")
png(file.plot)
plot(plot.roc, type = "l")
dev.off()

# c) Save parameters of program in text file in same folder as plot file
file.txt <- paste(time, "parameters", "txt", sep = ".")
file.txt <- paste(path.output, file.txt, sep = "/")
fileConn<-file(file.txt)
writeLines(c(data.information, algorithm.information), fileConn)
close(fileConn)

# d) Stop multiple cores support
stopCluster(workers)

# e) Store plots in txt file to be retrieved later
#   (necessary for plotting for multiple ROCs / PRs of different algorithms)
saveRDS(plot.roc, paste(path.output, paste(time, "plot.roc", "rds", sep = "."), sep = "/"))

# f) Retrieve results for

# 1) Slashdot0902
#hsm.roc <- readRDS(paste(path.output, paste("15.19.28", "plot.roc", "rds", sep = "."), sep = "/"))
#hsm.auc <- trapz(hsm.roc$x, hsm.roc$y)
#srw.roc <- readRDS(paste(path.output, paste("15.15.58", "plot.roc", "rds", sep = "."), sep = "/"))
#srw.auc <- trapz(srw.roc$x, srw.roc$y)
#lrw.roc <- readRDS(paste(path.output, paste("15.15.35", "plot.roc", "rds", sep = "."), sep = "/"))
#lrw.auc <- trapz(lrw.roc$x, lrw.roc$y)
#katz.roc <- readRDS(paste(path.output, paste("15.14.39", "plot.roc", "rds", sep = "."), sep = "/"))
#katz.auc <- trapz(katz.roc$x, katz.roc$y)
#jac.roc <- readRDS(paste(path.output, paste("15.14.04", "plot.roc", "rds", sep = "."), sep = "/"))
#jac.auc <- trapz(jac.roc$x, jac.roc$y)

# g) Needed for plotting multiple curves in one plot
pdf(file = "~/Desktop/ROC_Slashdot0902.pdf", width = 5, heigth = 5)
plot(c(0, hsm.roc$x, 1), c(0, hsm.roc$y, 1), col = rgb(0, 0, 155, max = 255), type = "l",
     lwd = 2, main = "ROC: Slashdot 0902", xlab = "FPR", ylab = "TPR", xlim = c(0, 1), ylim = c(0, 1))
segments(x0 = 0, y0 = 0, x1 = 1, y1 = 1, lty = 2)
lines(c(0, srw.roc$x, 1), c(0, srw.roc$y, 1), col = rgb(255, 0, 0, max = 255), lwd = 2) 
lines(c(0, lrw.roc$x, 1), c(0, lrw.roc$y, 1), col = rgb(0, 176, 240, max = 255), lwd = 2) 
lines(c(0, katz.roc$x, 1), c(0, katz.roc$y, 1), col = rgb(255, 192, 0, max = 255), lwd = 2) 
lines(c(0, jac.roc$x, 1), c(0, jac.roc$y, 1), col = rgb(0, 176, 80, max = 255), lwd = 2)
legend("bottomright",
       paste(c("Jac:", "Katz:", "LRW:", "SRW:", "HSM:"), round(c(jac.auc, katz.auc, lrw.auc, srw.auc, hsm.auc), 3)),
       col = c(rgb(0, 176, 80, max = 255), rgb(255, 192, 0, max = 255), rgb(0, 176, 240, max = 255), rgb(255, 0, 0, max = 255), rgb(0, 0, 155, max = 255)),
       lty = c(1, 1, 1, 1, 1), bty = "n", cex = 0.8)
dev.off()

# 2) Slashdot 0811
#hsm.roc <- readRDS(paste(path.output, paste("15.31.54", "plot.roc", "rds", sep = "."), sep = "/"))
#hsm.auc <- trapz(hsm.roc$x, hsm.roc$y)
#srw.roc <- readRDS(paste(path.output, paste("15.34.00", "plot.roc", "rds", sep = "."), sep = "/"))
#srw.auc <- trapz(srw.roc$x, srw.roc$y)
#lrw.roc <- readRDS(paste(path.output, paste("15.33.33", "plot.roc", "rds", sep = "."), sep = "/"))
#lrw.auc <- trapz(lrw.roc$x, lrw.roc$y)
#katz.roc <- readRDS(paste(path.output, paste("15.33.07", "plot.roc", "rds", sep = "."), sep = "/"))
#katz.auc <- trapz(katz.roc$x, katz.roc$y)
#jac.roc <- readRDS(paste(path.output, paste("15.32.42", "plot.roc", "rds", sep = "."), sep = "/"))
#jac.auc <- trapz(jac.roc$x, jac.roc$y)

# g) Needed for plotting multiple curves in one plot
pdf(file = "~/Desktop/ROC_Slashdot0811.pdf", width = 5, heigth = 5)
plot(c(0, hsm.roc$x, 1), c(0, hsm.roc$y, 1), col = rgb(0, 0, 155, max = 255), type = "l",
     lwd = 2, main = "ROC: Slashdot 0811", xlab = "FPR", ylab = "TPR", xlim = c(0, 1), ylim = c(0, 1))
segments(x0 = 0, y0 = 0, x1 = 1, y1 = 1, lty = 2)
lines(c(0, srw.roc$x, 1), c(0, srw.roc$y, 1), col = rgb(255, 0, 0, max = 255), lwd = 2) 
lines(c(0, lrw.roc$x, 1), c(0, lrw.roc$y, 1), col = rgb(0, 176, 240, max = 255), lwd = 2) 
lines(c(0, katz.roc$x, 1), c(0, katz.roc$y, 1), col = rgb(255, 192, 0, max = 255), lwd = 2) 
lines(c(0, jac.roc$x, 1), c(0, jac.roc$y, 1), col = rgb(0, 176, 80, max = 255), lwd = 2)
legend("bottomright",
       paste(c("Jac:", "Katz:", "LRW:", "SRW:", "HSM:"), round(c(jac.auc, katz.auc, lrw.auc, srw.auc, hsm.auc), 3)),
       col = c(rgb(0, 176, 80, max = 255), rgb(255, 192, 0, max = 255), rgb(0, 176, 240, max = 255), rgb(255, 0, 0, max = 255), rgb(0, 0, 155, max = 255)),
       lty = c(1, 1, 1, 1, 1), bty = "n", cex = 0.8)
dev.off()


