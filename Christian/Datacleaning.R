load("clean_visitor.RData")
load("clean_transactions.RData")
load("clean_shopping.RData")
load("clean_leads.RData")
load("clean_configuration.RData")
#load("merged_data.RData")

library(lubridate)

#Take out all the instances with only one
shopping_keys<-shopping$visitor_key[shopping$visitor_key
                                         %in% unique(shopping$visitor_key
                                                     [ duplicated(shopping$visitor_key)]) ]

#Keep rows with only more than 3 instances less than 101
#This is because later we dont want a billion columns
cVals <- data.frame(table(shopping_keys))
Rows <- shopping$visitor_key %in% cVals[(cVals$Freq > 3)&(cVals$Freq < 101),1]
training_set<-shopping[Rows,]

head(sort(table(training_set$visitor_key),decreasing=TRUE)) #Take a look!

#Make Date Time variables
training_set_mini<-training_set[1:100000,]
training_set_mini$date<-ymd(training_set_mini$click_date)
training_set2<-training_set_mini[-2]#remove old date
length(training_set[,1])
#Sort to Horizontal

#user_info<-training_set[training_set$visitor_key==-5389273641311900672,] #Test Function
#user_info$date<-ymd(user_info$click_date)

create_rows<-function(user_info){
  
  sorted_by_date<-user_info[order(user_info$date,decreasing=TRUE),]
  make_model<-paste(sorted_by_date$make_name,sorted_by_date$model_name,sep=",")#extract only make model
  make_model_clean<-make_model[make_model!="-1,-1"]
  car_order<-c(unique(user_info$visitor_key),make_model_clean)
}

unqiue_keys<-unique(training_set2$visitor_key)
unique_length<-length(unqiue_keys)

training_set3<-NULL

for( i in 1:unique_length){
  
  temp_set<-training_set2[training_set2$visitor_key==unqiue_keys[i],]
  temp_timeseries<-create_rows(temp_set)
  if(length(temp_timeseries)<101){
    temp_timeseries<-c(temp_timeseries,rep(0,times=101-length(temp_timeseries)))
  }
  print(i)
  training_set3<-rbind(training_set3,temp_timeseries)
}

View(training_set3)
table(training_set2$visitor_key)

library(plyr)
group_list<-dlply(training_set2, .(training_set2$visitor_key,training_set2$make_name))
View()
length(training_set2[,1])
library(dplyr)

results<-training_set_mini%>%group_by(visitor_key)%>%select_first_n_groups(2)

head(training_set_mini)
head(results)
