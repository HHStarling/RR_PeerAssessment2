## dependent libraries
library(dplyr)

## Pull data from online location
fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
fileNm <- "repdata-data-StormData.csv"
temp <- tempfile()
download.file(fileUrl,temp)
allData <- tbl_df(read.table(bzfile(temp, fileNm), sep=",", header=TRUE, 
                             stringsAsFactors = FALSE, na.strings = c("?","","NA")))
unlink(temp)
