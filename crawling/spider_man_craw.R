# NAVER 영화('스파이더맨') 전문가리뷰 크롤링
library(rvest)
library(stringr)
library(dplyr)
trim <- function(x) gsub("^\\s+|\\s+$", "", x)

url_base <- 'https://movie.naver.com/movie/bi/mi/point.nhn?code=173123#pointAfterTab'
url <- paste0(url_base, encoding="euc-kr")
html <- read_html(url)
head(html)
html

html %>%
  html_nodes('.ifr_module2') %>%
  html_nodes('.score_result') %>%
  html_nodes('li') -> lis
lis
