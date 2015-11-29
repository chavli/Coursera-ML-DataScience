setwd("/home/cha/Coursera/DataAnalysisII/Week_4/")

# Question 1
movies = read.table("movies.txt", header = T, sep="\t", quote="")
linfit = lm(movies$score ~ movies$box.office)


# Question 2
confint(linfit, level=.9)

# Question 3
linfit = lm(movies$score ~ movies$box.office + movies$running.time)
summary(linfit)

# Question 5
plot(movies$running.time, movies$score)
idx = movies$running.time <= 175
clean_data = movies[idx, ]
linfit = lm(clean_data$score ~ clean_data$box.office + clean_data$running.time)