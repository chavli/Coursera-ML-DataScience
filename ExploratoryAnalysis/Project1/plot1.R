
# load data
data = read.csv("raw_data/electrical.csv")

# create a new 'datetime' column
data$datetime = paste(data$Date, data$Time)
data$Date = as.Date(data$Date, format="%Y-%m-%d")
data$datetime = strptime(data$datetime, "%Y-%m-%d %H:%M:%S")

png(file="plot1.png", width=480, height=480, units="px")
with(subset(data, Date == "2007-02-01" | Date == "2007-02-02"), {
    hist(Global_active_power, col="red", main="Global Active Power",
         xlab="Global Active Power (kilowatts)")
    })
dev.off()

