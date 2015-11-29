# ----- Q1
data = read.csv("raw_data/getdata-data-ss06hid.csv")

# households on greater than 10 acres who sold more than $10,000 worth of agriculture products
agricultureLogical = data$ACR == 3 & data$AGS == 6
data[which(agricultureLogical), ]

# 125  238  262

# ----- Q2
library(jpeg)
img = readJPEG(source = "raw_data/getdata-jeff.jpg", native=T)

quantile(img, probs = c(.3, .8))
# -15259150 -10575416

# ----- Q3
library(dplyr)
df1 = read.csv("raw_data/getdata-data-GDP.csv")
df2 = read.csv("raw_data/getdata-data-EDSTATS_Country.csv")

df3 = merge(x=df2, y=df1, by.y="code", byxq.x="CountryCode", all.x=T)
results = filter(df3, !is.na(Ranking))
results = arrange(results, desc(Ranking))
results[13, ]

# ------ Q4
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
summarize(group_by(results, Income.Group), mean(Ranking))

# ------ Q5
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many
# countries are Lower middle income but among the 38 nations with highest GDP?
library(Hmisc)
results = mutate(results, gdpgroup = cut2(Ranking, g=5))
table(results$gdpgroup, results$Income.Group)
