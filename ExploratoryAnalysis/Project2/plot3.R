library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("raw_data/summarySCC_PM25.rds")
SCC <- readRDS("raw_data/Source_Classification_Code.rds")


# Question:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a p
# lot answer this question.
categories = select(SCC, SCC, Data.Category)

# Baltimore City data
data= filter(NEI, fips == "24510")

# sum emmisions by year and type
trends = summarize(group_by(data, type , year), sum(Emissions))

png(filename = "plot3.png", width = 480, height = 480, units = "px")
ggplot(trends, aes(x=year, y=`sum(Emissions)`, fill=type)) +
    geom_bar(stat="identity", position="dodge") +
    scale_x_continuous(breaks=c(1999, 2002, 2005, 2008), labels=c("1999", "2002", "2005", "2008")) +
    ylab("Total Emissions (tons)") +
    ggtitle("Total Emissions by Type and Year")
dev.off()