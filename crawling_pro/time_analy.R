library(dplyr)
library(stringr)
library(tm)
library(ggplot2)
library(showtext)
library(RColorBrewer)
library(extrafont)
library(nycflights13)
library(tidyverse)
library(lubridate)


font_import(pattern = 'BMHANNAPro')
loadfonts()
fonts()
windowsFonts(bm=windowsFont("BMHANNAPro"))

data <- read.csv("cine.csv", encoding = "euc-kr")
head(data)

sts <- data %>%
  select(time,score)

rep <- replace(sts, sts=="#N/A",NA)

sto <- na.omit(rep)
View(sto)
sum(is.na(sto))

x <- ymd_hm(sto$time)
score <- sto$score

Year=year(x);Month=month(x);Day=mday(x); Week=wday(x); Hour=hour(x); Minute=minute(x)  
da <- cbind(Year,Month,Day,Hour,Week,score)
dad <- as.data.frame(da)
head(dad)

da1 <- dad %>%
  select(Hour, score) %>%
  group_by(Hour) %>%
  summarise(mean = mean(score))
View(da1)

ggplot(da1, aes(x=Hour,y=mean)) +
  geom_point(size=4,aes(col = Hour)) +
  theme_bw(base_family = "Malgun Gothic", base_size = 8) +
  geom_text(aes(label=sprintf("%.2f",mean)),size=4,hjust=1,vjust=0) +
  geom_line(linetype = "dashed") + ggtitle("시간대별 평균 평점 비교") + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="Malgun Gothic", face="bold",size=17, color='darkblue'),
        axis.title=element_text(size=13),
        axis.title.y=element_text(angle=0),
        axis.text.x=element_text(angle=90, size=10))

head(dad)
da2 <- dad %>%
  filter(Year == "2003" | Year=="2004" | Year=="2005"| Year=="2006"| Year=="2007"| Year=="2008") %>%
  select(Hour, score) %>%
  group_by(Hour) %>%
  summarise(mean = mean(score))

m2 <- round(mean(da2$mean))

View(da2)
ggplot(da2, aes(x=Hour,y=mean)) +
  geom_point(size=4,aes(col = Hour)) +
  theme_bw(base_family = "Malgun Gothic", base_size = 8) +
  geom_text(aes(label=sprintf("%.2f",mean)),size=4,hjust=1,vjust=0) +
  geom_line(linetype = "dashed") + ggtitle("노 대통령 당시 시간대별 평균 평점 비교", "전체 평균:", m2) + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="Malgun Gothic", face="bold",size=11, color='darkblue'),
        axis.title=element_text(size=13),
        axis.title.y=element_text(angle=0),
        axis.text.x=element_text(angle=90, size=10))

da3 <- dad %>%
  filter(Year == "2008" | Year=="2008" | Year=="2010" | Year=="2011" | Year=="2012" | Year=="2013") %>%
  select(Hour, score) %>%
  group_by(Hour) %>%
  summarise(mean = mean(score))

ggplot(da3, aes(x=Hour,y=mean)) +
  geom_point(size=4,aes(col = Hour)) +
  theme_bw(base_family = "Malgun Gothic", base_size = 8) +
  geom_text(aes(label=sprintf("%.2f",mean)),size=4,hjust=1,vjust=0) +
  geom_line(linetype = "dashed") + ggtitle("이 대통령 당시 간대별 평균 평점 비교") + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="Malgun Gothic", face="bold",size=13, color='darkblue'),
        axis.title=element_text(size=13),
        axis.title.y=element_text(angle=0),
        axis.text.x=element_text(angle=90, size=10))


da4 <- dad %>%
  filter(Year == "2013" | Year=="2014" | Year=="2015" | Year=="2016" | Year=="2017") %>%
  select(Hour, score) %>%
  group_by(Hour) %>%
  summarise(mean = mean(score))

ggplot(da4, aes(x=Hour,y=mean)) +
  geom_point(size=4,aes(col = Hour)) +
  theme_bw(base_family = "Malgun Gothic", base_size = 8) +
  geom_text(aes(label=sprintf("%.2f",mean)),size=4,hjust=1,vjust=0) +
  geom_line(linetype = "dashed") + ggtitle("박 대통령 당시 시간대별 평균 평점 비교") + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="Malgun Gothic", face="bold",size=13, color='darkblue'),
        axis.title=element_text(size=13),
        axis.title.y=element_text(angle=0),
        axis.text.x=element_text(angle=90, size=10))


da5 <- dad %>%
  filter(Year == "2017" | Year=="2018" | Year=="2019") %>%
  select(Hour, score) %>%
  group_by(Hour) %>%
  summarise(mean = mean(score))

ggplot(da5, aes(x=Hour,y=mean)) +
  geom_point(size=4,aes(col = Hour)) +
  theme_bw(base_family = "Malgun Gothic", base_size = 8) +
  geom_text(aes(label=sprintf("%.2f",mean)),size=4,hjust=1,vjust=0) +
  geom_line(linetype = "dashed") + ggtitle("문 대통령(현재까지) 시간대별 평균 평점 비교") + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="Malgun Gothic", face="bold",size=13, color='darkblue'),
        axis.title=element_text(size=13),
        axis.title.y=element_text(angle=0),
        axis.text.x=element_text(angle=90, size=10))

