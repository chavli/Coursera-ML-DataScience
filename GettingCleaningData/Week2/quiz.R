
# Question 1:
library(httr)
library(jsonlite)

oauth_endpoints("github")
app = oauth_app("github", key="dd2a7e67e5cdd77ab353"
                , secret="cfa5fcf561c0881aa2364dbaae527b66ae419c68")
github_token <- oauth2.0_token(oauth_endpoints("github"), app)
gtoken <- config(token = github_token)
response = GET("https://api.github.com/users/jtleek/repos", gtoken)
data = content(response)
json = jsonlite::fromJSON(toJSON(data))
json[json$name == "datasharing", "created_at"]


# Question 3
library(sqldf)
data = read.csv("raw_data/getdata-data-ss06pid.csv")
sqldf("select distinct AGEP from data")

# Question 4
library(httr)
library(XML)
conn = url("http://biostat.jhsph.edu/~jleek/contact.html")
html = readLines(conn)
nchar(html[10])
nchar(html[20])
nchar(html[30])
nchar(html[100])

# Question 5
library(foreign)
data = read.fwf("raw_data/getdata-wksst8110.for"
                , skip=4 # number of lines to skip until you get to data
                , widths=c(10, 9, 4, 9, 4, 9, 4, 9, 4)) # these you have to count yourself

sum(data$V4)
