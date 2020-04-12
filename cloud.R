install.packages("devtools")
library(devtools)
install.packages("hms")
library(hms)
install.packages("R6")
library(R6)
install.packages("tibble")
install.packages("tibble")
library(tibble)

install.packages("rJava")
library(rJava)

install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
library(stringr)
library(hash)
library(tau)
library(Sejong)
library(RSQLite)
library(readr)





install.packages("remotes")
library(remotes)
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))


devtools::install_github("lchiffon/wordcloud2")

library(wordcloud2)
install.packages("KoNLP")
library(KoNLP)

library(htmlwidgets)
library(htmltools)
library(jsonlite)
library(yaml)
library(base64enc)
install.packages("dplyr")
library(dplyr)


useSejongDic()
buildDictionary(data.frame(c("빅데이터","L.POINT","L.pay"), c("ncn")))
useNIADic()

#1
SS <- readLines('SS_CRWL.csv',encoding = 'UTF-8')
SS_1 <- sapply(SS,extractNoun,USE.NAMES = F)
SS_2 <- unlist(SS_1)
SS_3 <- gsub('\\d+','',SS_2)
SS_3 <- gsub("삼성",'',SS_3)
SS_3 <- gsub("파운드리",'',SS_3)
SS_3 <- gsub("Foundry",'',SS_3)
SS_3 <- gsub("전자",'',SS_3)
SS_3 <- gsub("반도체",'',SS_3)
SS_3 <- gsub("분기",'',SS_3)
SS_3 = gsub("\\s{2,}", " ", SS_3)
SS_3 <- gsub("파운드",'',SS_3)
SS_3 <- gsub("코로나",'',SS_3)
SS_3 <- gsub("인사",'',SS_3)
SS_3 <- gsub("지난해",'',SS_3)
SS_3 <- gsub("부회장",'',SS_3)
SS_3 <- gsub("이재",'',SS_3)
SS_3 <- gsub("부사장",'',SS_3)
SS_3 <- gsub("사업",'',SS_3)
SS_3 <- gsub("때문",'',SS_3)
SS_3 <- gsub("제품",'',SS_3)
SS_3 <- gsub("이번",'',SS_3)
SS_3 <- gsub("승진",'',SS_3)
SS_3 <- gsub("하기",'',SS_3)
SS_3 <- gsub("채용",'',SS_3)


#LM20_1Q_TITLE3 <- gsub("▲",'',LM20_1Q_TITLE3)


SS_3<-unlist(SS_3)
SS_4 <-Filter(function(x){nchar (x)>=2}, SS_3)
SS_4 <- table(SS_4)
SS_4_1 <- head(sort(SS_4,decreasing=T),100)
wordcloud2(SS_4_1,size=0.5,shape = 'circle')

#2
biz <- readLines('biz.csv',encoding = 'UTF-8')
biz_1 <- sapply(biz,extractNoun,USE.NAMES = F)
biz_2 <- unlist(biz_1)
biz_3 <- gsub('\\d+','',biz_2)
biz_3 <- gsub("롯데멤버스",'',biz_3)
biz_3 = gsub("\\s{2,}", " ", biz_3)
#LM20_1Q_TITLE3 <- gsub("▲",'',LM20_1Q_TITLE3)


biz_3<-unlist(biz_3)
biz_4 <-Filter(function(x){nchar (x)>=2}, biz_3)
biz_4 <- table(biz_4)
biz_4 <- head(sort(biz_4,decreasing=T),50)
wordcloud2(biz_4,size=0.5,shape = 'circle')

#3
sogaebiz <- readLines('sogaebiz.csv',encoding = 'UTF-8')
sogaebiz_1 <- sapply(sogaebiz,extractNoun,USE.NAMES = F)
sogaebiz_2 <- unlist(sogaebiz_1)
sogaebiz_3 <- gsub('\\d+','',sogaebiz_2)
sogaebiz_3 <- gsub("롯데멤버스",'',sogaebiz_3)
sogaebiz_3 = gsub("\\s{2,}", " ", sogaebiz_3)
#LM20_1Q_TITLE3 <- gsub("▲",'',LM20_1Q_TITLE3)


sogaebiz_3<-unlist(sogaebiz_3)
sogaebiz_4 <-Filter(function(x){nchar (x)>=2}, sogaebiz_3)
sogaebiz_4 <- table(sogaebiz_4)
sogaebiz_4_1 <- head(sort(sogaebiz_4,decreasing=T),100)
wordcloud2(sogaebiz_4_1,size=0.5,shape = 'pentagon')

?wordcloud2

