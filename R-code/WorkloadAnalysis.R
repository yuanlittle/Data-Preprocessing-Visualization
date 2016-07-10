#author: Jingsong Yuan

library(xlsx)
mydata <- read.xlsx("C:\\Users\\Jingsong\\Desktop\\new1.xlsx", 1)
#mydata[,6:11]<-data.frame(lapply(mydata[,6:11],as.character),stringsAsFactors = FALSE)
mydata$Processed.Start.Time<-format(as.POSIXct(mydata$Processed.Start.Time,format='%H:%M:%S'),format='%H:%M:%S')
mydata$Processed.Complete.Time<-format(as.POSIXct(mydata$Processed.Complete.Time,format='%H:%M:%S'),format='%H:%M:%S')

attach(mydata)

#change time format to second unit
Start.timeInSecond <- as.character(mydata$Processed.Start.Time)
mydata[, "Start.timeInSecond"] <- sapply(strsplit(Start.timeInSecond,":"),
       function(x) {
         x <- as.numeric(x)
         x[1]*3600+x[2]*60+x[3]
       }
)

End.timeInSecond <- as.character(mydata$Processed.Complete.Time)
mydata[, "End.timeInSecond"] <- sapply(strsplit(End.timeInSecond,":"),
                                         function(x) {
                                           x <- as.numeric(x)
                                           x[1]*3600+x[2]*60+x[3]
                                         }
)

#assign time unit
mydata[, "Start.TimeUnit"] <-as.integer(mydata$Start.timeInSecond/30)
mydata[, "End.TimeUnit"] <-as.integer(mydata$End.timeInSecond/30)

#mydata[, "Num"] <-as.integer(mydata$End.TimeUnit-mydata$Start.TimeUnit+1)

 newM=data.frame(CaseID=character(),Activity=character(),TimeUnit=double(),Level=character(),stringsAsFactors=FALSE)
# newMrow=sum(mydata$Num)+dim(mydata)[1]

#add rows
step=1
for (i in 1:dim(mydata)[1]){
  for (j in mydata$Start.TimeUnit[i]:mydata$End.TimeUnit[i]){
    newM[step,1]=mydata[i,1]
    newM[step,2]=as.character(mydata[i,2])
    newM[step,3]=j
    newM[step,4]=as.character(mydata$Level.1[i])
    step=step+1
  }
}

library(ggplot2)
p<-ggplot(newM, aes(reorder(newM$CaseID,newM$TimeUnit), newM$TimeUnit)) + geom_violin()
p+labs(title="Violin Plot for activity amount")+xlab("Case ID")+ylab("Time Unit(Each 30s as one unit)")

dev.copy(png,width =5500, height = 2000,res=250,units="px",'myplot1.png')
dev.off()


#############People###############
library(xlsx)
PeopleList <- read.xlsx("C:\\Users\\Jingsong\\Desktop\\3.xlsx", 1)
PeopleList[] <- lapply(PeopleList, as.character)

newM1=data.frame(CaseID=character(),Activity=character(),People=character(),TimeUnit=double(),stringsAsFactors=FALSE)

#add rows
step=1

for (i in 1:dim(mydata)[1]){
  for (c in 8:20){  
    if (mydata[i,c]%in% PeopleList[,]){
      for (j in mydata$Start.TimeUnit[i]:mydata$End.TimeUnit[i]){
        newM1[step,1]=mydata[i,1]
        newM1[step,2]=as.character(mydata[i,2])
        newM1[step,3]=as.character(mydata[i,c])
        newM1[step,4]=j
        step=step+1
      }
    }
  }
}
library(ggplot2)
p1<-ggplot(newM1, aes(reorder(newM1$CaseID,newM1$TimeUnit), newM1$TimeUnit)) + geom_violin()
p1+labs(title="Violin Plot for people amount")+xlab("Case ID")+ylab("Time Unit(Each 30s as one unit)")
dev.copy(png,width =5500, height = 2000,res=250,units="px",'myplot2.png')
dev.off()

library(ggplot2)
p2<-ggplot(newM1, aes(reorder(newM1$People,newM1$TimeUnit), newM1$TimeUnit)) + geom_violin()
p2+labs(title="Violin Plot for people amount")+xlab("People")+ylab("Time Unit(Each 30s as one unit)")
dev.copy(png,width =6000, height = 2000,res=250,units="px",'myplot3.png')
dev.off()

