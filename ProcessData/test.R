library(dplyr)
library(tm)
library(RWeka)
library(stringr)

bigram <- readRDS('./unigram.RDS')

bigram <- head(bigram)

bigram2 <- str_split_fixed(bigram$String, " ", 2)
bigram2 <- data.frame(bigram2)
colnames(bigram2) <- c("First", "Second")
bigram2 <- mutate(bigram2, Count = bigram$Count)