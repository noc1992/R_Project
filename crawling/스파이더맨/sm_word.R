library(tm)
library(SnowballC)
library(dplyr)
library(KoNLP)
library(wordcloud2)
useSejongDic()

data <- read.csv("sm_tr1.csv", encoding = "euc-kr")

ds <- data %>%
  select(txt_list)

write.table(ds,"st1.txt", row.names = FALSE)

txt <- readLines("st1.txt")

txt <- gsub("ㅋ","", txt)
txt <- gsub("ㅠㅠ","",txt)
txt <- gsub("ㅜㅜ","", txt)


ts <- extractNoun(txt)
table(ts)
View(ts)
