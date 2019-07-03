library(tm)
library(SnowballC)
library(dplyr)
library(KoNLP)
library(wordcloud2)
data <- read.csv("night_of_7_years.csv")
data

st <- data %>%
  select(txt_list)
std <- data.frame(st)
write.table(std, "result.txt",row.names = FALSE)
a <- readLines("result.txt",encoding = "UTF-8")

ax <- extractNoun(a)
axb <- Corpus(VectorSource(ax))

axb <- as.character(axb)
axf <- extractNoun(axb)
axf <- gsub("c", "", axf)
View(axf)
tdm <- TermDocumentMatrix(axf, control=list(tokenize=words))
useSejongDic()
