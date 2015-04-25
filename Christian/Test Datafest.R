#########
#Visitor#
#########

load("visitor.RData")
load("transactions.RData")
load("shopping.RData")
load("leads.RData")
load("configuration.RData")

visitor_50<-visitor[1:50]
View(visitor_50)

useless_visitor_1<-c("session_count","paid_agg_search_flag","free_agg_search_flag"
                     ,"book_agg_search_flag","page_views","consideration_count"
                     ,"configuration_count","compact_config_count","compact_consid_count"
                     ,"compact_dealerengage_count","compact_inventory_count","compact_leads_count"
                     ,"engage_count","mydp_count","new_leads_count","option_count","price_count"
                     ,"research_count","used_consideration_count","")
