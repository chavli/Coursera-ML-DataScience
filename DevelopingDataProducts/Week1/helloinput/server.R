library(shiny)
shinyServer(
    function(input, output){
        # grab the values from the named (id) input fields and store them
        output$oid1 <- renderPrint({input$id1})
        output$oid2 <- renderPrint({input$id2})
        output$odate <- renderPrint({input$date})
    }
)