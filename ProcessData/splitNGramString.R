library(dplyr)
library(tm)
library(RWeka)
library(stringr)

# This script takes an ngram data frame that only has two columns (the string and the count)
# and splits it into a dataframe with a coulumn for each word in the string and a column for the count.

start <- function() {
    ngram <- readRDS('./ProcessData/bigram.RDS')
    ngram_split <- stringSplit(ngram, 2)
    saveRDS(ngram_split, "./ProcessData/bigram_split.RDS")
    ngram <- readRDS('./ProcessData/trigram.RDS')
    ngram_split <- stringSplit(ngram, 3)
    saveRDS(ngram_split, "./ProcessData/trigram_split.RDS")
    ngram <- readRDS('./ProcessData/quadgram.RDS')
    ngram_split <- stringSplit(ngram, 4)
    saveRDS(ngram_split, "./ProcessData/quadgram_split.RDS")
}


stringSplit <- function(df, n) {
    split_df <- str_split_fixed(df$String, " ", n)
    split_df <- data.frame(split_df)
    colnames(split_df) <- getColNames(n)
    split_df <- mutate(split_df, Count = df$Count)
    
}

getColNames <- function(n) {
    if (n == 2) {
        return(c("First", "Second"))
    }
    else if (n == 3) {
        return(c("First", "Second", "Third"))
    }
    else {
        return(c("First", "Second", "Third", "Fourth"))
    }
}

start()