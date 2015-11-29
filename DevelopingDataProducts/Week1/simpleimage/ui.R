library(shiny)
shinyUI(
    pageWithSidebar(
        headerPanel("Example Plot"),
        sidebarPanel(
            sliderInput("mu", "Guess the mean", value=70, min=62, max=74, step=.05)
        ),
        mainPanel(
            plotOutput("newHist")
        )
    )
)