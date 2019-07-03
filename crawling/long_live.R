library(rvest)
library(stringr)

base_url <- 'https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=179125&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page='

id_list <- character()
star_list <- numeric()
txt_list <- character()

for (i in 1:607) {
  url = paste(base_url,i, sep = "")
  content = read_html(url)
  
  node1 = html_nodes(content, ".score_reple a span")
  node2 = html_nodes(content, ".score_result .star_score em")
  node3 = html_nodes(content, ".score_reple p")
  
  id = html_text(node1)
  star = html_text(node2)
  txt = html_text(node3)
  
  id_list = append(id_list, id)
  star_list = append(star_list, star)
  txt_list = append(txt_list, txt)
  
}

df = data.frame(id_list, star_list, txt_list)
write.csv(df, file = "long_live.csv", row.names = FALSE)



