#
# a function that simulates n turns with a d sided dice
simulate_monopoly=function(n,d){
  chance_pos=sample(0:15,1) #shuffle the CH pile
  CC_pos=sample(0:15,1) # shuffle the CC pile
  position=0 # set the default
  doubles=0 # set the default
  save_pos=numeric(n+1) # set the default
  for (i in 1:n){   # loop for n turns
    dice1=sample(1:d,1) # throw the dice1
    dice2=sample(1:d,1) # throw the dice2
    if (dice1==dice2){    # count the doubles
      doubles=doubles+1
    }else{
      doubles=0
    }
    if (doubles>2){ # if doubles >2, then go to jail
      position=10
      doubles=0
    }else {
      position=(dice1+dice2+position)%%40 # get the position

      if (position==2|position==17|position==33){  # landing on CC and picking a card
        CC=c(0,10)
        CC_pos=(CC_pos)%%16+1
        if (CC_pos<2){
          position=CC[CC_pos]
        }
      }
      if (position==7|position==22|position==36){ # landing on CH and picking a card
        chance=c(0,10,11,24,39,5)
        chance_pos=(chance_pos)%%16+1
        if (chance_pos<6){
          position=chance[chance_pos]
        }
        if (chance_pos==6|chance_pos==7){
          if (position==7){
            position=15
          }
          if (position==22){
            position=25
          }
          if (position==36){
            position=5
          }
        }
        if (chance_pos==8){
          if (position==12){
            position=28
          }
          if (position==28){
            position=12
          }
        }
        if (chance_pos==9){
          position=position-3
        }
        
      }
      if (position==30){ # landing on G2J and go to jail
        position=10
      }
      
    }
    save_pos[i+1]=position # save the current position
  }
  save_pos
}

table(simulate_monopoly(1000,6))
a=as.data.frame(prop.table(table(simulate_monopoly(1000,6))))
a
sum(a$Freq)

#

# esimate the long-term probabilities of ending a turn on each square
estimate_monopoly=function(pos){
  df=as.data.frame(prop.table(table(pos)))
  df$pos=as.numeric(as.character(df$pos))
  df
}

# the long-term probabilities of ending a turn on each square for different sided dices
prob_3side=estimate_monopoly(simulate_monopoly(100000,3)) 
prob_4side=estimate_monopoly(simulate_monopoly(100000,4))
prob_4side[order(-prob_4side$Freq),] # order the long-term probabilities of 4 sided dice
prob_5side=estimate_monopoly(simulate_monopoly(100000,5))
prob_6side=estimate_monopoly(simulate_monopoly(100000,6))
prob_6side[order(-prob_6side$Freq),] # order the long-term probabilities of 6 sided dice

# plot the long-term probabilities
par(mfrow=c(2,2))
plot(prob_3side$pos,prob_3side$Freq,type="h",main="The Long-term Probabilities of Ending A Turn On Each Square (3 Sided)",xlab="Position",ylab="Probability",ylim=c(0,0.08))
plot(prob_4side$pos,prob_4side$Freq,type="h",main="The Long-term Probabilities of Ending A Turn On Each Square (4 Sided)",xlab="Position",ylab="Probability",ylim=c(0,0.08))
plot(prob_5side$pos,prob_5side$Freq,type="h",main="The Long-term Probabilities of Ending A Turn On Each Square (5 Sided)",xlab="Position",ylab="Probability",ylim=c(0,0.08))
plot(prob_6side$pos,prob_6side$Freq,type="h",main="The Long-term Probabilities of Ending A Turn On Each Square (6 Sided)",xlab="Position",ylab="Probability",ylim=c(0,0.08))



#

prob_jail=numeric(1000) # create an empty vector of length = 1000

start_time <- Sys.time() # start recoding time

# estimate the long-term probability
for (i in 1:1000){
  ddf=estimate_monopoly(simulate_monopoly(10000,6))
  prob_jail[i]=ddf$Freq[ddf$pos==10]
}

end_time <- Sys.time()

end_time - start_time # calculate the duration

# a function that calculates se
se=function(x){
  sqrt(var(x)/length(x))
}

se_jail=se(prob_jail)

# Alternative method for comapring time with Q4
prob_jail_test=numeric(1000)
start_time_test <- Sys.time() # start recording time
for (i in 1:1000){
  prob_test = simulate_monopoly(10000,6)
  prob_jail_test[i] = (table(prob_test)/10000)[11]
}

