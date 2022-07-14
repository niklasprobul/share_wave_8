library(tidyverse)
library(plyr)
#working directory
setwd("C:/Users/mjbur/Desktop/SHARE/sharew8_accelerometer_R/csv/de")
resp1 <- read.csv("sharew8_rel8-0-0_gv_accelerometer_epochs_DE-003053-01.csv") 
resp2 <- read.csv("sharew8_rel8-0-0_gv_accelerometer_epochs_DE-004153-02.csv")
resp3 <- read.csv("sharew8_rel8-0-0_gv_accelerometer_epochs_DE-006225-01.csv")

ggplot(resp1, aes(x=timestamp, y=GGIR_ENMO)) +
  geom_bar(position=position_dodge(), stat="identity") 

ggplot() + 
  geom_line(data=resp1, aes(x=timestamp, y=GGIR_ENMO), color='green') + 
  geom_line(data=resp2, aes(x=timestamp, y=GGIR_ENMO), color='red') +
  geom_line(data=resp3, aes(x=timestamp, y=GGIR_ENMO), color='blue') 

