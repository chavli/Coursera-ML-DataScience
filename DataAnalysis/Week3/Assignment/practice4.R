# Plot 30-day death rates and numbers of patients

library(lattice)

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
hospital <- read.csv("hospital-data.csv", colClasses = "character")

# merge the two datasets by the column "Provider.Number"
outcome.hospital <- merge(outcome, hospital, by = "Provider.Number")

death <- as.numeric(outcome.hospital[, 11]) ## Heart attack outcome
npatient <- as.numeric(outcome.hospital[, 15])
owner <- factor(outcome.hospital$Hospital.Ownership)

# Y given X for each Z
xyplot(death ~ npatient | owner, 
       data = outcome.hospital,
       xlab = "Number of Patients Seen",
       ylab = "30-day Death Rate",
       main="Heart Attack 30-day Death Rate by Ownership",
       panel = function(x, y, ...){
         panel.xyplot(x, y, ...)
         panel.lmline(x, y, col="black")
       })

