library(shiny)

shinyUI(navbarPage("Project 1",
    tabPanel("Directions",
        h3("Summary"),
        p("The purpose of this shiny app is to demonstrate the effects of standard deviation,
          sample size, and confidence level on the confidence interval. This simulation uses the
          normal distribution. You can begin playing with the app by clicking the 'CI Simulator'
          above or continue reading below."),
        h4("Inputs"),
        p("This app allows you to control the confidence level, mean, standard deviation, and sample
          size. The output plot will update immediately after any variable is change."),
        h3("Interpretting Output"),
        p("The output of this app is a histogram plotting the frequency of the generated data
          (blue bars). The mean of the data is represented by the vertical red line and the calculated
          confidence interval (CI) is represented by the lower and upper yellow vertical lines. The
          CI is calculated with the following equation:"),
        withMathJax("$$\\bar{X} \\pm z \\times \\frac{\\sigma}{\\sqrt{n}}$$"),
        h6("created by Cha Li, 2015 October 18")
    ),
    tabPanel("CI Simulator",
        pageWithSidebar(
            headerPanel(""),
            sidebarPanel(
                selectInput("confint", "Confidence Level", c(.99, .95, .9, .8)),
                sliderInput("mu", "Mean", min = 1, max = 100, value = 10, step = 2),
                sliderInput("std", "Standard Deviation", min = 1, max = 30, value = 5, step = 1),
                sliderInput("samples", "# of Samples", min = 10, max = 500, value = 50, step = 10)
            ),
            mainPanel(
                tabsetPanel(
                    tabPanel("Plot",
                            plotOutput("histplot"),
                            h4("z-score"),
                            textOutput("oZScore"),
                            h4("Confidence Interval"),
                            textOutput("oConfint")
                        ),
                    tabPanel("Data",
                            h4("First 20 Elements"),
                            tableOutput("oTable")
                        )
                )
            )
        )
    )
))


