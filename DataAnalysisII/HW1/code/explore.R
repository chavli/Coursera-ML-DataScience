library(Hmisc)
setwd("/home/cha/Coursera/DataAnalysisII/HW1/");

data = read.csv("data/loansData.csv")

#change column names


# remove rows with NAs
good = complete.cases(data)
cleaned_data = data[good, ]

# remove samples that received a negative investment
good = cleaned_data$Amount.Funded.By.Investors >= 0
cleaned_data = cleaned_data[good, ]

good = (cleaned_data$Employment.Length != "n/a")
cleaned_data = cleaned_data[good, ]

# convert columns to a workable format
vals = as.numeric(gsub("\\%", "", cleaned_data$Debt.To.Income.Ratio )) / 100.0
cleaned_data[, "Debt.To.Income.Ratio"] = vals

vals = as.numeric(gsub("\\%", "", cleaned_data$Interest.Rate )) / 100.0
cleaned_data[, "Interest.Rate"] = vals

vals = as.character(cleaned_data$FICO.Range)
split_vals = strsplit(vals, "-")
fico_max = sapply(split_vals, function(x){x[2]})
cleaned_data[, "FICO.max"] = as.numeric(fico_max)

vals = as.character(cleaned_data$Loan.Length)
split_vals = strsplit(vals, " ")
months = sapply(split_vals, function(x){x[1]})
cleaned_data[, "Loan.Months"] = as.factor(months)

# new variables
loan_satisfied = cleaned_data$Amount.Funded.By.Investors / cleaned_data$Amount.Requested
cleaned_data["Loan_Satisfied"] = loan_satisfied

# reformat column names
new_names = tolower(gsub("\\.", "_", names(cleaned_data)))
names(cleaned_data) = new_names

write.csv(cleaned_data, "data/clean_loan_data.csv", row.names=F, na="NA", )



