library(haven)
library(data.table)
library(plyr)
library(plotrix)
library(datasets)
library(tidyverse)
library(ggplot2)

setwd("C:/Users/mjbur/Desktop/SHARE")

Enmo_hour <- read_dta("sharew8_rel8-0-0_gv_accelerometer_hour.dta")
Enmo_hour <- select(Enmo_hour, mergeid, measurementday,
                    hour, GGIR_mean_ENMO_hour)

data_r <- read_dta("sharew8_rel8-0-0_ph.dta")
data_r <- select(data_r, mergeid, ph006d19, ph006d20)

data_easySHARE <- load("sharewX_rel8-0-0_easySHARE_R/easySHARE.rda")
var <- c("mergeid", "wave", "int_year", "ep005_", "age", "female", "maxgrip")
data_easySHARE <- easySHARE_rel8_0_0[var]
data_easySHARE <- data_easySHARE[!(data_easySHARE$wave != 8),]

## merge all the data 
all_data <- merge(Enmo_hour, data_r, by.x = "mergeid", by.y = "mergeid")
all_data <- merge(all_data, data_easySHARE, by.x = "mergeid", by.y = "mergeid")
all_data <- data.table(all_data)

data_h <- (all_data[,list(GGIR_ENMO = median(GGIR_mean_ENMO_hour)),
                        by = c("mergeid", "hour", "age", "female",
                               "ph006d19", "ph006d20")]
)

data_h %>%
  mutate(ENMO = case_when(GGIR_ENMO >= 75 ~ 'MVPA',
                          GGIR_ENMO >= 25 ~ 'LIPA',
                          GGIR_ENMO < 25 ~ 'sleep')) %>%
  ggplot(aes(x=hour,y=GGIR_ENMO, color=ENMO)) + 
  geom_point() +
  ylab('GGIR mean ENMO')
