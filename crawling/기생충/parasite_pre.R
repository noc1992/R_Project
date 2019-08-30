library(tm)
library(SnowballC)
library(dplyr)
library(KoNLP)
library(wordcloud2)
useSejongDic()
# data <- read.csv("parasite_1.csv", encoding = "euc-kr")
# 
# ds <- data %>%
#   select(txt_list)
# 
# write.table(ds,"parasite.txt", row.names = FALSE)

txt <- readLines("parasite.txt",encoding = "euc-kr")

ts <- sapply(txt, extractNoun,USE.NAMES = F)



