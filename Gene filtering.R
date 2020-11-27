#Filtering of genes whose average expressions (per groups) are under threshold in all groups

#the range of column numbers of group A (ex. column 1-3 -> a = 1, b = 3)
a <- 1
b <- 3
#the range of column numbers of group B
c <- 4
d <- 6
#the range of column numbers of group C
e <- 7
f <- 9

threshold <- 5 #threshold
in_f <- "test.txt" #input file name
out_f <- "result.txt" #output file name

data <- read.table(in_f, header = TRUE, sep = "\t", row.names = 1)
data1 <- data[a:b] #extracting group A
Aave <- apply(data1,1,mean) # calculating average expression of group A
data2 <- data[c:d] #extracting group B
Bave <- apply(data2,1,mean) # calculating average expression of group B
data3 <- data[e:f] #extracting group C
Cave <- apply(data3,1,mean) # calculating average expression of group C
judge <- pmax(Aave, Bave, Cave) # determination of which is the maximum value among the means of each group
extract <- as.logical(judge >= threshold) # extracting genes whose expressions meat the condition
data <- data[extract,]
data <- cbind(row.names(data), data)
write.table(data, out_f, sep="\t", append=F, quote=F, row.names = F)