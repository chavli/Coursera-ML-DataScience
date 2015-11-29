library(shiny)

predictDiabetes <- function(value){ return(value / 200) }

shinyServer(
    function(input, output){
        output$inputvalue <-renderPrint({input$glucose})
        output$prediction <- renderPrint({predictDiabetes(input$glucose)})
        }
)