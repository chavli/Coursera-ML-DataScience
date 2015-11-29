setwd("/home/cha/Coursera/DataAnalysisII/Week_4/")
movies = read.table("movies.txt", header = T, sep="\t", quote="")
linfit = lm(movies$score ~ as.factor(movies$rating))


# if the p-value is large then the CI will include 0 (no effect)

confint(linfit)

# ANOVA (analysis of variance)
anova(linfit)


# Tukey's
linfit = aov(movies$score ~ as.factor(movies$rating))
TukeyHSD(linfit)