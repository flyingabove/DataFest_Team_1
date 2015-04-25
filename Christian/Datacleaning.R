load("clean_visitor.RData")
load("clean_transactions.RData")
load("clean_shopping.RData")
load("clean_leads.RData")
load("clean_configuration.RData")
#load("merged_data.RData")

#Take out all the instances with only one
shopping_keys<-shopping$visitor_key[shopping$visitor_key
                                         %in% unique(shopping$visitor_key
                                                     [ duplicated(shopping$visitor_key)]) ]
#Keep rows with only more than 3 instances
cVals <- data.frame(table(shopping_keys))
Rows <- shopping$visitor_key %in% cVals[cVals$Freq > 3,1] 
training_set<-shopping[Rows,]

head(sort(table(training_set$visitor_key),decreasing=TRUE)) #Take a look!
