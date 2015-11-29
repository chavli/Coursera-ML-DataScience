library(ggplot2)
library(shiny)

shinyServer(
    function(input, output){
        # reactive functions to calculate some plot parameters before any output happens
        workingdata <- reactive({data.frame(values=rnorm(n = input$samples, mean = input$mu, sd=input$std))})
        z <- reactive({
            if(input$confint == .99){ z = 2.58 }
            else if (input$confint == .95){ z = 1.96 }
            else if (input$confint == .90){ z = 1.65 }
            else if (input$confint == .80){ z= 1.28 }
            })
        confint <- reactive({
            input$mu + c(-1, 1) * z() * (sd(workingdata()$values) / sqrt(input$samples))
            })

        # all the render functions. these all borrow data calculate from the functions above.
        # the plot is generated using ggplot
        output$histplot <- renderPlot({
            ggplot(workingdata(), aes(x=values)) +
                geom_histogram(binwidth=1, alpha=.8, fill="dodgerblue") +
                xlim(0, 100) +
                geom_vline(xintercept=input$mu, color="firebrick1", size=1) +
                geom_vline(xintercept=confint()[1], color="goldenrod", size=1) +
                geom_vline(xintercept=confint()[2], color="goldenrod", size=1) +
                ggtitle("CI Simulator") +
                ylab("Frequency") +
                xlab("Value") +
                theme(panel.background= element_rect(fill = "darkslategray"),
                      panel.grid.major = element_line(colour = "darkslategray4"),
                      panel.grid.minor = element_line(colour = "darkslategray4"))
            })

        output$oTable <- renderTable({head(workingdata(), n=20)})
        output$oConfint <- renderText({confint()})
        output$oZScore <- renderText({z()})
    }
)