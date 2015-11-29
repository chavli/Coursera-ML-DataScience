# example of code which only runs based on triggers (onButton) rather than code
# that reacts immediately to input
library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Triggered Code"),
    sidebarPanel(
        textInput(inputId="text1", label="Input 1"),
        textInput(inputId="text2", label="Input 2"),
        actionButton("submitButton", "Submit"),
        actionLink("submitLink", "Submit Link")
    ),
    mainPanel(
        p("Output Text 1 (reactive)"),
        textOutput("outputText1"),
        p("Output Text 2 (reactive)"),
        textOutput("outputText2"),
        p("Output Text 3 (triggered)"),
        textOutput("outputText3"),
        p("Output Text 4 (trigger counter)"),
        textOutput("outputText4"),
        p("Overall Clicks (global)"),
        textOutput("outputText5")
    )
))