library(KoNLP)
# remove.packages("rJava")
# install.packages("rJava")
# library(xlsx)
library(dplyr)
library(stringr)
library(wordcloud2)
library(tm)
buildDictionary(ext_dic = "woorimalsam")

rl <- readLines("review.txt", encoding = "euc-kr")
rl <- gsub("'","",rl)
rl <- gsub("‘","",rl)
rl <- gsub("“","",rl)
rl <- gsub("”","",rl)
rl <- gsub('[ㄱ-ㅎ]','',rl)
rl <- gsub('(ㅜ|ㅠ)+','',rl)
rl <- gsub('[~!@#$%^&*()_+=?]<>','',rl)
rl <- gsub("\\d+","",rl)
rl <- gsub("\\n","",rl)
rl <- gsub("\\.","",rl)
rl <- gsub("\n","",rl)
rl <- gsub("-","",rl)


rll <- lapply(rl, extractNoun)
rll

gsub_txt <- readLines("c_gsub.txt")
cnt_txt <- length(gsub_txt)

for (i in 1:cnt_txt) {
  rll <- gsub((gsub_txt[i]),"",rll)
}

rlf <- Filter(function(x) ( nchar(x) <= 7 & nchar(x) >= 2),rll)

rlu <- unlist(rlf)
sw <- sort(table(rlu), decreasing = T)
head(sw,30)
wordcloud2(sw)




