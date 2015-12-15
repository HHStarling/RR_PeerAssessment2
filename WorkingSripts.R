## dependent libraries
library(data.table)
library(R.utils)

## Pull data from online location
fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
fileNm <- "repdata-data-StormData.csv"
temp <- tempfile()
download.file(fileUrl,temp)

bunzip2(temp,fileNm)

##allData <- tbl_df(read.table(bzfile(temp, fileNm), sep=",", header=TRUE, stringsAsFactors = FALSE, na.strings = c("?","","NA")))
##allData <- fread(bzfile(temp, fileNm), sep=",", header=TRUE, stringsAsFactors = FALSE, na.strings = c("?","","NA"))
unlink(temp)

allData <- read.table(fileNm, sep=",", header=TRUE, stringsAsFactors = FALSE)

## create R object to make this go faster next time
saveRDS(allData, file="allData.Rds")
allData <- readRDS(file="allData.Rds")

## create smaller subset of data to work with
allData <- allData[1:100000,]
saveRDS(allData, file="allData.Rds")