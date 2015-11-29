
# ---- Question 1: reading csv
download.file(url="http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "quiz1.csv")
data = read.csv("quiz1.csv")

data$VAL = as.numeric(data$VAL)
sum(data$VAL == 24, na.rm=T)

# ---- Question 2: tidy data



# ---- Question 3: reading excel
require(xlsx)
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", "quiz1excel.xlsx", method="curl")
dat = read.xlsx("quiz1excel.xlsx", sheetIndex = 1, header = T, rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

# ---- Question 4: reading XML
# How many restaurants have zipcode 21231?
require(XML)
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", "restaurants.xml", method="curl")
doc = xmlTreeParse(file="restaurants.xml", useInternal=T)
root = xmlRoot(doc)
sum(xpathSApply(root, "//zipcode", xmlValue) == "21231")

# ---- Question 5: fread
require(data.table)
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "ss06pid.csv", method="curl")
