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

## economic impacts of weather
## http://journals.ametsoc.org/doi/pdf/10.1175/2011BAMS2928.1

## effect of inflation on numbers - need to update earlier values to 2011? values

## Update date field data types
allData$END_DATE <- as.Date(allData$END_DATE, format="%m/%d/%Y %H:%M:%S")
allData$BGN_DATE <- as.Date(allData$BGN_DATE, format="%m/%d/%Y %H:%M:%S")

## Add year column to use for inflation calcs
allData <- mutate(allData, Year = as.numeric(format(allData$BGN_DATE, "%Y")))

## consumer price index values
## http://www.bls.gov/data/
