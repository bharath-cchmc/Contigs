density<- read.csv("C:/Users/MANN6A/Desktop/First/manual_output.csv", header = TRUE)
density<-density[complete.cases(density),]



#Normal distribution of the base pair count


#Cumulative distributiong of X
P=ecdf(density$sum)

P(0.0)
plot(P, xlab = 'Sample Quantiles of Base-pair total', 
     main = 'Cumluative Distribution\n Number of Base pair', 
     ylab='')
zm()
