library(plyr)
library(haven)
library(tidyverse)

#working directory
setwd("C:/Users/mjbur/Desktop")

##########################
### data for arthritis ###
##########################
#0:
#1:
data_ph <- read_dta("SHARE/sharew8_rel8-0-0_ph.dta")
data_ph <- select(data_ph, mergeid, ph006d19, ph006d20)

####################################
### import all csv.files from de ###
####################################

de <- "SHARE/sharew8_accelerometer_R/csv/de"
respondents <- list.files(path = de, pattern=".csv",full.names = TRUE)
data_de <- ldply(respondents, read_csv)
#dt <- data.table(data_de)
#dt_slim <- dt[,list(ENMO_MEAN = mean(GGIR_ENMO)), by = c("mergeid", "measurementday")]
#dt_wide <- pivot_wider(dt_slim, names_from = measurementday, values_from = ENMO_MEAN)

##################
### wave8 data ###
##################

easySHARE <- load("SHARE/sharewX_rel8-0-0_easySHARE_R/easySHARE.rda")
variables <- c("mergeid", "wave", "int_year", "ep005_", "age", "female", "maxgrip")
easyshare <- easySHARE_rel8_0_0[variables]
# drop the lines with missing information for the Variable int_year:
easyshare <- easyshare[!is.na(easyshare$int_year),]
# drop the lines from all waves but 8
easyshare <- easyshare[!(easyshare$wave != 8),]

########################## 
### merge all the data ###
########################## 

all_data <- merge(data_de, data_ph, by.x = "mergeid", by.y = "mergeid")
all_data <- merge(all_data, easyshare, by.x = "mergeid", by.y = "mergeid")

save(all_data, file="C:/Users/mjbur/Desktop/SHARE/merged_data_de.rda")
