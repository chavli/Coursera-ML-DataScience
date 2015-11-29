# Plot 30-day death rates by state

data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
data[, 11] <- as.numeric( data[, 11] )

# only use states with at least 20 cases
t <- table(data$State)
largestates = t[ t >= 20 ]
names = rownames(largestates)
valid_data = data[ data$State %in% names,  ]


death <- valid_data[, 11]
state <- valid_data$State
par(mfrow=c(1 ,1), las=2, cex = 1, cex.lab = .2)

#calculate the median death rate of each state
f <- valid_data$State
rates = tapply(valid_data[, 11], f, median, na.rm=T)

# sort the death rates in ascending order
idx = sort.list(rates, decreasing = F)

# split the data into separate lists
split_data = split(valid_data[, 11], valid_data$State)
split_data = split_data[idx] # reorder the lists 

boxplot(split_data, ylab="30-day Death Rate", main="Heart Attack 30-day Death Rate by State")


#boxplot(death ~ state, ylab="30-day Death Rate", main="Heart Attack 30-day Death Rate by State")