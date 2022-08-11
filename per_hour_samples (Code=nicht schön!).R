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


Enmo_hour %>%
  mutate(day = case_when(measurementday == 1 ~ 'day1',
                         measurementday == 2 ~ 'day2',
                         measurementday == 3 ~ 'day3',
                         measurementday == 4 ~ 'day4',
                         measurementday == 5 ~ 'day5',
                         measurementday == 6 ~ 'day6',
                         measurementday == 7 ~ 'day7')) %>%
  ggplot(aes(x=hour,y=GGIR_mean_ENMO_hour, color=day)) + 
  geom_line() +
  ylab('GGIR ENMO mean') +
  ggtitle('ENMO per hour')


r1 <- Enmo_hour[Enmo_hour$mergeid == "Bf-031257-01" & Enmo_hour$measurementday == 1,]
r2 <- Enmo_hour[Enmo_hour$mergeid == "Bf-031257-01" & Enmo_hour$measurementday == 2,]
r3 <- Enmo_hour[Enmo_hour$mergeid == "Bf-031257-01" & Enmo_hour$measurementday == 3,]
r4 <- Enmo_hour[Enmo_hour$mergeid == "Bf-031257-01" & Enmo_hour$measurementday == 4,]
r5 <- Enmo_hour[Enmo_hour$mergeid == "Bf-031257-01" & Enmo_hour$measurementday == 5,]
r6 <- Enmo_hour[Enmo_hour$mergeid == "Bf-031257-01" & Enmo_hour$measurementday == 6,]
r7 <- Enmo_hour[Enmo_hour$mergeid == "Bf-031257-01" & Enmo_hour$measurementday == 7,]
ggplot() + 
  geom_line(data=r1, aes(x=hour, y=GGIR_mean_ENMO_hour), color='green') + 
  geom_line(data=r2, aes(x=hour, y=GGIR_mean_ENMO_hour), color='red') +
  geom_line(data=r3, aes(x=hour, y=GGIR_mean_ENMO_hour), color='blue') +
  geom_line(data=r4, aes(x=hour, y=GGIR_mean_ENMO_hour), color='gray') + 
  geom_line(data=r5, aes(x=hour, y=GGIR_mean_ENMO_hour), color='pink') +
  geom_line(data=r6, aes(x=hour, y=GGIR_mean_ENMO_hour), color='yellow') +
  geom_line(data=r7, aes(x=hour, y=GGIR_mean_ENMO_hour), color='brown')

r1 <- Enmo_hour[Enmo_hour$mergeid == "Bf-291361-02" & Enmo_hour$measurementday == 1,]
r2 <- Enmo_hour[Enmo_hour$mergeid == "Bf-291361-02" & Enmo_hour$measurementday == 2,]
r3 <- Enmo_hour[Enmo_hour$mergeid == "Bf-291361-02" & Enmo_hour$measurementday == 3,]
r4 <- Enmo_hour[Enmo_hour$mergeid == "Bf-291361-02" & Enmo_hour$measurementday == 4,]
r5 <- Enmo_hour[Enmo_hour$mergeid == "Bf-291361-02" & Enmo_hour$measurementday == 5,]
r6 <- Enmo_hour[Enmo_hour$mergeid == "Bf-291361-02" & Enmo_hour$measurementday == 6,]
r7 <- Enmo_hour[Enmo_hour$mergeid == "Bf-291361-02" & Enmo_hour$measurementday == 7,]
ggplot() + 
  geom_line(data=r1, aes(x=hour, y=GGIR_mean_ENMO_hour), color='green') + 
  geom_line(data=r2, aes(x=hour, y=GGIR_mean_ENMO_hour), color='red') +
  geom_line(data=r3, aes(x=hour, y=GGIR_mean_ENMO_hour), color='blue') +
  geom_line(data=r4, aes(x=hour, y=GGIR_mean_ENMO_hour), color='gray') + 
  geom_line(data=r5, aes(x=hour, y=GGIR_mean_ENMO_hour), color='pink') +
  geom_line(data=r6, aes(x=hour, y=GGIR_mean_ENMO_hour), color='yellow') +
  geom_line(data=r7, aes(x=hour, y=GGIR_mean_ENMO_hour), color='brown')

