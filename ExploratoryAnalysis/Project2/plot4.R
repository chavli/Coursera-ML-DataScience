library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("raw_data/summarySCC_PM25.rds")
SCC <- readRDS("raw_data/Source_Classification_Code.rds")

# Question
#
# Across the United States, how have emissions from coal combustion-related sources changed from
# 1999–2008?

# pull rows from SCC that are coal combustion sources
coal_sources = SCC[grep("Fuel Comb", SCC$EI.Sector), ]
coal_sources = coal_sources[grep("Coal", coal_sources$EI.Sector), c("SCC", "EI.Sector")]

# merge with emission data and use only emissions from coal sources
emissions = merge(x=coal_sources, y=NEI, by="SCC", all.x=T)
emissions = filter(emissions, !is.na(Emissions))

# sum emissions by year
emissions = summarize(group_by(emissions, year), sum(Emissions))

png(filename = "plot4.png", width = 480, height = 480, units = "px")
ggplot(emissions, aes(x=as.factor(year), y=`sum(Emissions)`, fill=as.factor(year))) +
    geom_bar(stat="identity") +
    ggtitle("Total Emissions from Coal Combustion Over Time") +
    ylab("Total Emissions (tons)") +
    xlab("Year") +
    theme(legend.position="none")
dev.off()