setwd("/home/cha/Coursera/RProgramming/Week1/")

con = url("http://www.google.com")
data = readLines(con, n=5)

# other connection types: url, file, gzfile, bzfile