library(shiny)
shinyUI(
    pageWithSidebar(
        headerPanel("Diabetes Predictor"),
        sidebarPanel(
            numericInput("glucose", "Glucose mg/dl", 90, min=50, max=200, step=5),
            submitButton("Submit")
        ),
        mainPanel(
            h3("Results of Prediction"),
            h4("You Entered:"),
            verbatimTextOutput("inputvalue"),
            h4("Prediction:"),
            verbatimTextOutput("prediction")
        )
    )
)