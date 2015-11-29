library(dplyr)
library(tidyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile = "q1.csv",
              method="curl")

df = read.csv("q1.csv")

# -- Question 1
splits = strsplit(names(df), "wgtp")
splits[123]

# -- Question 2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile="q2.csv",
              method="curl")

df = read.csv("q2.csv")

ranked_nations = filter(df, !is.na(`X.1`))

ranked_nations = mutate(ranked_nations, gdp=gsub(",", "", `X.4`))
ranked_nations = mutate(ranked_nations, gdp=as.numeric(gdp))
mean(ranked_nations$gdp, na.rm = T)


# -- Question 4
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
              destfile="q4.csv",
              method="curl")
df = read.csv("q4.csv")

combined = merge(x=ranked_nations, y=df, by.x="X", by.y="CountryCode")

length(grep("Fiscal year end: June", combined$Special.Notes))

# -- Question 5
# How many values were collected in 2012? How many values were collected on Mondays in 2012?
library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

years = year(ymd(sampleTimes))
days = wday(ymd(sampleTimes),label = T)

sum((years == 2012 & days == "Mon"))


