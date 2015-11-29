library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("raw_data/summarySCC_PM25.rds")
SCC <- readRDS("raw_data/Source_Classification_Code.rds")

# Question:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base
# plotting system, make a plot showing the total PM2.5 emission from all sources for each of
# the years 1999, 2002, 2005, and 2008.

data = summarize(group_by(NEI, year), sum(Emissions))

with(data, {
    png(filename = "plot1.png", width = 480, height = 480, units = "px")
    barplot(height=`sum(Emissions)`, names.arg=year, ylab="Total PM2.5 Emissions (tons)",
            xlab="Year",
            main="Total U.S. PM2.5 Emissions per Year")
    dev.off()
})