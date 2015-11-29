# example of code which only runs based on triggers (onButton) rather than code
# that reacts immediately to input
library(shiny)
clicks <<- 0

shinyServer(
    function(input, output){
        output$outputText1 <- renderText({input$text1})
        output$outputText2 <- renderText({input$text2})
        output$outputText3 <- renderText({
            # the pattern: onEvent + isolate() causes code in the isolate function
            # to wait for the event to happen before executing. without isolate, the code
            # will just execute independent of the button press.

            input$submitButton
            isolate({paste(input$text1, input$text2)})
            })
        output$outputText4 <- renderText({
            # the variables representing action buttons are integers, which we can use
            # to track the number of presses or to perform conditional events:
            if(input$submitLink == 0){"You haven't pressed the link yet!"}
            else if(input$submitLink > 0){
                clicks <<- clicks + 1
                paste("Link Clicks:", input$submitLink)
                }
            })
        output$outputText5 <- renderText(clicks)
    }
)