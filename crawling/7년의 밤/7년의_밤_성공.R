library(rvest)
library(stringr)

base_url <- 'http://www.yes24.com/Product/communityModules/AwordReviewList/4701388?_='
page <- '&PageNumber='
code <- 1562116914766

title_list = character()
star_list = numeric()
txt_list = character()

for ( i in 1:30) {
  url = paste(base_url,code,page,i, sep = "")
  content = read_html(url)
  
  node1 = html_nodes(content, ".lnk_nick")
  node2 = html_nodes(content, "#infoset_oneCommentList .rating")
  node3 = html_nodes(content, ".cmt_cont .txt")
  
  title = html_text(node1)
  star = html_text(node2)
  txt = html_text(node3)
  
  title_list = append(title_list, title)
  star_list = append(star_list, star)
  txt_list = append(txt_list, txt)

}

df = data.frame(title_list, star_list, txt_list)
df
write.csv(df, file = "night_of_7_years.csv", row.names = FALSE)
