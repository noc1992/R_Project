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

mod <- dad %>% 
  select(Year, Month) %>% 
  mutate(time = make_datetime(Year, Month))
head(mod)

score <- sto$score
time <- mod$time

mod0 <- data.frame(time, score)

mod00 <- mod0 %>%
  group_by(time) %>%
  summarise(mean = mean(score))
head(mod00)
ggplot(data = mod00, aes(x=time, y=mean)) + geom_line(size=0.5, col="red") + 
  ggtitle("월별 평점 평균 변화") + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="goB", face="bold",size=17, color='royalblue'),
        axis.title=element_text(size=13),
        axis.title.y=element_text(angle=0),
        axis.text.x=element_text(angle=0, size=10)) 


mod12_14 <- dad %>%
  filter(Year=="2012" | Year=="2013" | Year == "2014") %>%
  select(Year, Month, score) %>%
  mutate(time = make_datetime(Year, Month)) %>%
  select(time, score)

m_mod12_14 <- mod12_14 %>%
  group_by(time) %>%
  summarise(mean = mean(score))


ggplot(data = m_mod12_14, aes(x=time, y=mean)) + geom_line(size=0.5, col="red") + 
  ggtitle("12-14년도 기간동안 월별 평점 평균 변화") + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="goB", face="bold",size=17, color='royalblue'),
        axis.title=element_text(size=13),
        axis.title.y=element_text(angle=0),
        axis.text.x=element_text(angle=0, size=10)) 


mod13 <- dad %>%
  filter(Year=="2013") %>%
  select(Year, Month, score) %>%
  mutate(time = make_datetime(Year, Month)) %>%
  select(time, score)

m_mod13 <- mod13 %>%
  group_by(time) %>%
  summarise(mean = mean(score))


ggplot(data = m_mod13, aes(x=time, y=mean)) + geom_line(size=0.5, col="red") + 
  ggtitle("13년도 기간동안 월별 평점 평균 변화") + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="goB", face="bold",size=17, color='royalblue'),
        axis.title=element_text(size=13),
        axis.title.y=element_text(angle=0),
        axis.text.x=element_text(angle=0, size=10)) 
