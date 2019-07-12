install.packages("jsonlite")
library(jsonlite)
pi
json.pi <- toJSON(pi, digits = 3)
fromJSON(json.pi)

city <- '대전'
json_city <- toJSON(city)
fromJSON(json_city)

subject <- c('국어', '영어', '수학')
json_subject <- toJSON(subject)
fromJSON(json_subject)

name <- c("Test")
age <- c(25)
sex <- c("F")
address <- c("seoul")
hobby <- c("basketball")
person <- data.frame(name, age, sex, address, hobby)
names(person) <- c("Name", "Age", "Sex", "Address", "Hobby")
str(person)

json_person <- toJSON(person) # json 파일 
prettify(json_person)

# ----------------------------------
df_json_person <- fromJSON(json_person)
str(df_json_person)

all(person == df_json_person)

# cars 내장 데이터로 테스트 

cars

json_cars <- toJSON(cars) # json 형대토 바꾸기 
df_json_cars <- fromJSON(json_cars) # json 형태에서 R의 데이터프레임 형태로 변경 

wiki_person <- fromJSON("D:/limworkspace/R_Data_Analysis/Reference/JSON/03_JSON/person.json"

str(wiki_person)
class(wiki_person)

data <- fromJSON("D:/limworkspace/R_Data_Analysis/Reference/JSON/03_JSON/sample.json")
str(data)

data <- as.data.frame(data)
names(data) <- c('id','like','share','comment','unique', 'msg', 'time')
data$like <- as.numeric(as.character(data$like)) # Factor를 numerice 으로 변경하는 방법 