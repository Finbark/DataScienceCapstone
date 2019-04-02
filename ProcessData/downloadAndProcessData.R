
# This script downloads the raw data and saves a sample of it.

if (!file.exists("./data.zip")) {
    URL <- "http://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
    download.file(URL, destfile = "data.zip", method = "curl")
    unzip("data.zip")
}

start <- function() {
    files <- list.files(path = './final/en_US/', pattern = "*.txt")
    files <- lapply(files, function(x) paste('./final/en_US/', x, sep = ""))
    dataSample <- unlist(lapply(files, function(x) loadAndSampleData(x, 20000)))
    setwd("./ProcessData")
    writeLines(dataSample, "./dataSample.txt")
    setwd("..")
}

loadAndSampleData <- function(data, sample_size) {
    sampleData <- readLines(data, warn = FALSE, encoding = "UTF-8", skipNul = TRUE)
    sampleData <- selectiveSample(sampleData, sample_size)
}

## Used to handle when the desired sample size is greater than the data set.
selectiveSample <- function(data, sample_size) {
    if (length(data) < sample_size) {
        data
    }
    else {
        sample(data, sample_size)
    }
}

start()