##############Dotplot#########################
p<-ggplot(newM1, aes(x = newM1$People, y = newM1$TimeUnit)) +
  geom_dotplot(binaxis = "y",binwidth=1/7, stackdir = "centerwhole")
p+labs(title="DotPlot for people amount")+xlab("People")+ylab("Time Unit(Each 30s as one unit)")+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
                                                                                                          panel.background = element_blank(), axis.line = element_line(colour = "black"))
dev.copy(png,width =7000, height = 2000,res=250,units="px",'myplot4.png')
dev.off()

p<-ggplot(newM1, aes(x = newM1$CaseID, y = newM1$TimeUnit)) +
  geom_dotplot(binaxis = "y",binwidth=1/2, stackdir = "centerwhole")
p+labs(title="DotPlot for people amount")+xlab("Case ID")+ylab("Time Unit(Each 30s as one unit)")
dev.copy(png,width =7000, height = 2000,res=250,units="px",'myplot5.png')
dev.off()

p<-ggplot(newM, aes(x = newM$CaseID, y = newM$TimeUnit,fill=newM$Level)) +
  geom_dotplot(binaxis = "y",binwidth=1, stackdir = "centerwhole")
p+labs(title="DotPlot for activity amount")+xlab("Case ID")+ylab("Time Unit(Each 30s as one unit)")+scale_fill_brewer(palette="Set1")
dev.copy(png,width =12000, height = 2000,res=300,units="px",'myplot6.png')
dev.off()

##############Eliminate Other#############
newM5=data.frame(CaseID=character(),Activity=character(),TimeUnit=double(),Level=character(),stringsAsFactors=FALSE)
j=1
for (i in 1:dim(newM)[1]){
  if (newM$Level[i]!="Other"){
    newM5[j,]<-newM[i,]
    j=j+1
  }
}
p<-ggplot(newM5, aes(x = newM5$CaseID, y = newM5$TimeUnit,fill=newM5$Level)) +
  geom_dotplot(binaxis = "y",binwidth=1, stackdir = "centerwhole")
p+labs(title="DotPlot for activity amount")+xlab("Case ID")+ylab("Time Unit(Each 30s as one unit)")+scale_fill_brewer(palette="Set1")
dev.copy(png,width =12000, height = 2000,res=300,units="px",'myplot10.png')
dev.off()




###############All activity in all case########
newM$Mark<-1
ggplot(newM, aes(x = newM$Mark, y = newM$TimeUnit,fill=newM$Level)) +
  geom_dotplot(stackratio=0.7,dotsize=1,binaxis = "y", stackgroups = TRUE, binwidth = 1, stackdir = "centerwhole")+labs(title="DotPlot for activity amount")+xlab("Total")+ylab("Time Unit(Each 30s as one unit)")+guides(fill = guide_legend(title = "Level1"))+ coord_fixed(ratio = 1/290)+scale_fill_brewer(palette="Set1")



dev.copy(png,width =8000, height = 2000,res=250,units="px",'myplotAllcase.png')
dev.off()


######All people in all case############
newM1$Mark<-1
cbbPalette <- c("#023FA5","#7D87B9","#BEC1D4","#D6BCC0","#BB7784","#FFFFFF", "#4A6FE3","#8595E1","#B5BBE3","#E6AFB9","#E07B91","#D33F6A","#11C638","#8DD593","#C6DEC7","#EAD3C6","#F0B98D","#EF9708","#0FCFC0","#9CDED6","#D5EAE7")
P3<-ggplot(newM1, aes(x = newM1$Mark, y = newM1$TimeUnit,fill=newM1$People),col= primary.colors(21)) +
  geom_dotplot(binaxis = "y", stackgroups = TRUE, binwidth = 1, stackdir = "centerwhole")+labs(title="DotPlot for people amount")+xlab("Total")+ylab("Time Unit(Each 30s as one unit)")+guides(fill = guide_legend(title = "People"))+scale_fill_manual(values=cbbPalette)

dev.copy(png,width =4000, height = 2000,res=250,units="px",'myplot7.png')
dev.off()

##########Devide JR resident and others############

