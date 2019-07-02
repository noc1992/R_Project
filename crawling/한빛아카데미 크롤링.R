# 한빛 아카데미 크롤링
library(rvest)
library(dplyr)
library(stringr)
trim <- function(x) gusb("^\\s+|\\s+$", "", x)

base_url_new <- 'http://www.hanbit.co.kr/academy/books/new_book_list.html?'
page_new <- 'page='
category_new <- '&cate_cd=&srt=&searchKey=&keyWord='
computer_books_new <- data.frame(title_new=c(), writer_new=c(), price_new=c())
for (i in 1:18) {
  
  url <- paste0(base_url_new,page_new, 'i', category_new)
  
  html <- read_html(url)
  html
  book_list <- html_node(html , '.sub_book_list_area')
  lis <- html_nodes(book_list, 'li')
  lis
  
  html %>% 
    html_node('.sub_book_list_area') %>%
    html_nodes('li') -> lis
  
  price <- c()
  title <- c()
  writer <- c()
  
  for (li in lis) {
    pr <- html_node(li, '.price') %>% html_text()
    pr <- gsub("\\\\", "", pr)
    price <- c(price, pr)
    title <- c(title, html_node(li, ".book_tit") %>% html_text())
    writer <- c(writer, html_node(li, ".book_writer") %>% html_text())
    # cat(title,writer, price, '\n')
  }
  
  books <- data.frame(title_new=title, writer_new = writer, price_new=price)
  computer_books_new <- rbind.data.frame(computer_books_new, books)
}

computer_books_new
write.csv(computer_books, file="new_books.csv", row.names = FALSE)

