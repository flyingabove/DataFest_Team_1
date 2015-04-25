library(HiddenMarkov)
library(HMM)
library(depmixS4)

hmm = initHMM(States=c("State1","State2"),Symbols=c("NoEggs","Eggs"),
              startProbs=matrix(c(.2,.8),2),
              transProbs=matrix(c(.5,.3,.5,.7),2),
              emissionProbs=matrix(c(.3,.8,.7,.2),2))
?initHMM
print(hmm)
# Sequence of observation
observation = c("NoEggs","NoEggs","NoEggs","NoEggs","NoEggs","Eggs","Eggs","NoEggs","NoEggs","NoEggs")
# Baum-Welch
bw = baumWelch(hmm,observation,maxIterations=100)
print(bw$hmm)
?baumWelch

hmm = initHMM(c("A","B"),c("L","R"),
              transProbs=matrix(c(.9,.1,.1,.9),2),
              emissionProbs=matrix(c(.5,.51,.5,.49),2))
print(hmm)
# Sequence of observation
a = sample(c(rep("L",100),rep("R",300)))
b = sample(c(rep("L",300),rep("R",100)))
observation = c(a,b)
# Baum-Welch
bw = baumWelch(hmm,observation,10)
print(bw$hmm)
