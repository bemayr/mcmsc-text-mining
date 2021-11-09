library(tidyverse)  # data manipulation
library(cluster)    # clustering algorithms
library(factoextra) # clustering algorithms & visualization

df <- USArrests

require(cluster)

basepath <- "D:\\code\\fh-hagenberg\\mc-msc\\web-semantic-technologies\\exercise1\\"

ttd <- read.csv(paste(basepath, "ttd.csv", sep = ""), header=FALSE, sep="\t")
titles <- read.csv(paste(basepath, "titles.txt", sep = ""), header=FALSE)

clusters <- 8
kmm <- kmeans(ttd, clusters)
D <- daisy(ttd, metric = "gower") # "euclidean", "manhattan", "gower"
plot(silhouette(kmm$cluster, D), col=1:clusters, border=NA)




res.dist <- dist(ttd, method = "euclidean")
res.hc <- hclust(d = res.dist, method = "ward.D2")
fviz_dend(res.hc, cex = 0.6, guides)
groups <- cutree(res.hc, k=4)



#define linkage methods
m <- c("average", "single", "complete", "ward")
names(m) <- c( "average", "single", "complete", "ward")

#function to compute agglomerative coefficient
ac <- function(x) {
  agnes(ttd, method = x)$ac
}

#calculate agglomerative coefficient for each clustering linkage method
sapply(m, ac)

clust <- agnes(ttd, method = "ward")
pltree(clust, cex = 0.6, hang = -1, main = "Dendrogram")


# https://www.datanovia.com/en/lessons/agglomerative-hierarchical-clustering/
# https://www.statology.org/hierarchical-clustering-in-r/
# https://stackoverflow.com/questions/32570693/make-silhouette-plot-legible-for-k-means
# https://uc-r.github.io/kmeans_clustering