for (i in 1:dim(newM1)[1]){
  if (newM1$People[i]=="Jr Resident") newM1$Mark1[i]<-newM1$People[i]
  else newM1$Mark1[i]<-"Others"
}

p<-ggplot(newM1, aes(x = newM1$Mark, y = newM1$TimeUnit,fill=newM1$Mark1)) +
  geom_dotplot(binaxis = "y", stackgroups = TRUE, binwidth = 1/2, stackdir = "centerwhole")
p+labs(title="DotPlot for people amount")+xlab("Total")+ylab("Time Unit(Each 30s as one unit)")+guides(fill = guide_legend(title = "People"))+ 
  scale_fill_manual(values=c("#000000", "#FFFF66"))
dev.copy(png,width =4000, height = 2000,res=250,units="px",'myplot8.png')
dev.off()



##########Histogram############
library(xlsx)
mydata1 <- read.xlsx("C:\\Users\\Jingsong\\Desktop\\NRE.xlsx", 1)
mydata1$Processed.Time<-format(as.POSIXct(mydata1$Processed.Time,format='%H:%M:%S'),format='%H:%M:%S')
#change time format to second unit
timeInSecond <- as.character(mydata1$Processed.Time)
mydata1[, "Processed.TimeinSecond"] <- sapply(strsplit(timeInSecond,":"),
                                         function(x) {
                                           x <- as.numeric(x)
                                           x[1]*3600+x[2]*60+x[3]
                                         }
)
mydata1[, "TimeUnit"] <-as.integer(mydata1$Processed.TimeinSecond/30)
p4<-ggplot(mydata1, aes(x=TimeUnit)) + geom_histogram(binwidth=1/2)+labs(title="Distribution of NRE")+ylab("Total")+xlab("Time Unit(Each 30s as one unit)")+scale_x_continuous(limits = c(0, 87.5))+ coord_flip() + theme(aspect.ratio = 3)

require(grid)

library(ggplot2)
multiplot(p3, p4,cols=2)



dev.copy(png,width =8000, height = 2000,res=250,units="px",'myplotNRE.png')
dev.off()







###########Multiplot function############
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

install.packages("gridExtra")
install.packages("cowplot")
install.packages("ggExtra")
library("cowplot")
library("gridExtra")
library("ggExtra")
# Move to a new page
grid.newpage()

# Create layout : nrow = 2, ncol = 2
pushViewport(viewport(layout = grid.layout(1, 5)))

# A helper function to define a region on the layout
define_region <- function(row, col){
  viewport(layout.pos.row = row, layout.pos.col = col)
} 

# Arrange the plots
print(p3, vp=define_region(1, 1:4))
print(p4, vp = define_region(1, 5))

dev.copy(png,width =9000, height = 2000,res=250,units="px",'myplotNRE.png')
dev.off()

library(xlsx)
mydata2 <- read.xlsx("C:\\Users\\Jingsong\\Desktop\\Major.xlsx", 1)
mydata2$Processed.Time<-format(as.POSIXct(mydata2$Processed.Time,format='%H:%M:%S'),format='%H:%M:%S')
#change time format to second unit
timeInSecond <- as.character(mydata2$Processed.Time)
mydata2[, "Processed.TimeinSecond"] <- sapply(strsplit(timeInSecond,":"),
                                              function(x) {
                                                x <- as.numeric(x)
                                                x[1]*3600+x[2]*60+x[3]
                                              }
)
mydata2[, "TimeUnit"] <-as.integer(mydata2$Processed.TimeinSecond/30)
p5<-ggplot(mydata2, aes(x=TimeUnit)) + geom_histogram(binwidth=1/2)+labs(title="Distribution of Major and Minor Error")+ylab("Total")+xlab("Time Unit(Each 30s as one unit)")+scale_x_continuous(limits = c(0, 87.5))+ coord_flip() + theme(aspect.ratio = 3)
library("cowplot")
library("gridExtra")
library("ggExtra")
# Move to a new page
grid.newpage()

# Create layout : nrow = 2, ncol = 2
pushViewport(viewport(layout = grid.layout(1, 5)))

# A helper function to define a region on the layout
define_region <- function(row, col){
  viewport(layout.pos.row = row, layout.pos.col = col)
} 

# Arrange the plots
print(p3, vp=define_region(1, 1:4))
print(p5, vp = define_region(1, 5))

