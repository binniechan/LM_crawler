install.packages("rvest")
install.packages("tibble")
install.packages("dplyr")
install.packages("readr")
library(rvest)
library(tibble)
library(dplyr)
library(readr)

aticles_dd<-c()
aticles_dt<-c()

rm(list=ls())

# total_length <- read_html(tar,encoding="CP949") %>%
#  html_nodes(".Nnavi a") %>%
#  html_text %>%
#  length()

#na_length <- read_html(tar,encoding="CP949") %>%
#  html_nodes(".Nnavi a") %>%
#  html_text %>%
#  as.numeric() %>%
#  is.na() %>%
#  sum()

#real_length<-total_length-na_length



# max page check
tar<-"https://finance.naver.com/news/news_search.nhn?rcdate=&q=%B7%D4%B5%A5%B8%E2%B9%F6%BD%BA&x=0&y=0&sm=all.basic&pd=4&stDateStart=2019-01-01&stDateEnd=2019-02-28&page=1"


max_page <- function(tar_url) {
  read_html(tar_url,encoding="CP949") %>%
    html_nodes(".Nnavi a") %>%
    html_text %>%  
    as.numeric() %>%
    na.omit() %>%
    max() %>%
    return
  }

max<-max_page(tar)

root<-"https://finance.naver.com"

# 사진있는 기사 크롤링

for(i in 1:max) {
  tar_url<-paste0("https://finance.naver.com/news/news_search.nhn?rcdate=&q=%B7%D4%B5%A5%B8%E2%B9%F6%BD%BA&x=0&y=0&sm=all.basic&pd=4&stDateStart=2019-01-01&stDateEnd=2019-02-28&page=",i)
  print(tar_url)
    read_html(tar_url,encoding="CP949") %>%
    html_nodes("dd.articleSubject a") %>%
    html_attr("href") -> link_list_dd
    
  
  for(j in 1:length(link_list_dd)) {
    tar_dd <- paste0(root, link_list_dd[j])
    news_dd <- read_html(tar_dd,encoding="CP949")
    gsub('\n|\t','',news_dd %>%
      html_nodes(".article_info h3") %>%
      html_text()) %>%
      trimws() -> title_dd
    
    news_dd %>%
      html_nodes("div#content") %>%
      as.character() %>%
      strsplit("<br>|</div>|<div>") %>%
      .[[1]] %>%
      trimws() -> body_dd
    body_dd<-body_dd[-grep(("<"),body_dd)]
    body_dd<-body_dd[nchar(body_dd)>1]
    body_dd<-body_dd[-grep("@", body_dd)]
    
    tem_dd <- tibble(title_dd,body_dd)
    aticles_dd %>%
      bind_rows(tem_dd) -> aticles_dd
    
  }
    
}

readr::write_excel_csv(aticles_dd,"RM_190101_190228")

# 사진없는 기사 크롤링


for(i in 1:max) {
  tar_url<-paste0("https://finance.naver.com/news/news_search.nhn?rcdate=&q=%B7%D4%B5%A5%B8%E2%B9%F6%BD%BA&x=0&y=0&sm=all.basic&pd=4&stDateStart=2019-01-01&stDateEnd=2019-02-28&page=",i)
  print(tar_url)
  if(length(which(!is.na(read_html(tar_url,encoding="CP949") %>%
     html_nodes("dt.articleSubject a")))) == 0) {
    next
  } else {
    read_html(tar_url,encoding="CP949") %>%
      html_nodes("dt.articleSubject a") %>%
      html_attr("href") -> link_list_dt
  }
  
  
  for(j in 1:length(link_list_dt)) {
    tar_dt <- paste0(root, link_list_dt[j])
    news_dt <- read_html(tar_dt,encoding="CP949")
    gsub('\n|\t','',news_dt %>%
           html_nodes(".article_info h3") %>%
           html_text()) %>%
      trimws() -> title_dt
    
    news_dt %>%
      html_nodes("div#content") %>%
      as.character() %>%
      strsplit("<br>|</div>|<div>") %>%
      .[[1]] %>%
      trimws() -> body_dt
    body_dt<-body_dt[-grep(("<"),body_dt)]
    body_dt<-body_dt[nchar(body_dt)>1]
    body_dt<-body_dt[-grep("@",  body_dt)]
    
    tem_dt <- tibble(title_dt,body_dt)
    aticles_dt %>%
      bind_rows(tem_dt) -> aticles_dt
    
  }
  
}

readr::write_excel_csv(aticles_dt,"RM_190101_190228_2")
