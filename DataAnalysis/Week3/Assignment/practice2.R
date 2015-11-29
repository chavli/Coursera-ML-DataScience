# Plot the 30-day mortality rates for heart attack, heart failure, and pneumonia

data = read.csv("outcome-of-care-measures.csv", colClasses="character")

data[, 11] = as.numeric(data[,11])
data[, 17] = as.numeric(data[,17])
data[, 23] = as.numeric(data[,23])

par(mfrow = c(3, 1))
hist(data[, 11], probability=T, xlab="30-day Death Rate",  main=substitute("Heart Attack (" * bar(X) == k * ")", list(k=mean(data[, 11], na.rm=T ))))
abline(v=median(data[, 11], na.rm=T), col="red")
lines(density(data[, 11], na.rm=T), col="blue" )


hist(data[, 17], probability=T, xlab="30-day Death Rate", main=substitute("Heart Failure (" * bar(X) == k * ")", list(k=mean(data[, 17], na.rm=T ))))
abline(v=median(data[, 17], na.rm=T), col="red")
lines(density(data[, 17], na.rm=T), col="blue" )


hist(data[, 23], probability=T, xlab="30-day Death Rate", main=substitute("Pneumonia (" * bar(X) == k * ")", list(k=mean(data[, 23], na.rm=T ))))
abline(v=median(data[, 23], na.rm=T), col="red")
lines(density(data[, 23], na.rm=T), col="blue" )