library(shiny)
library(tm)
library(stringr)

quadgram <- readRDS("./data/quadgram_split.RDS")
trigram <- readRDS("./data/trigram_split.RDS")
bigram <- readRDS("./data/bigram_split.RDS")

cleanInput <- function(input) {
    cleanInput <- tolower(input)
    cleanInput <- removePunctuation(cleanInput)
    cleanInput <- removeNumbers(cleanInput)
    cleanInput <- removeWords(cleanInput, stopwords("english"))
    cleanInput <- str_replace_all(cleanInput, "[^[:alnum:]]", " ")
    cleanInput <- stripWhitespace(cleanInput)
    cleanInput <- trimws(cleanInput)
    cleanInput <- unlist(str_split(cleanInput, " "))

}

predictNextWord <- function(input) {
    input <- cleanInput(input)
    num_words <- length(input)
    input <- trimInput(input, num_words)
    prediction <- makePrediction(input)

}

trimInput <- function(input, word_count) {
    
    if (word_count >= 2) {
        input <- input[(word_count-2):word_count]
    }
    
    else {
        input
    }

}

makePrediction <- function(input) {
    prediction <- as.character(quadgram[quadgram$First == input[1] &
                                        quadgram$Second == input[2] &
                                        quadgram$Third == input[3], ][1,]$Fourth)
    
    if (is.na(prediction)) {
       prediction <- as.character(trigram[trigram$First == input[1] &
                                            trigram$Second == input[2], ][1,]$Third)
    }
    
    if (is.na(prediction)) {

        prediction <- as.character(bigram[bigram$First == input[1], ][1,]$Second)
    }
    prediction
}

