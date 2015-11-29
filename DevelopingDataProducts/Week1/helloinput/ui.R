library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("First Shiny App"),
    sidebarPanel(
        h3("Sidebar text"),
        numericInput("id1", "Numeric Input", 0, min=0, max=10, step=1),
        checkboxGroupInput("id2", "Checkbox",
                           c("Value 1" = "1",
                             "Value 2" = "2",
                             "Value 3" = "3")),
        dateInput("date", "Date:")
    ),
    mainPanel(
        h3("Main Panel Text"),
        code("
            library('shiny')
             "),
        p("some ordinary text"),
        h4("These are the values you entered!"),
        h4("numericInput"),
        verbatimTextOutput("oid1"),
        h4("checkbox"),
        verbatimTextOutput("oid2"),
        h4("date"),
        verbatimTextOutput("odate")
    )
))