setwd("C:\\Users\\MANN6A\\Desktop\\First")
library(data.table)
library(plyr)
#read files 
# files<-paste0("dt",1:4)
# op<-paste0("op",1:4)
# assign(files[4],0)
input1<-fread("Xla.v91.repeatMasked.fa.txt",header= FALSE, nrows=13074546)
input2<-fread("Xla.v91.repeatMasked.fa.txt",header= FALSE, skip =13074546, nrows = 13871036)
input3<-fread("Xla.v91.repeatMasked.fa.txt",header= FALSE, skip =26945582)

output1<-bharath(input3)

write.csv(output1, "frog_output3.csv")

#assign(op[2],bharath (assign(files[2],fread("Xla.v91.repeatMasked.fa.txt",header= FALSE, skip= 15000000, nrows = 1))))
#assign(op[3],bharath (assign(files[3],fread("Xla.v91.repeatMasked.fa.txt",header= FALSE, skip= 20000000, nrows = 10000000))))

bharath= function (dt1)
{
  
  #dt<-fread("Xla.v91.repeatMasked.fa.txt",header= FALSE, nrows = 10000)
  # dt1<-fread("Xla.v91.repeatMasked.fa.txt",header= FALSE, nrows = 100000)
  # dt2<-fread("Xla.v91.repeatMasked.fa.txt",header= FALSE, nrows = 6000000, skip= 6000000)
  # dt3<-fread("Xla.v91.repeatMasked.fa.txt",header= FALSE, nrows = 6000000, skip= 12000000)
  # dt4<-fread("Xla.v91.repeatMasked.fa.txt",header= FALSE, nrows = 6000000, skip= 18000000)
  # dt5<-fread("Xla.v91.repeatMasked.fa.txt",header= FALSE, nrows = 6000000, skip= 24000000)
  # dt6<-fread("Xla.v91.repeatMasked.fa.txt",header= FALSE, skip= 30000000)
  #dt2<-fread("Xla.v91.repeatMasked.fa.txt",header= FALSE, nrows= 10000001:20000000)
  
  #Creating a empty variable to the table
  dt1[,"V2"]<-NA
  
  #Computing the number of characters in each line 
  dt1[,"variable_length"]<-nchar(dt1$V1)
  
  #Isolating the string which has ">" to be the Chr Name
  dt1$V2[substr(dt1$V1,1,1)=='>']<- dt1$V1[substr(dt1$V1,1,1)=='>']
  
  #which(substr(dt1$V1,1,1)=='>')
  
  #We do not need the variable length of the chr names 
  dt1$variable_length[is.na(dt1$V2)==FALSE]=0
  
  names<-dt1[is.na(dt1$V2)==FALSE]
  
  #inheriting na.locf function from zoo
  library(zoo)
  dt1$V2<-na.locf(dt1$V2, fromLast = FALSE)
  
  #Cleaning the chromosome name
  dt1$V2<-substring(dt1$V2, 2)
  
  write.csv(dt1, "frog_temp_op3.csv")
  #Calculating the number of the chromosomes
  freq_tab<-ddply(dt1, .(V2), summarize, 'sum'=sum(variable_length))
  return(freq_tab)
}
remove(input2)
