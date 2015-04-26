get_ts_make<-function(unclean_ts){
  terminate_index<-which(unclean_ts==0)[1]
  clean_ts<-unclean_ts[-terminate_index:-42]
  clean_ts_2<-clean_ts[-1]
  clean_ts_3<-as.character(unlist(clean_ts_2))
  
  get_make<-function(makemodel){
    comma_index<-grep(x=unlist(strsplit(makemodel,split="")),pattern=",")
    substring(makemodel,0,comma_index-1)
  }
  
  results<-as.character(sapply(clean_ts_3, get_make))
}