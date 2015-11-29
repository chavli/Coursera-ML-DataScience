setwd('~/Desktop/Week_4')

load("samsungData.rda")
names(samsungData)[1:12]
attach(samsungData)

svd_results = svd(scale(samsungData[samsungData$subject == 1, -c(562, 563)]))

# the u vectors are the principal components of the given dataset, the 
# v vectors, associated with each u vector, illustrate which of the original
# varialbes contribute the most to each u
# u : left singular vectors (the patterns)
# v : right singluar vector (weights for each u)

par(mfrow=c(1, 2))
plot(svd_results$u[,1], col=numericActivity, pch=9)
plot(svd_results$u[,2], col=numericActivity, pch=9)

# look for u's that distinguish the groups of interest, then look at their
# respective v's to find which variables contribute the most 

# ------------------------------------
kclust = kmeans(samsungData[samsungData$subject == 1, -c(562, 563)], centers=6, nstart=100)
table(kclust)table(kclust$cluster, samsungData$activity[samsungData$subject == 1])

# examine the first 10 means of the first cluster
plot(kclust$center[1, 1:10], pch=19)

