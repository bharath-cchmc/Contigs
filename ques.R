setwd("C:\\Users\\MANN6A\\Desktop\\First")
library(data.table)
input<- readLines('ann.txt')
input<-unlist(strsplit(input, "\\\t|\\\t| "))
#----------------------------------------
bin<-input[seq(1,length(input), 6)]
name<-input[seq(2,length(input), 6)]
chrom<-input[seq(3,length(input), 6)]
txStart<-input[seq(4,length(input), 6)]
txEnd<-input[seq(5,length(input), 6)]
name2<-input[seq(6,length(input), 6)]
complete<- data.frame(bin[2:45100],name[2:45100],chrom[2:45100],txStart[2:45100],txEnd[2:45100],name2[2:45100], stringsAsFactors = FALSE)
colnames(complete)<-c("bin", "name", "chrom", "txStart", "txEnd", "name2")
complete<-data.table(complete)
setkey(complete, name)
order(complete,bin)
length(unique(complete, by=chrom)$name)
#--------- Input data
genome1<-read.csv('C:\\Users\\MANN6A\\Desktop\\First\\frog_output1.csv', header= T, stringsAsFactors = F)
genome2<-read.csv('C:\\Users\\MANN6A\\Desktop\\First\\frog_output2.csv', header= T, stringsAsFactors = F)
genome3<-read.csv('C:\\Users\\MANN6A\\Desktop\\First\\frog_output3.csv', header= T, stringsAsFactors = F)

genome<- rbind(genome1,genome2, genome3)

cut<-1000

eliminated<-genome[which(genome$sum<cut),]
matchtab<-complete[match(eliminated$V2,complete$chrom),]
matchtab<-matchtab[complete.cases(matchtab),]
print(paste0("We will loose: ", length(matchtab$name) , " genes, if the cut is ", cut))
print(paste0("Total number of base pairs lost: ", sum(eliminated$sum)))

#percentage length lost

Total_length<-sum(as.numeric(genome$sum))
print(paste0("Percentage length lost: ", (sum(eliminated$sum)/Total_length)*100, "%"))
