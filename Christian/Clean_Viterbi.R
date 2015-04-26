load("training_set.Rdata")
load("visitor_final.Rdata")

#Functions

get_ts<-function(unclean_ts){
  terminate_index<-which(unclean_ts==0)[1]
  clean_ts<-unclean_ts[-terminate_index:-42]
  clean_ts<-clean_ts[-1]  
}

get_ts_model<-function(unclean_ts){
  terminate_index<-which(unclean_ts==0)[1]
  clean_ts<-unclean_ts[-terminate_index:-42]
  clean_ts_2<-clean_ts[-1]
  clean_ts_3<-as.character(unlist(clean_ts_2))
  
  get_model<-function(makemodel){
    comma_index<-grep(x=unlist(strsplit(makemodel,split="")),pattern=",")
    substring(makemodel,0,comma_index-1)
  }
  
  results<-as.character(sapply(clean_ts_3, get_model))
}

get_normalized_trans<-function(clean_ts,hidden_length,hidden_states){
  observation = as.character(unlist(clean_ts))
  test<-as.data.frame(expand.grid(hidden_states,hidden_states))
  part1<-as.character(unlist(test[1]))
  part2<-as.character(unlist(test[2]))
  
  grid_starter<-paste(part1,part2)
  
  total_counts<-NULL
  for(i in 1:length(grid_starter)){
    
    count<-car_freq[grid_starter[i]==car_freq$total_string,]
    if(length(count[,1])==0){
      temp_names<-names(count)
      count=as.data.frame(t(c(grid_starter[i],1)))
      names(count)<-temp_names
    }
    total_counts<-rbind(total_counts,count)
  }
  transition_matrix<-matrix(as.numeric(total_counts$Freq),nrow=hidden_length)
  normalize<-function(row){
    return(row/sum(row))
  }
  normalize_matrix<-apply(X=transition_matrix,MARGIN = 1,FUN=normalize)
}
################################################################################


total_success_rates<-NULL

for(i in 1:length(training_set3[,1])){
  unclean_ts<-training_set3[i,]
  
  clean_ts<-get_ts_model(unclean_ts)
  observation<-clean_ts
  
  hidden_states<-unique(clean_ts)
  hidden_length<-length(hidden_states)
  normalize_matrix<-get_normalized_trans(clean_ts,hidden_length,hidden_states)
  if(normalize_matrix==1){
    total_success_rates<-c(total_success_rates,1)
    print(i)
    print(rate)
  }
  else{
  hmm = initHMM(States=hidden_states,Symbols=hidden_states,
                startProbs=matrix(rep(x=.1,times=hidden_length),nrow=hidden_length),
                transProbs=normalize_matrix,
                emissionProbs=normalize_matrix)
  
  # Baum-Welch
  bw = baumWelch(hmm,observation,maxIterations=2)
  
  veterbi_1 = viterbi(hmm,observation)
  
  success_rates<-as.list(table(clean_ts==veterbi_1))
  names(success_rates)<-tolower(names(success_rates))
  true_success<-success_rates$true
  if(exists("true_success")){
    rate<-success_rates$true/sum(table(clean_ts==veterbi_1))
  }
  else{
    rate<-0
  }
  total_success_rates<-c(total_success_rates,rate)
  print(i)
  print(rate)
  }
}


