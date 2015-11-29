setwd('/home/cha/Coursera/DataAnalysisII/Week_2/')
#Quiz 2, Question 2

conn = url('http://simplystatistics.tumblr.com/')
simplyStats = readLines(conn, n=150)
close(conn)
char_counts = nchar(simplyStats)
char_counts[c(2, 45, 122)]


# Question 3
data = read.csv('/home/cha/Coursera/DataAnalysisII/Week_2/ss06hid.csv')
data.milplus = data[data$VAL == 24, ] 
sum(data$VAL == 24, na.rm=T)

# Question 5
# BDS = number of bedrooms
# RMS = number of total rooms
sum( data$BDS == 3 & data$RMS == 4, na.rm = T)
sum( data$BDS == 2 & data$RMS == 5, na.rm = T)
sum( data$BDS == 2 & data$RMS == 7, na.rm = T)

# Question 6
# ACR = lot size in acres
# AGS =  Sales of Agriculture Products in $
agricultureLogical = (data$ACR == 3 & data$AGS == 6)
which(agricultureLogical)

# Question 7
idx = which(agricultureLogical)
subdata = data[idx, ]
sum(is.na(subdata$MRGX))

# Question 8
split_names = strsplit( names(data) , split='wgtp' )
split_names[[123]]

# Question 9
quantile(data$YBL, na.rm=T)

# Question 10
# Use the merge command to merge these data sets based only on the common identifier "SERIALNO". 
# What is the dimension of the resulting data set? 
download.file('https://dl.dropbox.com/u/7710864/data/csv_hid/ss06pid.csv','ss06pid.csv', method='curl')
housingData = read.csv('ss06hid.csv')
populationData = read.csv('ss06pid.csv')
allData = merge(x = housingData, y = populationData, by.x = 'SERIALNO', by.y = 'SERIALNO', all=T )
dim(allData)

