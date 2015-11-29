library(shiny)
shinyServer(
    function(input, output){
        output$numberdisplay <-renderText({input$numberchooser})
    }
)
