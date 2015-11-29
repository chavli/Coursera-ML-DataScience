#grep, grepl - returns the indices into a char vector that matches the regex. grepl returns
# a T/F vector

#regexpr, gregexpr - same as above. returns the location of a match plus the length of the 
# match. returns the location of length of only the first match. gregexpr returns all matches

#sub, gsub  - find regex matches and perform a replacement

#regexec 



homicides <- readLines("homicides.txt")

#find number of victims of shootings
length( grep("iconHomicideShooting|icon_homicide_shooting", homicides)) # 1003 results
length( grep("[Ss]hooting", homicides)) # 1005 results

# examine the differences
i <- grep("iconHomicideShooting|icon_homicide_shooting", homicides)
j <- grep("[Ss]hooting", homicides)

# larger set needs to be first parameter. "remove all items from i that are also in j"
setdiff(i, j)
setdiff(j, i)

# grep( ..., value=TRUE ), forces grep to return the values that matched instead of the indicies
# grepl returns a T/F vector of matches (can be used to extract rows)

#Example: finding the dates of homicides
#<dd>[Ff]ound(.*)</dd> might be a good pattern to start with
pat <- "<dd>[Ff]ound(.*)</dd>" # greedy
regexpr(pat, homicides[1:10])

pat <- "<dd>[Ff]ound(.*?)</dd>" # lazy
r <- regexpr(pat, homicides[1:10])

regmatches(homicides[1:5], r) # displays the actual matches

# stripping text around the date
x <- substr(homicides[1],177, 177 + 33 -1)

sub("<dd>[Ff]ound on | </dd>", "", x) #only replaces the first match

gsub("<dd>[Ff]ound on | </dd>", "", x) # replaces all matches


# Example: extracting dates and converting them to Dates
pat <- "<dd>[Ff]ound(.*?)</dd>"
r <- regexpr(pat, homicides[1:10])
m <- regmatches(homicides[1:10], r)
d <- gsub("<dd>[Ff]ound on | </dd>", "", m)
as.Date(d, "%B %d, %Y")

# Example : regexec - returns the indices of parenthesized sub-expressions
regexec("<dd><[Ff]ound on (.*?)</dd>", homicides[1])


# when dealing with dates in histograms, hist() requires a "granularity" argument
pat <- "<dd>[F|f]ound on (.*?)</dd>"
r <- regexpr(pat, homicides)
m <- regmatches(homicides, r)
dates <- sapply(m,, function(x) x[2]) # extract the second element from each results
dates <- as.Date(dates, "")
hist(dates, "month", freq=T) # special case for handling time