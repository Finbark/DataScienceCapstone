library(dplyr)
library(tm)

# This script cleans a given set of data and then tokenises it with the tm package.

main <- function() {
    setwd("./ProcessData")
    profanity <- readLines("./profanityFilter/profanityFilter.txt")
    sampleData <- loadSampleData()
    tokenizedData <- createTokenizedData(sampleData)
    cleanTokenizedData <- cleanTokenizedData(tokenizedData, profanity)
    documentMatrix <- TermDocumentMatrix(cleanTokenizedData)
    saveCorpusandMatrix(cleanTokenizedData, documentMatrix)
    setwd("..")
}


loadSampleData <- function() {
    sampleDataCon <- file("./dataSample.txt")
    sampleData <- readLines(sampleDataCon)
    close(sampleDataCon)
    sampleData
}

createTokenizedData <- function(data) {
    Corpus(VectorSource(data))
}

cleanTokenizedData <- function(data, filter) {
    removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) 
    cleanData <- tm_map(data, content_transformer(removeURL))
    cleanData <- tm_map(cleanData, content_transformer(tolower))
    cleanData <- tm_map(cleanData, content_transformer(removePunctuation))
    cleanData <- tm_map(cleanData, content_transformer(removeNumbers))
    cleanData <- tm_map(cleanData, stripWhitespace)
    cleanData <- tm_map(cleanData, removeWords, stopwords("english"))
    cleanData <- tm_map(cleanData, removeWords, filter)
}

saveCorpusandMatrix <- function(corpus, matrix) {
    saveRDS(corpus, file = "./Corpus.RData")
    saveRDS(matrix, file = "./TDM.RData")
}

main()