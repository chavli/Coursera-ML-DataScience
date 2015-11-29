# dates represented by the Date class. times and dates use 1970-01-01
# as the reference epoch

x <- as.Date("1970-01-01") 
print(x)

unclass(x) # returns 0 (0 days since 1970-01-01)


# times are broken down into two classes: POSIXct, POSIXlt
# the former handles time as integers and the latter uses an 
# object that allows querying for weeks, month, days
x <- Sys.time()
print(x)

p <- as.POSIXlt(x)
names(unclass(p))

# NOTE: x is a POSIXct object


# strptime: string to time objects
datestring <- c("January 10, 2012 10:40")
x <- strptime(datestring, "%B %d % %H %M")
print(x)
# ?strptime for help

# arithmatic operations can be performed on time values of the same
# type of time object. the arithmetic handles leap years automatically
# cannot mix POSIXct with POSIXlt objects. 