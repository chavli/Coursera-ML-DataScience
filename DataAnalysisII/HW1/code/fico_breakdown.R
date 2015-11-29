library(Hmisc)
library(RColorBrewer)

# ?RColorBrewer


setwd("/home/cha/Coursera/DataAnalysisII/HW1/");

data = read.csv("data/clean_loan_data.csv");
names(data)[13] = "inquiries_6mn"
attach(data)
fico_max = as.numeric(fico_max)

# noted: removed fico_max
numeric_vars = c("amount_requested", "loan_months", "debt_to_income_ratio", "monthly_income",
                 "open_credit_lines", "revolving_credit_balance", "inquiries_6mn", "loan_satisfied")
factor_vars = c("loan_purpose", "state", "home_ownership", "fico_range", "loan_months", "employment_length")


boxplot(interest_rate ~ fico_range, varwidth=T, cex.axis=.6, las=2, col=brewer.pal(12, "Set3"))

# largest fico subsets: 670-674, 675-679, 680-684, 695-699, 665-669, 690-694
table(fico_range)

# create larger fico ranges
s = seq(min(fico_max), max(fico_max), 20)
fico_groups = cut2(fico_max, cuts = s)

boxplot(interest_rate ~ fico_groups, varwidth=T, cex.axis=.6, las=2, col=brewer.pal(12, "Set3"))
# largest fico groups: [664,684), [684,704), [704,724), [724,744)
table(fico_groups)

# -------------------------
for( group in c( "[664,684)", "[684,704)", "[704,724)", "[724,744)" ) ){
  target_data = data[ fico_groups == group, ]
  str = paste("FICO Range: ", group, " Set Size: ", nrow(target_data), sep="")
  print("---------------------------------------------------------------")
  print(str)
  c = cor(target_data[, c(numeric_vars, "interest_rate")])
  print(c[, ncol(c)])
}

# ("loan_purpose", "fico_range", "loan_months")
#  [664,684) [684,704) [704,724) [724,744)
for( group in c( "[664,684)", "[684,704)", "[704,724)", "[724,744)" ) ){
  target_data = data[ fico_groups == group, ]
  boxplot(target_data$interest_rate ~ target_data$employment_length, varwidth=T, cex.axis=.6, las=2, col=brewer.pal(12, "Set3"), main=group)
}
