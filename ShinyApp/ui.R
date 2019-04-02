
library(shiny)

shinyUI(fluidPage(
    titlePanel("Coursera Data Science Capstone"),
    sidebarLayout(
    sidebarPanel(
       textInput("text", "Enter a sentence to predict the next word. Only english words supported")
    ),
    
        mainPanel(
            h2("The predicted word is:"),
            h3(textOutput("predictedWord"))
    )
  )
))
