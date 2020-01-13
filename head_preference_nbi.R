# Eye Opacity Allocation
# B. Völkl
# verändert durch H. Wehner

####################################################################################
setwd("C:/Users/Lenovo/Desktop/Waldrappteam/Eye Opacity/")
head<-as.data.frame(read.csv("headpreference(1).csv",header=FALSE))
head(head)
summary(head)

wilcox.test(as.numeric(head$V1),as.numeric(head$V2), paired = TRUE, alternative =
              "two.sided", exact=FALSE)
