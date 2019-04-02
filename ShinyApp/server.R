library(shiny)
library(tm)

source("./HelperFunctions.R")

shinyServer(function(input, output) {
    wordPrediction <- reactive({
        input_text <- input$text
        input_text <- cleanInput(input_text)
        word_prediction <- predictNextWord(input_text)
    })
    
    output$predictedWord <- renderText(wordPrediction())
    output$inputWords <- renderText({input$text}, quoted = FALSE)
   
  })
  



