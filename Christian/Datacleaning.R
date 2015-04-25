load("clean_visitor.RData")
load("clean_transactions.RData")
load("clean_shopping.RData")
load("clean_leads.RData")
load("clean_configuration.RData")
load("merged_data.RData")

names("merged.data4.final")

new_Data<-merged.data4.final
names(new_Data)

head(table(shopping$visitor_key))

shopping_mini<-shopping[1:10000,]

a<-tapply(shopping_mini$,shopping$visitor_key,mean)

subsetted<-subset(shopping_mini,duplicated(shopping_mini$visitor_key))
table(subsetted$visitor_key)

test<-c(1,2,3,1,1,2)
good<-table(test)>1

subsetted<-subset(test,duplicated(test))
?duplicated
