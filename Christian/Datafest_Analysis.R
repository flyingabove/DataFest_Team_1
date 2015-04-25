load("training_set.Rdata")
load("visitor_final.Rdata")

unclean_ts<-training_set3[training_set3$visitor_key==7623175409022868480,]

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


ID<-unclean_ts[1]
clean_ts<-get_ts_model(unclean_ts)

hidden_states<-unique(get_ts_model(unclean_ts))
hidden_length<-length(hidden_states)
hmm = initHMM(States=hidden_states,Symbols=hidden_states,
              startProbs=matrix(rep(x=1/hidden_length,times=hidden_length),nrow=hidden_length),
              transProbs=matrix(rep(x=.2,times=hidden_length^2),hidden_length),
              emissionProbs=matrix(rep(x=.9,times=hidden_length^2),hidden_length))
print(hmm)
# Sequence of observation
observation = as.character(unlist(clean_ts))

# Baum-Welch
bw = baumWelch(hmm,observation,maxIterations=100)

veterbi_1 = viterbi(bw$hmm,observation)

print(bw$hmm)

length(hidden_states)
?matrix
