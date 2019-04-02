library(dplyr)
library(tm)
library(RWeka)

# This script takes a tokensided data set (a corpus) and creates ngrams out of it.

corpus <- readRDS("./ProcessData/Corpus.RData")

start <- function() {
    bigram <- ngramTokenizer(corpus, 2)
    saveRDS(bigram, file = "./ProcessData/bigram.RDS")
    rm(bigram)
    trigram <- ngramTokenizer(corpus, 3)
    saveRDS(trigram, file = "./ProcessData/trigram.RDS")
    rm(trigram)
    quadgram <- ngramTokenizer(corpus, 4)
    saveRDS(quadgram, file = "./ProcessData/quadgram.RDS")
    
}

ngramTokenizer <- function(corpus, ngramCount) {
    ngram <- NGramTokenizer(corpus, 
                            Weka_control(min = ngramCount, max = ngramCount, delimiters = " \\r\\n\\t.,;:\"()?!"))
    ngram <- data.frame(table(ngram))
    ngram <- ngram[order(ngram$Freq, decreasing = TRUE),]
    colnames(ngram) <- c("String","Count")
    ngram
    
}

start()