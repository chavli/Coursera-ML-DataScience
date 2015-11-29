library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("raw_data/summarySCC_PM25.rds")
SCC <- readRDS("raw_data/Source_Classification_Code.rds")

# Question
#
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

data= filter(NEI, fips == "24510") # Baltimore City

# assume "motor vehicle" means EI.sector == "Mobile - On-Road"
vehicles = SCC[grep("Mobile - On-Road", SCC$EI.Sector), ]

# merge datasets
emissions = merge(x=data, y=vehicles, by="SCC")
emissions = filter(emissions, !is.na(Emissions))

# sum emissions by year
totals = summarize(group_by(emissions, year), sum(Emissions))

png(filename = "plot5.png", width = 480, height = 480, units = "px")
ggplot(totals, aes(x=as.factor(year), y=`sum(Emissions)`, fill=as.factor(year))) +
    geom_bar(stat="identity") +
    ggtitle("Total Emissions from Baltimore Motor Vehicles Over Time") +
    ylab("Total Emissions (tons)") +
    xlab("Year") +
    theme(legend.position="none")
dev.off()