dev.copy(png,width =9000, height = 2000,res=250,units="px",'myplotNREMajor.png')
dev.off()


library(xlsx)
write.xlsx(mydata1, "NREdata.xlsx")
write.xlsx(newM, "Workloaddata-Activity.xlsx")
write.xlsx(newM1, "Workloaddata-People.xlsx")

###########Without duration##########
newM3=data.frame(CaseID=character(),Activity=character(),TimeUnit=double(),Level=character(),stringsAsFactors=FALSE)
# newMrow=sum(mydata$Num)+dim(mydata)[1]

#add rows
step=1
for (i in 1:dim(mydata)[1]){
    newM3[step,1]=mydata[i,1]
    newM3[step,2]=as.character(mydata[i,2])
    newM3[step,3]=mydata$Start.TimeUnit[i]
    newM3[step,4]=as.character(mydata$Level.1[i])
    step=step+1
}
###############All activity in all case########
newM3$Mark<-1
ggplot(newM3, aes(x = newM3$Mark, y = newM3$TimeUnit,fill=newM3$Level)) +
  geom_dotplot(stackratio=0.7,dotsize=1,binaxis = "y", stackgroups = TRUE, binwidth = 1, stackdir = "centerwhole")+labs(title="DotPlot for activity amount")+xlab("Total")+ylab("Time Unit(Each 30s as one unit)")+guides(fill = guide_legend(title = "Level1"))+ coord_fixed(ratio = 1/290)+scale_fill_brewer(palette="Set1")
dev.copy(png,width =8000, height = 2000,res=250,units="px",'myplotAllcase_WithoutD.png')
dev.off()

p<-ggplot(newM3, aes(x = newM3$Level, y = newM3$TimeUnit)) +
  geom_dotplot(position="dodge",binaxis = "y",binwidth=1/3, stackdir = "centerwhole")
p+labs(title="DotPlot for activity amount")+xlab("Level")+ylab("Time Unit(Each 30s as one unit)")+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
                                                                                                        panel.background = element_blank(), axis.line = element_line(colour = "black"))
dev.copy(png,width =8000, height = 2000,res=250,units="px",'myplotLevel.png')
dev.off()

########With Duration########

p<-ggplot(newM, aes(x = newM$Level, y = newM$TimeUnit)) +
  geom_dotplot(binaxis = "y",binwidth=1/3, stackdir = "centerwhole")
p+labs(title="DotPlot for activity amount")+xlab("Level")+ylab("Time Unit(Each 30s as one unit)")+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
                                                                                                         panel.background = element_blank(), axis.line = element_line(colour = "black"))
dev.copy(png,width =8000, height = 2000,res=250,units="px",'myplotLevelWithD.png')
dev.off()

###########Without duration Without Others########
newM4=data.frame(CaseID=character(),Activity=character(),TimeUnit=double(),Level=character(),Mark=double(),stringsAsFactors=FALSE)
j=1
for (i in 1:dim(newM3)[1]){
  if (newM3$Level[i]!="Other"){
    newM4[j,]<-newM3[i,]
    j=j+1
  }
}
p<-ggplot(newM4, aes(x = newM4$CaseID, y = newM4$TimeUnit,fill=newM4$Level)) +
  geom_dotplot(position="dodge",binaxis = "y",binwidth=1, stackdir = "centerwhole")
p+labs(title="DotPlot for activity amount")+xlab("Case ID")+ylab("Time Unit(Each 30s as one unit)")+scale_fill_brewer(palette="Set1")
dev.copy(png,width =17000, height = 4000,res=300,units="px",'myplot9.png')
dev.off()

#########Alignment###########
Alignment <- read.csv(file="Alignment.csv",head=TRUE,sep=",")
newM6=data.frame(CaseID=character(),Activity=character(),TimeUnit=double(),stringsAsFactors=FALSE)
s=1
k=1
for (i in 1:dim(Alignment)[1]){
  for (j in 1:dim(Alignment)[2]){
    if (Alignment[i,j]!="--"){
      newM6[s,1]<-"1"
      newM6[s,2]<-as.character(Alignment[i,j])
      newM6[s,3]<-k
      k=k+1
      s=s+1
    }
  }
  k=1
}