r1 <- Enmo_hour[Enmo_hour$mergeid == "Bf-971100-02" & Enmo_hour$measurementday == 1,]
r2 <- Enmo_hour[Enmo_hour$mergeid == "Bf-971100-02" & Enmo_hour$measurementday == 2,]
r3 <- Enmo_hour[Enmo_hour$mergeid == "Bf-971100-02" & Enmo_hour$measurementday == 3,]
r4 <- Enmo_hour[Enmo_hour$mergeid == "Bf-971100-02" & Enmo_hour$measurementday == 4,]
r5 <- Enmo_hour[Enmo_hour$mergeid == "Bf-971100-02" & Enmo_hour$measurementday == 5,]
r6 <- Enmo_hour[Enmo_hour$mergeid == "Bf-971100-02" & Enmo_hour$measurementday == 6,]
r7 <- Enmo_hour[Enmo_hour$mergeid == "Bf-971100-02" & Enmo_hour$measurementday == 7,]
ggplot() + 
  geom_line(data=r1, aes(x=hour, y=GGIR_mean_ENMO_hour), color='green') + 
  geom_line(data=r2, aes(x=hour, y=GGIR_mean_ENMO_hour), color='red') +
  geom_line(data=r3, aes(x=hour, y=GGIR_mean_ENMO_hour), color='blue') +
  geom_line(data=r4, aes(x=hour, y=GGIR_mean_ENMO_hour), color='gray') + 
  geom_line(data=r5, aes(x=hour, y=GGIR_mean_ENMO_hour), color='pink') +
  geom_line(data=r6, aes(x=hour, y=GGIR_mean_ENMO_hour), color='yellow') +
  geom_line(data=r7, aes(x=hour, y=GGIR_mean_ENMO_hour), color='brown')

ggplot() + 
  geom_line(data=r1, aes(x=hour, y=log(GGIR_mean_ENMO_hour), color='green')) + 
  geom_line(data=r2, aes(x=hour, y=log(GGIR_mean_ENMO_hour), color='red')) +
  geom_line(data=r3, aes(x=hour, y=log(GGIR_mean_ENMO_hour), color='blue')) +
  geom_line(data=r4, aes(x=hour, y=log(GGIR_mean_ENMO_hour), color='gray')) + 
  geom_line(data=r5, aes(x=hour, y=log(GGIR_mean_ENMO_hour), color='pink')) +
  geom_line(data=r6, aes(x=hour, y=log(GGIR_mean_ENMO_hour), color='yellow')) +
  geom_line(data=r7, aes(x=hour, y=log(GGIR_mean_ENMO_hour), color='brown'))


Enmo_hour <- data.table(Enmo_hour)
Enmo_hour <- (Enmo_hour[,list(GGIR_ENMO = median(GGIR_mean_ENMO_hour)),
                        by = c("mergeid", "hour", "age", "female",
                               "ph006d19", "ph006d20")]
)

r1 <- Enmo_hour[Enmo_hour$mergeid == "Bn-694755-07",] #rheuma
r2 <- Enmo_hour[Enmo_hour$mergeid == "Bf-291361-02",] #rheuma
r3 <- Enmo_hour[Enmo_hour$mergeid == "Bf-971100-02",] #rheuma
r4 <- Enmo_hour[Enmo_hour$mergeid == "Bf-031257-01",] #kein rheuma
r5 <- Enmo_hour[Enmo_hour$mergeid == "PL-044856-01",] #kein rheuma
r6 <- Enmo_hour[Enmo_hour$mergeid == "DE-554124-02",] #kein rheuma

ggplot() + 
  geom_line(data=r1, aes(x=hour, y=GGIR_ENMO), color='red') + 
  geom_line(data=r2, aes(x=hour, y=GGIR_ENMO), color='red') +
  geom_line(data=r3, aes(x=hour, y=GGIR_ENMO), color='red') +
  geom_line(data=r4, aes(x=hour, y=GGIR_ENMO), color='blue') + 
  geom_line(data=r5, aes(x=hour, y=GGIR_ENMO), color='blue') +
  geom_line(data=r6, aes(x=hour, y=GGIR_ENMO), color='blue') 



