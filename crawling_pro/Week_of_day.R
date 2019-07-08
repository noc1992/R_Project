library(dplyr)
library(ggthemes)
library(stringr)
library(tm)
library(ggplot2)
library(showtext)
library(RColorBrewer)
library(extrafont)
library(nycflights13)
library(tidyverse)
library(lubridate)
windowsFonts(goB= windowsFont("고도 B"))

data <- read.csv("cine.csv", encoding = "euc-kr")

sts <- data %>%
  select(time,score)

rep <- replace(sts, sts=="#N/A",NA)

sto <- na.omit(rep)
head(sto)

x <- ymd_hm(sto$time) 
score <- sto$score

Year=year(x);Month=month(x);Day=mday(x); Week=wday(x); Hour=hour(x); Minute=minute(x)  
da <- cbind(Year,Month,Day,Hour,Week,score)
dad <- as.data.frame(da)
head(dad)

wd <- dad %>%
  select(Week, score) %>%
  group_by(Week) %>%
  summarise(mean = mean(score))
wd$Week <- recode(wd$Week,"일","월","화","수","목","금","토")
order <- c(1:7)
options(digits = 2)
wdo <- data.frame(wd,order)


ggplot(data = wdo, aes(x=reorder(Week,order),y=mean,fill=Week)) + geom_bar(stat='identity') + 
  coord_cartesian(ylim=c(9,9.8)) +
  scale_fill_discrete(limits=c("일","월","화","수","목","금","토")) +
  geom_text(aes(label=round(mean,2)),col="black",vjust=-0.1,size=3) +
  ggtitle("요일별 평점 평균 변화") + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="goB", face="bold",size=17, color='royalblue'),
        axis.title=element_text(size=13),
        axis.title.y=element_text(angle=0),
        axis.text.x=element_text(angle=0, size=13)) 

