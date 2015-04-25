install.packages("HMM")
library(HMM)

#########
#My TEST#
#########
observations<-cp("normal","cold","dizzy")
states_1<-c("Healthy","Fever")
symbols_1<-c("normal","cold","dizzy")
start_probs_1<-c(.6,.4)
trans_probs_1<-matrix(c(.7,.3,0.4,.6),2)
emission_probs_1<-matrix(c(0.5,0.4,0.1,0.1,0.3,0.6),2)

HMM_2<-initHMM(States=states_1,Symbols=symbols_1,startProbs=start_probs_1,
         transProbs=trans_probs_1,emissionProbs=emission_probs_1)

veterbi_1 = viterbi(HMM_2,observations)
