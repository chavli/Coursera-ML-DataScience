data =read.csv("hw1_data.csv"
)
nrow(data)
data[c(152, 153)]
data[c(152, 153),]
data[47, "Ozone"]
sum(is.na(data))
sum(is.na(data[, "Ozone"]))
summary( data[, "Ozone"] )
sum(is.na(data[, "Ozone"]))
good = is.na(data[, "Ozone"])
good
foo = data(data[ !good, "Ozone")
foo = data(data[ !good, "Ozone"])
foo = data[ !good, "Ozone"]
foo
summary(foo)
attach(data)
df2 = data[ Ozone > 31, ]
df2
df3 = df2[ Temp > 90, ]
df3
str(mean)
?mena
?mean
mean(df3$Solar.R, rm.na=T)
mean(df3$Solar.R)
df3$Solar.R
mean(df3$Solar.R)
mean(df3$Solar.R, rm.na=True)
bad = is.na(df3$Solar.R)
mean( df3$Solar.R[!bad] )
df3$Solar.R[!bad]
as.numeric(df3$Solar.R[!bad])
mean(as.numeric(df3$Solar.R[!bad]))
df2
df3
df3 = df2[ df2$Temp > 90, ]
df3
df2
df3
bad = is.na(df3$Solar.R)
bad
solar.r <- df3$Solar.R[!bad]
solar.r
mean(solar.r)
data
df = data[ data$month == 6, ]
df
df = data[ data$Month == 6, ]
df
mean(df$Temp)
df = data[ data$Month == 5, ]
df
max(df$Ozone)
max(df$Ozone, rm.na=T)
df$Ozone
bad = is.na(df$Ozone)
ozone = df$Ozone[!bad]
ozone
max(ozone)
data
data$Ozone
mean(data$Ozone)
mean(data$OZone)
mean(data$Ozone)
bad = is.na(data$Ozone)
ozone = data$Ozone[!bad]
ozone
mean(ozone)
history
history(max.show=100)
savehistory("prgquiz1.R")
