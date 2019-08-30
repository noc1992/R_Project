# 교보문고에서 7년의  밤 구매 리뷰 크롤링

library(rvest)
library(stringr)
library(dplyr)
library(httr)
trim <- function(x) gsub("^\\s+|\\s+$", "", x)

url_base <- 'http://www.kyobobook.co.kr/product/detailViewKor.laf?ejkGb=KOR&mallGb=KOR&barcode=9788956604992&orderClick=LAG&Kc=#N'

html <- read_html(url_base, encoding = "euc-kr")














