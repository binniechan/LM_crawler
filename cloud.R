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



LM20_1Q_TITLE <- readLines('RM_20_1Q_BODY.csv',encoding = 'UTF-8')
LM20_1Q_TITLE2 <- sapply(LM20_1Q_TITLE,extractNoun,USE.NAMES = F)
LM20_1Q_TITLE2 <- unlist(LM20_1Q_TITLE2)
LM20_1Q_TITLE3 <- gsub('\\d+','',LM20_1Q_TITLE2)
LM20_1Q_TITLE3 <- gsub("롯데멤버스",'',LM20_1Q_TITLE3)
LM20_1Q_TITLE3 <- gsub("▲",'',LM20_1Q_TITLE3)


LM20_1Q_TITLE3<-unlist(LM20_1Q_TITLE3)
LM20_1Q_TITLE3 <-Filter(function(x){nchar (x)>=2}, LM20_1Q_TITLE3)
LM20_1Q_TITLE_WC <- table(LM20_1Q_TITLE3)
LM20_1Q_TITLE_WC <- head(sort(LM20_1Q_TITLE_WC,decreasing=T),100)
wordcloud2(LM20_1Q_TITLE_WC,size=0.4,shape = 'star')

