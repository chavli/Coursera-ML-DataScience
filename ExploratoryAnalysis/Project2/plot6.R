library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("raw_data/summarySCC_PM25.rds")
SCC <- readRDS("raw_data/Source_Classification_Code.rds")

# Question
#
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

data= filter(NEI, fips == "24510"  | fips == "06037") # Baltimore City and LA County

# assume "motor vehicle" means EI.sector == "Mobile - On-Road"
vehicles = SCC[grep("Mobile - On-Road", SCC$EI.Sector), ]

# merge datasets
emissions = merge(x=data, y=vehicles, by="SCC")
emissions = filter(emissions, !is.na(Emissions))

# use dplyr to manipuate the data such that the result contains for each year/city a percent value
# representing how emissions have changes compared to the first year, 1999
totals = emissions %>% group_by(year, fips) %>% summarize(sum(Emissions)) %>% rename(total_emissions=`sum(Emissions)`)
totals99 = totals %>% filter(year == 1999) %>% rename(first_year=`total_emissions`)

# calculate the relative changes in emissions for each year compared to 1999
totals = merge(x=totals, y=totals99, by="fips")
totals = totals %>% mutate(p_emissions=total_emissions/first_year)


png(filename = "plot6.png", width = 600, height = 480, units = "px")
ggplot(totals, aes(x=as.factor(year.x), y=`p_emissions`, fill=as.factor(fips))) +
    geom_bar(stat="identity", position="dodge") +
    ggtitle("Relative Change in Motor Vehicle Emissions for Baltimore and LA Over Time") +
    ylab("Percent of 1999 Total Emisions") +
    xlab("Year") +
    scale_fill_discrete(name="Region",
                    breaks=c("06037", "24510"),
                    labels=c("Los Angeles County", "Baltimore City"))
dev.off()
