library(data.table)
library(plyr)
library(plotrix)
library(datasets)
library(tidyverse)
library(ggplot2)

load("C:/Users/mjbur/Desktop/SHARE/merged_data_de.rda")

variables <- c("mergeid", "GGIR_ENMO", "ph006d19", "ph006d20", "age", "female",
               "maxgrip", "br015_", "br016_")
datac <- all_data[variables]
# drop the lines with maxgrip < 0
datac <- datac[!(datac$maxgrip <= 0),]
dt_de <- data.table(datac)

## merging the ENMO scores for each mergeid with the mean of all scores
dt_de <- (dt_de[,list(GGIR_ENMO = mean(GGIR_ENMO)),
                  by = c("mergeid", "ph006d19", "ph006d20","age", "female", 
                         "maxgrip", "br015_", "br016_")]
)

#GGIR_ENMO = Average ENMO in g (gravity)
#Start: March 2020 -> (corona)

summary(dt_de$GGIR_ENMO)
describe(dt_de$GGIR_ENMO)

################################################################################
#########################################
## plot male/female mean of ENMO Score ##
#########################################
# 0: male, 1:female
#TODO: confidence interval
# Confidence interval multiplier for standard error
# Calculate t-statistic for confidence interval: 
# e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1

sum_sex <- (dt_de[,list(N = length(GGIR_ENMO),
                        min = min(GGIR_ENMO), max = max(GGIR_ENMO),
                        mean = mean(GGIR_ENMO), median = median(GGIR_ENMO),
                        sd   = sd(GGIR_ENMO), se = std.error(GGIR_ENMO),
                        ci = std.error(GGIR_ENMO) * qt(.95/2 + .5, length(GGIR_ENMO))),
                        by = "female"]
)


ggplot(sum_sex, aes(x=female, y=mean , fill=factor(female))) +
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=mean-ci, ymax=mean+ci),
                size =.3,
                width =.2, 
                position=position_dodge(.9)) +
  xlab("sex") +
  ylab("ENMO Score mean") + 
  scale_fill_hue(name=" ", labels=c("male","female"))


################################################################################
##################################
## scatter  enmo score with and ##
## without ph006d19 or ph006d20 ##
##################################
# if RA=1 or RO=1 -> rheuma = yes
rheuma_data <- (dt_de[,list(N = length(GGIR_ENMO),
                         min = min(GGIR_ENMO),
                         max = max(GGIR_ENMO),
                         mean = mean(GGIR_ENMO),
                         median = median(GGIR_ENMO),
                         sd   = sd(GGIR_ENMO),
                         se = std.error(GGIR_ENMO),
                         ci = std.error(GGIR_ENMO) * qt(.95/2 + .5, length(GGIR_ENMO))),
                         by = c("age","ph006d19", "ph006d20")]
)

rheuma_data <- tbl_df(rheuma_data)
rheuma_data %>%
  mutate(rheuma = ifelse(ph006d19 == 1 | ph006d20 == 1, 'yes', 'no')) %>%
  #mutate(sex = ifelse(female == 1, 'f', 'm')) 
    ggplot(aes(x=age,y=mean, color=rheuma)) + 
    geom_point() +
    ggtitle('Differences in activity with and without rheuma depending on age') +
    ylab('mean of ENMO (gravity)') +
    geom_smooth(method = 'lm', se=TRUE) #se = TRUE -> with 95 conf. interval

    
################################################################################
##################################
##      ENMO and max grip       ##    
##################################

grip_rheuma <- (dt_de[,list(N = length(GGIR_ENMO),
                            min = min(GGIR_ENMO),
                            max = max(GGIR_ENMO),
                            mean = mean(GGIR_ENMO),
                            median = median(GGIR_ENMO),
                            sd   = sd(GGIR_ENMO),
                            se = std.error(GGIR_ENMO),
                            ci = std.error(GGIR_ENMO) * qt(.95/2 + .5, length(GGIR_ENMO))),
                      by = c("maxgrip","ph006d19", "ph006d20")]
)

grip_rheuma <- tbl_df(grip_rheuma)
grip_rheuma %>%
  mutate(rheuma = ifelse(ph006d19 == 1 | ph006d20 == 1, 'yes', 'no')) %>%
  ggplot(aes(x=maxgrip,y=mean, color=rheuma)) + 
  geom_point() +
  ggtitle('Differences in activity with and without rheuma depending on age') +
  ylab('mean of ENMO (gravity)') +
  geom_smooth(method = 'lm', se=TRUE) #se = TRUE -> with 95 conf. interval

################################################################################


activity_data <- (dt_de[,list(activity_level = (2*(4-br015_) + (4-br016_))),
                  by = c("age","ph006d19", "ph006d20")]
)


activity_data <- tbl_df(activity_data)
activity_data %>%
  mutate(rheuma = ifelse(ph006d19 == 1 | ph006d20 == 1, 'yes', 'no')) %>%
  ggplot(aes(x=age,y=activity_level, color=rheuma)) + 
  geom_point() +
  ggtitle('Differences in activity with and without rheuma depending on age') +
  ylab('CAPI Score') +
  geom_smooth(method = 'lm', se=TRUE) #se = TRUE -> with 95 conf. interval

################################################################################

activity_grip <- (dt_de[,list(activity_level = (2*(4-br015_) + (4-br016_))),
                        by = c("maxgrip","ph006d19", "ph006d20")]
)


activity_grip <- tbl_df(activity_grip)
activity_grip %>%
  mutate(rheuma = ifelse(ph006d19 == 1 | ph006d20 == 1, 'yes', 'no')) %>%
  ggplot(aes(x=maxgrip, y=activity_level, color=rheuma)) + 
  geom_point() +
  ggtitle('Differences in activity with and without rheuma depending on age') +
  ylab('CAPI Score') +
  geom_smooth(method = 'lm', se=TRUE) #se = TRUE -> with 95 conf. interval