end_time_test <- Sys.time()

end_time_test - start_time_test # duration

#

b=1000
prob_jail_boot=numeric(1000)
sample1=simulate_monopoly(10000,6)

start_time_2 <- Sys.time()

# bootstrapping the sample
for(i in 1:b){
  sample_boot = sample(sample1,replace=TRUE)
  prob_jail_boot[i] = (table(sample_boot)/length(sample_boot))[11]
}

end_time_2 <- Sys.time()

end_time_2 - start_time_2 # duration

prob_jail_boot
se(prob_jail_boot)

#
# se for 3 sided
prob_jail_3=estimate_monopoly(simulate_monopoly(10000,3))
for (i in 2:1001){
  ddf_3=estimate_monopoly(simulate_monopoly(10000,3))
  prob_jail_3[i]=ddf_3$Freq
}
prob_jail_3$se=apply(prob_jail_3[-1],1,se)
plot(prob_jail_3$pos,prob_jail_3$se,type="h")

# se for 4 sided
prob_jail_4=estimate_monopoly(simulate_monopoly(10000,4))
for (i in 2:1001){
  ddf_4=estimate_monopoly(simulate_monopoly(10000,4))
  prob_jail_4[i]=ddf_4$Freq
}
prob_jail_4$se=apply(prob_jail_4[-1],1,se)


# se for 5 sided
prob_jail_5=estimate_monopoly(simulate_monopoly(10000,5))
for (i in 2:1001){
  ddf_5=estimate_monopoly(simulate_monopoly(10000,5))
  prob_jail_5[i]=ddf_5$Freq
}

prob_jail_5$se=apply(prob_jail_5[-1],1,se)

# se for 6 sided
prob_jail_6=estimate_monopoly(simulate_monopoly(10000,6))
for (i in 2:1001){
  ddf_6=estimate_monopoly(simulate_monopoly(10000,6))
  prob_jail_6[i]=ddf_6$Freq
}

prob_jail_6$se=apply(prob_jail_6[-1],1,se)

# merge the ses'
prob_jail_3456=prob_3side
names(prob_jail_3456)[2]="se3"
prob_jail_3456$se3=prob_jail_3$se
prob_jail_3456$se4=prob_jail_4$se
prob_jail_3456$se5=prob_jail_5$se
prob_jail_3456$se6=prob_jail_6$se

# display the se values
plot(prob_jail_3456$pos,prob_jail_3456$se3,type="h",main="The Standard Error (3 Sided)",xlab="Position",ylab="Standard Error",ylim=c(0,1e-04))
plot(prob_jail_3456$pos,prob_jail_3456$se4,type="h",main="The Standard Error (4 Sided)",xlab="Position",ylab="Standard Error",ylim=c(0,1e-04))
plot(prob_jail_3456$pos,prob_jail_3456$se5,type="h",main="The Standard Error (5 Sided)",xlab="Position",ylab="Standard Error",ylim=c(0,1e-04))
plot(prob_jail_3456$pos,prob_jail_3456$se6,type="h",main="The Standard Error (6 Sided)",xlab="Position",ylab="Standard Error",ylim=c(0,1e-04))

#

# the se when n=50
prob_jail_10=numeric(50)
for (i in 1:1000){
  ddf_10=estimate_monopoly(simulate_monopoly(10,6))
  prob_jail_10[i]=ddf_10$Freq[ddf_10$pos==10]
}

se_jail_10=se(prob_jail_10)

# the se when n=100
prob_jail_100=numeric(100)
for (i in 1:1000){
  ddf_100=estimate_monopoly(simulate_monopoly(100,6))
  prob_jail_100[i]=ddf_100$Freq[ddf_100$pos==10]
}

se_jail_100=se(prob_jail_100)

#the se when n=1000
prob_jail_1000=numeric(1000)
for (i in 1:1000){
  ddf_1000=estimate_monopoly(simulate_monopoly(1000,6))
  prob_jail_1000[i]=ddf_1000$Freq[ddf_1000$pos==10]
}

se_jail_1000=se(prob_jail_1000)

# display the trend graphically
my_se_n=c(se_jail_10,se_jail_100,se_jail_1000,se_jail)
names(my_se_n)=c("50","100","1000","10000")
barplot(my_se_n,main="The Standard Errors For the Long-term Probability Estimates as n Increases",xlab="n",ylab="Standard Error",ylim=c(0,0.002))

















