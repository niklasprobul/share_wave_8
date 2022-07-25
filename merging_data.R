library(plyr)
library(haven)
library(tidyverse)

setwd("C:/Users/mjbur/Desktop/SHARE")

## load data for rheuma -> data_r

data_r <- read_dta("sharew8_rel8-0-0_ph.dta")
data_r <- select(data_r, mergeid, ph006d19, ph006d20)

setwd("C:/Users/mjbur/Desktop/SHARE/sharew8_accelerometer_R/csv")

##import all csv.files from de with accelerometer data
data_csv <- c("be_fr", "be_nl", "cz", "de", "dk", "ef",
              "fr", "it", "pl", "se", "si")

for (d in data_csv){
  d <- list.files(path = d, pattern = ".csv", full.names = TRUE)
  d <- ldply(dataname, read_csv)
}
## Error: 'SI-015798-01' does not exist in current working directory ('C:/Users/mjbur/Desktop/SHARE/sharew8_accelerometer_R/csv').

data_de <- ldply(respondents, read_csv)
#dt <- data.table(data_de)
#dt_slim <- dt[,list(ENMO_MEAN = mean(GGIR_ENMO)), by = c("mergeid", "measurementday")]
#dt_wide <- pivot_wider(dt_slim, names_from = measurementday, values_from = ENMO_MEAN)


## load data from wave 8 release

easySHARE <- load("sharewX_rel8-0-0_easySHARE_R/easySHARE.rda")
var <- c("mergeid", "wave", "int_year", "ep005_", "age", "female", "maxgrip")
easyshare <- easySHARE_rel8_0_0[var]
# drop the lines with missing information for the Variable int_year:
easyshare <- easyshare[!is.na(easyshare$int_year),]
# drop the lines from all waves but 8
easyshare <- easyshare[!(easyshare$wave != 8),]

## load data for activity Score

data_CAPI <- read_dta("sharew8_rel8-0-0_br.dta")
# br015_ high activity
# br016_ low activity
data_CAPI <- select(data_CAPI, mergeid, br015_, br016_)

## merge all the data 

all_data <- merge(data_de, data_r, by.x = "mergeid", by.y = "mergeid")
all_data <- merge(all_data, easyshare, by.x = "mergeid", by.y = "mergeid")
all_data <- merge(all_data, data_CAPI, by.x = "mergeid", by.y = "mergeid")

## save data

save(all_data, file="merged_data_de.rda")

## select specific variables from data

variables <- c("mergeid", "GGIR_ENMO", "ph006d19", "ph006d20", "age", "female",
               "maxgrip", "br015_", "br016_")
datac <- all_data[variables]
# drop the lines with maxgrip < 0
datac <- datac[!(datac$maxgrip <= 0),]

#dt_de <- data.table(datac)

## merging the ENMO scores for each mergeid with the mean of all scores
#dt_de <- (dt_de[,list(GGIR_ENMO = median(GGIR_ENMO)),
#                by = c("mergeid", "ph006d19", "ph006d20","age", "female", 
# "maxgrip", "br015_", "br016_")]
#)

## save selected data

save(all_data, file="merged_data_de.rda")
