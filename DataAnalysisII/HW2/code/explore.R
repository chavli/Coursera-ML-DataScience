
setwd("/home/cha/Coursera/DataAnalysisII/HW2/")
library(RColorBrewer)

load("data/samsungData.rda")

train_group = c(1, 3, 5, 6)
test_group = c(27, 28, 29, 30)

measurement_data = samsungData[, 1:561]
subject = samsungData$subject
outcome = as.factor(samsungData$activity)

# center and scale the data
centered_data = scale(measurement_data, scale=T, center=T)

#svd_data = svd(centered_data)
pca_data = prcomp(centered_data)

plot(pca_data) # this is an important graph
dim(pca_data$rotation)  # the PCs

# variance explained by each PC
pca_data.var = pca_data$sdev^2

# pick the first 3 PC's to reduce the dataset to 3 dimensions for visualization
pcs = pca_data$rotation[, 1:10]

out = paste("captured variance: ", cumsum(pca_data.var / sum(pca_data.var) )[10] )

par(mfrow= c(1, 2))
barplot( (pca_data.var / sum(pca_data.var))[1:10] , main="Percent of Total Variance Explained by the First 10 Principal Components (PC)", 
         xlab = "Principal Components ordered by Variance Explained", ylab="Percent of Total Variance", 
         col=brewer.pal(10, "Set3"))
legend("topright", legend = c("PC-1", "PC-2", "PC-3", "PC-4", "PC-5", "PC-6", "PC-7", "PC-8", "PC-9", "PC-10"), pch=19, col=brewer.pal(10, "Set3"))

cols = brewer.pal(3, "Set1")
cs_variance = cumsum(pca_data.var / sum(pca_data.var) )
plot(cs_variance, main="Cumulative Variance Explained by All PCs", ylab="Percent of Total Variance Explained", xlab="Number of PCs used", 
     type="l", lwd=5, col=cols[1])

abline(v=100, lty=4, lwd=3, col=cols[2])
abline(h=.95, lty=4, lwd=3, col=cols[2])

abline(v=10, lty=4, lwd=3, col=cols[3])
abline(h=.70, lty=4, lwd=3, col=cols[3])

legend(x=300, y=.6, legend=c("Cumulative Variance", "100 PCs (~95% variance)", "10 PCs (~70% variance)"), 
       lty=c(1, 4, 4), lwd=c(4, 3, 3), col=cols) 

print(out)

if(FALSE){
  reduced_data = data.matrix(centered_data) %*% data.matrix(pcs)
  reduced_data = data.frame( reduced_data ) 
  
  training_data = reduced_data[ subject %in% train_group, ]
  training_outcomes = outcome[ subject %in% train_group ]
  
  test_data = reduced_data[ subject %in% test_group,]
  test_outcomes = outcome[ subject %in% test_group ]
  
  tree_fit = tree(training_outcomes ~ PC1 + PC2 + PC3 + PC4 + PC5 + PC6 + PC7 + PC8 + PC9 + PC10, data = training_data)
  
  
  
  #plot(reduced_data, col=as.factor(outcome), pch=19)
  
  
  # look at qqplot of each column
  for( i in 1:561 ){
    par(mfrow= c(1, 2))
    hist(measurement_data[, i], main=paste(i, " ", names(measurement_data)[i]))
    hist(log(measurement_data[, i]), main=paste(i, " log(", names(measurement_data)[i], ")"))
    readline("Press <return to continue") 
  }
}