library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("raw_data/summarySCC_PM25.rds")
SCC <- readRDS("raw_data/Source_Classification_Code.rds")

# Question
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

data = filter(NEI, fips == "24510")
data = summarize(group_by(data, year), sum(Emissions))


with(data, {
    png(filename = "plot2.png", width = 480, height = 480, units = "px")
    barplot(height=`sum(Emissions)`, names.arg=year, ylab="Total PM2.5 Emissions (tons)",
            xlab="Year",
            main="Total Baltimore City, MD PM2.5 Emissions per Year")
    dev.off()
})
