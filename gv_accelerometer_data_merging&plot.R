library(haven)
library(data.table)
library(plyr)
library(plotrix)
library(datasets)
library(tidyverse)
library(ggplot2)

setwd("C:/Users/mjbur/Desktop/SHARE")

data_a <- read_dta("sharew8_rel8-0-0_gv_accelerometer_total.dta")
drop <- c("country", "language", "month", "N_valid_days",
          "GGIR_N_valid_hours_total", "reported_N_valid_hours_total",
          "OxCGRT_stringency_index", "device_id", "frequency", "position",
          "GGIR_ig_rsquared_ENMO_total", "GGIR_ig_gradient_ENMO_total",
          "GGIR_ig_intercept_ENMO_total")
data_a = data_a[,!(names(data_a) %in% drop)]

data_r <- read_dta("sharew8_rel8-0-0_ph.dta")
data_r <- select(data_r, mergeid, ph006d19, ph006d20)

data_easySHARE <- load("sharewX_rel8-0-0_easySHARE_R/easySHARE.rda")
var <- c("mergeid", "wave", "int_year", "ep005_", "age", "female", "maxgrip")
data_easySHARE <- easySHARE_rel8_0_0[var]
data_easySHARE <- easyshare[!(easyshare$wave != 8),]

## load data for activity Score
# br015_ high activity  &&  br016_ low activity
data_CAPI <- read_dta("sharew8_rel8-0-0_br.dta")
data_CAPI <- select(data_CAPI, mergeid, br015_, br016_)

## merge all the data 

all_data <- merge(data_a, data_r, by.x = "mergeid", by.y = "mergeid")
all_data <- merge(all_data, data_easySHARE, by.x = "mergeid", by.y = "mergeid")
all_data <- merge(all_data, data_CAPI, by.x = "mergeid", by.y = "mergeid")

################################################################################

ggplot(all_data, aes(x=female, y=GGIR_mean_ENMO_total , fill=factor(female))) +
  geom_bar(position=position_dodge(), stat="identity") +
  xlab("sex") +
  ylab("GGIR_mean_ENMO_total") + 
  scale_fill_hue(name=" ", labels=c("male","female"))

all_data %>%
  mutate(rheuma = ifelse(ph006d19 == 1 | ph006d20 == 1, 'yes', 'no')) %>%
  ggplot(aes(x=age,y=GGIR_mean_ENMO_total, color=rheuma)) + 
  geom_point() +
  ggtitle('Activity and age') +
  ylab('GGIR mean ENMO') +
  geom_smooth(method = 'lm', se=TRUE) #se = TRUE -> with 95 conf. interval 

all_data %>%
  mutate(rheuma = ifelse(ph006d19 == 1 | ph006d20 == 1, 'yes', 'no')) %>%
  ggplot(aes(x=maxgrip,y=GGIR_mean_ENMO_total, color=rheuma)) + 
  geom_point() +
  ggtitle('Maxgrip and activity') +
  ylab('GGIR mean ENMO') +
  geom_smooth(method = 'lm', se=TRUE) #se = TRUE -> with 95 conf. interval

all_data %>%
  mutate(stay_home = case_when(OxCGRT_stay_at_home == 0 ~ '0',
                               OxCGRT_stay_at_home == 1 ~ '1',
                               OxCGRT_stay_at_home == 2 ~ '2')) %>%
  ggplot(aes(x=age,y=GGIR_mean_ENMO_total, color=stay_home)) + 
  geom_point() +
  ggtitle('Activity with stay_at_home variable') +
  ylab('GGIR mean ENMO')

all_data <- data.table(all_data)
Enmo_data <- (all_data[,list(sleep = GGIR_0_25_ENMO_total,
                             LIPA = GGIR_25_50_ENMO_total + GGIR_50_75_ENMO_total,
                             MVPA = sum(c(8:235))),
                       by = mergeid]
)

all_data %>%
  mutate(ENMO = case_when(GGIR_mean_ENMO_total >= 75 ~ 'MVPA',
                          GGIR_mean_ENMO_total >= 25 ~ 'LIPA',
                          GGIR_mean_ENMO_total < 25 ~ 'sleep')) %>%
  ggplot(aes(x=age,y=GGIR_mean_ENMO_total, color=ENMO)) + 
  geom_point() +
  ggtitle('Activity with stay_at_home variable') +
  ylab('GGIR mean ENMO')