ggplot(newM6, aes(x = newM6$CaseID, y = newM6$TimeUnit,fill=newM6$Activity)) +
  geom_dotplot(stackratio=0.7,dotsize=1,binaxis = "y", stackgroups = TRUE, binwidth = 1, stackdir = "centerwhole")+labs(title="DotPlot for activity amount")+xlab("Total")+ylab("Time Unit(Each 30s as one unit)")+guides(fill = guide_legend(title = "Level1"))+ coord_fixed(ratio = 1/290)+scale_fill_brewer(palette="Set1")



dev.copy(png,width =8000, height = 6000,res=400,units="px",'myplotAllcase1.png')
dev.off()
#################Updated Version################
newM7=data.frame(CaseID=character(),Activity=character(),TimeUnit=double(),stringsAsFactors=FALSE)
s=1
for (i in 1:dim(Alignment)[1]){
  for (j in 1:dim(Alignment)[2]){
    if (Alignment[i,j]!="--"){
      newM7[s,1]<-"1"
      newM7[s,2]<-as.character(Alignment[i,j])
      newM7[s,3]<-j
      s=s+1
    }
  }
  k=1
}

ggplot(newM7, aes(x = newM7$CaseID, y = newM7$TimeUnit,fill=newM7$Activity)) +
  geom_dotplot(stackratio=0.7,dotsize=1,binaxis = "y", stackgroups = TRUE, binwidth = 1, stackdir = "centerwhole")+labs(title="DotPlot for activity amount")+xlab("Total")+ylab("Sequential Order")+guides(fill = guide_legend(title = "Level1"))+ coord_fixed(ratio = 1/290)+scale_fill_brewer(breaks=c("A0", "B0", "C0","D0","E0","O0","S0"),labels=c("Airway", "Breathing", "Circulation","Disability","Exposure/Environment","Secondary Survey","Pt Arrival/Pt departure"),palette="Set1")


dev.copy(png,width =9000, height = 12000,res=500,units="px",'myplotAllcase2.png')
dev.off()

######delete unique#######
newM8=data.frame(CaseID=character(),Activity=character(),TimeUnit=double(),stringsAsFactors=FALSE)
s=1
vector <- newM7$TimeUnit
threshold <- 20
Ulist<-Filter(function (elem) length(which(vector == elem)) <= threshold, vector)
for (i in 1:dim(newM7)[1]){
  if (as.character(newM7$TimeUnit[i]) %in% as.character(Ulist)){
  }
  else{
    newM8[s,]=newM7[i,]
    s=s+1
  }
}

newM9<-newM8[order(newM8$TimeUnit),]
s=1
for (i in 1:dim(newM9)[1]){
    newM9[i,3]=s
    if (!newM9[(i+1),3]==newM9[i,3]){
      s=s+1
    }

}

ggplot(newM8, aes(x = newM8$CaseID, y = newM8$TimeUnit,fill=newM8$Activity)) +
  geom_dotplot(stackratio=0.7,dotsize=1,binaxis = "y", stackgroups = TRUE, binwidth = 1, stackdir = "centerwhole")+labs(title="DotPlot for activity amount")+xlab("Total")+ylab("Sequential Order")+guides(fill = guide_legend(title = "Level1"))+ coord_fixed(ratio = 1/290)+scale_fill_brewer(breaks=c("A0", "B0", "C0","D0","E0","O0","S0"),labels=c("Airway", "Breathing", "Circulation","Disability","Exposure/Environment","Secondary Survey","Pt Arrival/Pt departure"),palette="Set1")


dev.copy(png,width =9000, height = 12000,res=500,units="px",'myplotAllcase3.png')
dev.off()

#######################output data
library(xlsx)
write.xlsx(newM3, "mydata.xlsx")


ggplot(newM, aes(x=newM$CaseID, y=newM$TimeUnit, fill=newM$Activity)) +
  geom_dotplot(binpositions="all",stackratio=0.7,dotsize=1,binaxis = "y", stackgroups = TRUE, binwidth = 1, stackdir = "centerwhole")+labs(title="DotPlot for activity amount")+xlab("Total")+ylab("Time Unit(Each 30s as one unit)")+guides(fill = guide_legend(title = "Level1"))

dev.copy(png,width =8000, height = 2000,res=250,units="px",'myplotAllcase.png')
dev.off()
