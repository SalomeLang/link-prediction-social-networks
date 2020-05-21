a <- list()  # initialize empty object
# define merging pattern: 
#    negative numbers are leaves, 
#    positive are merged clusters (defined by row number in $merge)
a$merge <- matrix(c(-1, -2,
                    1, -3,
                    2, -4,
                    3, -5,
                    -9, -10,
                    -8, 5,
                    -7, 6,
                    -6, 7,
                    4, 8), nc = 2, byrow = TRUE) 
a$height <- c(0, 0.5, 1.5, 2, 1, 1.5, 1.888888, 2.388888, 2.6288888)    # define merge heights
a$order <- 1:10             # order of leaves(trivial if hand-entered)
a$labels <- LETTERS[1:10]    # labels of leaves
class(a) <- "hclust"        # make it an hclust object   
png('dendro.png')
plot(a)
dev.off()
#convert to a dendrogram object if needed
ad <- as.dendrogram(a)