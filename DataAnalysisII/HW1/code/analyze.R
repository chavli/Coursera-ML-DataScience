library(Hmisc)
setwd("/home/cha/Coursera/DataAnalysisII/HW1/");

data = read.csv("data/clean_loan_data.csv");
names(data)[13] = "inquiries_6mn"
attach(data)

numeric_vars = c("amount_requested", "loan_months", "debt_to_income_ratio", "monthly_income", "fico_max",
                 "open_credit_lines", "revolving_credit_balance", "inquiries_6mn", "loan_satisfied")

factor_vars = c("loan_purpose", "state", "home_ownership", "fico_range", "loan_months")

target_var = "interest_rate"

numeric_data = data[, numeric_vars]
factor_data = data[, factor_vars]
boxplot(interest_rate ~ as.factor(fico_max))

pear_cor = cor( data[, c(numeric_vars, target_var)],method="pearson")
spear_cor = cor( data[, c(numeric_vars, target_var)],method="spearman")

pear_cor[, nrow(pear_cor)]
spear_cor[, nrow(spear_cor)]

boxplot(interest_rate ~ loan_purpose, varwidth=T, cex.axis=.6, las=2)
boxplot(interest_rate ~ home_ownership, varwidth=T, cex.axis=.6, las=2)