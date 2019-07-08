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
windowsFonts(goB= windowsFont("고도 B"))



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
  geom_line(size=2,aes(colour = Hour)) +
  theme_bw(base_family = "goB", base_size = 7) +
  geom_text(aes(label=sprintf("%.2f",mean)),size=4,hjust=1,vjust=0,check_overlap = T) +
  geom_line(linetype = "dashed") + ggtitle("시간대별 평균 평점 비교") + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="goB", face="bold",size=17, color='royalblue'),
        axis.title=element_text(size=13),
        axis.title.y=element_text(angle=0),
        axis.text.x=element_text(angle=90, size=10)) 


head(dad)
da2 <- dad %>%
  filter(Year == "2003" | Year=="2004" | Year=="2005"| Year=="2006"| Year=="2007"| Year=="2008") %>%
  select(Hour, score) %>%
  group_by(Hour) %>%
  summarise(mean = mean(score))

da3 <- dad %>%
  filter(Year == "2008" | Year=="2008" | Year=="2010" | Year=="2011" | Year=="2012" | Year=="2013") %>%
  select(Hour, score) %>%
  group_by(Hour) %>%
  summarise(mean = mean(score))

da4 <- dad %>%
  filter(Year == "2013" | Year=="2014" | Year=="2015" | Year=="2016" | Year=="2017") %>%
  select(Hour, score) %>%
  group_by(Hour) %>%
  summarise(mean = mean(score))

da5 <- dad %>%
  filter(Year == "2017" | Year=="2018" | Year=="2019") %>%
  select(Hour, score) %>%
  group_by(Hour) %>%
  summarise(mean = mean(score))

ggplot(da1, aes(x=Hour,y=mean)) +
  geom_line(size=1,col="black") + 
  geom_line(data=da2, aes(x=Hour,y=mean), col = "chartreuse",size=1) +
  scale_colour_discrete(labels=c("노대통령", "평균")) +
  ggtitle("평균과 비교(노대통령)") + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="goB", face="bold",size=17, color='royalblue'),
        axis.title=element_text(size=13),
        axis.title.y=element_text(angle=0),
        axis.text.x=element_text(angle=90, size=10))

ggplot(da1, aes(x=Hour,y=mean)) +
  geom_line(size=1,col="black") + 
  geom_line(data=da3, aes(x=Hour,y=mean), col = "firebrick",size=1) +
  scale_colour_discrete(labels=c("이대통령", "평균")) +
  ggtitle("평균과 비교(이대통령)") + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="goB", face="bold",size=17, color='royalblue'),
        axis.title=element_text(size=13),
        axis.title.y=element_text(angle=0),
        axis.text.x=element_text(angle=90, size=10))

ggplot(da1, aes(x=Hour,y=mean)) +
  geom_line(size=1,col="black") + 
  geom_line(data=da4, aes(x=Hour,y=mean), col = "firebrick4",size=1) +
  scale_colour_discrete(labels=c("박대통령", "평균")) +
  ggtitle("평균과 비교(박대통령)") + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="goB", face="bold",size=17, color='royalblue'),
        axis.title=element_text(size=13),
        axis.title.y=element_text(angle=0),
        axis.text.x=element_text(angle=90, size=10))


ggplot(da1, aes(x=Hour,y=mean)) +
  geom_line(size=1,col="black") + 
  geom_line(data=da5, aes(x=Hour,y=mean), col = "royalblue",size=1) +
  scale_colour_discrete(labels=c("문대통령~현재", "평균")) +
  ggtitle("평균과 비교(문대통령~현재)") + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="goB", face="bold",size=17, color='royalblue'),
        axis.title=element_text(size=13),
        axis.title.y=element_text(angle=0),
        axis.text.x=element_text(angle=90, size=10))

options(digits = 2)
m1 <- mean(da1$mean)
m2 <- mean(da2$mean)
m3 <- mean(da3$mean)
m4 <- mean(da4$mean)
m5 <- mean(da5$mean)

x1 <- c(m1,m2,m3,m4,m5)
x2 <- c("평균","노","이","박","문")
x3 <- c(1,2,3,4,5)

mdat <- data.frame(x1,x2,x3)
colnames(mdat) <- c("mean", "term","order")
mdat 

ggplot(mdat, aes(x=reorder(term,order), y=mean,fill=term)) + geom_col() +
  coord_cartesian(ylim=c(9,9.8)) +
  ggtitle("시간대별 평균 비교") + 
  labs(x="시간대", y="평점") +
  theme(plot.title=element_text(family="goB", face="bold",size=17, color='royalblue'),
        axis.title=element_text(family="goB",size=13),
        axis.title.y=element_text(family="goB",angle=0),
        axis.text.x=element_text(family="goB",angle=0, size=10))

               
   