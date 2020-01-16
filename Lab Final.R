setwd("c:/Users/Ansley/Documents/USF/Fall 17 Regression")
X <-read.csv("X.csv")

install.packages(c("boot", "MASS", "stats", 
                   "apaTables", "car", "DescTools", "ez", 
                   "ggplot2", "gplots", "plotly", "plyr", 
                   "ppcor", "psych", "xtable"))

#Packages:
library(ggplot2)
library(xtable)
library(boot)
library(car)
library(psych)
library(gplots)
library(DescTools)
library(ez)
library(apaTables)
library(MASS)
library(ppcor)
library(stats)
library(plotly)
library(plyr)

#Descriptives:
#describeBy(LAB5$workingcondition,LAB5$GROUP, mat =TRUE)
#describe(example2$Perf)
#main.data2 <- na.omit(data.frame(dat$famdemand,dat$famsat,dat$childhrs,dat$depression))
#complete.data <- main.data[complete.cases(main.data),]
#See Lab 2 Code.R for some useful commands about ordering, etc.
#Factor:
#example2$sex.labeled <- factor(example2$sex, levels = c(0,1), labels = c("Male","Female"))
#dat$Gender<-as.factor(dat$Gender)

#Graphs
#boxplot(example2$Conscale ~ example2$sex.labeled, 
#main="Boxplot of Conscale by Sex",
#ylab="Conscientiousness",
#xlab="Sex")
#hist(example2$Conscale, freq=FALSE, xlim=c(5,18), main="", xlab="")
#lines(density(example2$Conscale))
#plot(example2$Conscale, example2$Perf)
#line<-lm(example2$Perf~example2$Conscale)
#abline(line, col= "red")
#OR
#male.line<-lm(data=subset(example2, sex=="M"), Perf~Conscale)
#female.line<-lm(data=subset(example2,sex=="F"), Perf~Conscale)
#Plot(example2$Conscale, example2$Perf, col=c("Blue","Red")[example2$sex])
#legend("topleft", legend=c("Female", "Male"), fill=c("Blue", "Red"))
#abline(male.line, col= "Red")
#abline(female.line, col= "Blue")
#write.table(x,file="table.txt", quote=FALSE)
#Mean plot with error bars
#plotmeans(LAB5$workingcondition~LAB5$GROUP, 
#xlab="Group", ylab="Working Condition", 
#main="Mean Plot with 95% CI")
#interaction.plot(main.data$age,main.data$gender,main.data$stress,xlab="Age",ylab="Stress",trace.label = "Gender")
#apa.cor.table(main.data, filename="Table1.doc", table.number=1, show.conf.interval=FALSE, landscape = TRUE)
#pairs.panels(data.frame(dat$age,dat$tenure,dat$orgconst))
#cor.plot(main.data, upper = FALSE, numbers = FALSE, show.legend = TRUE)
#scatterHist(main.data$age,main.data$tenure, density = TRUE, ellipse = FALSE, smooth = FALSE, ab = TRUE,
#xlab = "Age", ylab = "Tenure", title = "Scatterplot and Histograms")

#Assumptions:
#T-Test
#Checking normality
#Skew and Kurtosis
#describe(example2$Perf)
#Histogram
#hist(example2$Conscale, freq=FALSE, xlim=c(5,18), main="", xlab="")
#lines(density(example2$Conscale))
#qq plot
##qqnorm(example2$Conscale)
##qqline(example2$Conscale)
#Shapiro-Wilks Test
##p<.05, data= nonnormal population
##shapiro.test(example2$Conscale)
#Boxplot for Outliers
#boxplot(Time~Drug,data = main.data3) 
#Homogeneity of Variance- Remember, don't pool variance, R doesn't automatically (i.e. use Welch, robust to nonnormality, unequal sample size)
#Levene Test (H0: variances equal)
#leveneTest(dat$BMI_2~dat$Gender)
#F test (more sensitive than levene, not recommended by Sean)  
#var.test(example4$performance1~example4$gender)
#ANOVA
#Residuals normally distributed (within cells?)
#aov.results <- aov(workingcondition~GROUP, data=LAB5)
#res <- aov.results$residuals
#qqnorm(res)
#qqline(res)
#Homogeneity of Variance
#leveneTest(LAB5$workingcondition~LAB5$GROUP)
#leveneTest(stress~age*gender, data=main.data)
#Or largest variance no more than 4x smallest (variance = sample SD/sqrt(n))
#Independence of error
#Don't use nested samples?
#Repeated Measures ANOVA
#Same as above
#Homogeneity of covariance
#Regression
#Linear Relationship
#plot(ManagementCompensation~Enrollment, data=main.data, xlab="Enrollment", ylab="Management Compensation",main="f =. 8")
#lines(lowess(main.data$ManagementCompensation~main.data$Enrollment, f=.8))
#Normality of Residuals
#model <- lm(ManagementCompensation~Enrollment, data=main.data)
#model$residuals
#boxplot(model$residuals)
#boxplot(model$residuals)$out
#qqPlot(model, main = "QQ Plot")
#qqnorm(model$residuals)
#qqline(model$residuals)
#Homoscedacity of Residuals
#plot(main.data$Enrollment,model$residuals)
#abline(0,0)
#Outlier:
#stand.res <- rstandard(model) #standardized
#stud.res <- studres(model) #Studentized
#stud.res <- rstudent(model) #Studentized deleted 
#Leverage- Influence of x
#hatvalues(model)
#dfbetas(model) #standardized, x and y
#dfbeta(model) #unstandardized, x and y
#cooks.distance(model)
#diagnostics <- data.frame(studres(model),rstudent(model),cooks.distance(model),hatvalues(model),dfbetas(model))
#colnames(diagnostics) <- c("Studentized Residual","Rstudent","Cook's", "Leverage","DfBETAS Intercept", "DfBETAS Enrollment" )
#diagnostics
##Cutoffs?
#Standardized Res: Look for absolute value >2
#Studentized Res: Look for absolute value >2
#Studentized Deleted Res: Look for a t value with n-k-1 df at alpha .025
#Leverage: Look for value > 2(k+1)/n
#DfBetas: Look for absolute value > 2/sqrt(n)
#Cook's D: Look for value > 4/(n-k-1)
#diagnostics[which(abs(diagnostics$`Studentized Residual`)>2),]
#diagnostics[which(abs(diagnostics$Rstudent)>2.433),]
#diagnostics[which(diagnostics$`Cook's`>.2),]
#diagnostics[which(diagnostics$Leverage>.19),]
#diagnostics[which(abs(diagnostics$`DfBETAS Intercept`)>.44),]
#diagnostics[which(abs(diagnostics$`DfBETAS Enrollment`)>.44),]
#main.data2 <-subset(main.data, !(rownames(main.data)%in% c('Montery Bay','Sonoma')))
#model2 <- lm(ManagementCompensation~Enrollment, data=main.data2)
#summary(model)
#summary(model2)

#T Test
#One-sample
#t.test(x = example4$performance1,mu=0)
#t-test independent samples t-test, variances are homogeneous
#t.test(example4$performance1~example4$gender, var.equal=TRUE)
#t-test independent samples t-test, variances are not homogeneous
#t.test(example4$performance1~example4$gender, var.equal=FALSE)
#Paired (dependent) t-test, no need to specify var.equal because both groups are same sample
#t.test(x = example4$performance1, y = example4$performance2, paired = TRUE)

#ANOVA
#aov.results <- aov(workingcondition~GROUP, data=LAB5) (THIS IS TYPE I SS)
#Anova.results <- Anova(aov.results, type="III")
#Omega Square:
omega_sq <- function(aov_in, neg2zero=T, type="III"){
  aovtab <- aov_in
  n_terms <- length(aovtab[["Sum Sq"]]) - ifelse(type=="III",2,1)
  output <- rep(-1, n_terms)
  SSr <- aovtab[["Sum Sq"]][n_terms + ifelse(type=="III",2,1)]
  MSr <- aovtab[["Sum Sq"]]/aovtab[["Df"]]
  MSr <- MSr[n_terms + ifelse(type=="III",2,1)]
  SSt <- ifelse(type=="III",sum(aovtab[["Sum Sq"]])-aovtab[["Sum Sq"]][1],sum(aovtab[["Sum Sq"]]))
  if(type=="III"){
    for(i in 1:n_terms){
      SSm <- aovtab[["Sum Sq"]][i+1]
      DFm <- aovtab[["Df"]][i+1]
      output[i] <- (SSm-DFm*MSr)/(SSt+MSr)
      if(neg2zero & output[i] < 0){output[i] <- 0}
    }
  }
  else{
    for(i in i:n_terms){
      SSm <- aovtab[["Sum Sq"]][i+1]
      DFm <- aovtab[["Df"]][i+1]
      output[i] <- (SSm-DFm*MSr)/(SSt+MSr)
      if(neg2zero & output[i+1] < 0){output[i] <- 0}  
    }
  }
  names(output) <- rownames(aovtab)[ifelse(type=="III",2,1):ifelse(type=="III",(n_terms+1),n_terms)]
  return(output)
}
#omega_sq(Anova.results, type="III")
#Critical Value of F:
#qf(.95,df1=2,df2=21)
#Post Hoc:
#aov.results <- aov(score~condition, data=Lab6)
#hsd.hoc.results <- PostHocTest(aov.results, method="hsd")
#plot(hsd.hoc.results)
#nk.hoc.results <- PostHocTest(aov.results, method="newmankeuls") #most powerful
#plot(nk.hoc.results)
#bon.hoc.results <- PostHocTest(aov.results, method="bonferroni") #most conservative
#plot(bon.hoc.results)
#Planned Comparison:
#lm.results <- lm(Lab6$score~Lab6$condition)
#Create matrix for planned comparisions, sum of products of weights should be zero.
#c1 <- c(-3, 1, 1, 1)
#c2 <- c(0, 1, -1, 0)
#mat <- cbind(c1, c2)
#contrasts(Lab6$condition) <- mat 
#contrast.results <- summary(lm.results, split=list(condition=list('1 vs 2-4'=1,'2 vs 3'=2)))
#tvalues <- contrast.results$coefficients
#Fvalues <- subset(tvalues, select = 3)^2
#colnames(Fvalues) <- c("F value")
#round(Fvalues, digits=3)
#Non-normal ANOVA
#Kruskal-Wallis
#kruskal.results <- kruskal.test(Lab6$score~Lab6$condition)
#Mann-Whitney between each group
#pairwise.wilcox.test(Lab6$score, Lab6$condition, p.adj = "bonferroni")
#Factorial ANOVA (Interaction)
#options("contrasts")
#options(contrasts = c("contr.helmert", "contr.poly"))
#lm.results <- lm(stress~age*gender,data=main.data)
#summary(lm.results)
#Anova.results <- Anova(lm.results, type="III")
#Partial Omega Square:
partial_omega_sq <- function(aov_in, type="III"){
  if(type=="III"){
    aov_in<-aov_in[-c(1),]
  }
  aovtab <- aov_in
  residRow <- length(aovtab[["Sum Sq"]]) - ifelse(type=="III",1,0)
  dfError <- sum(aovtab[["Df"]])
  msError    <- aovtab[["Sum Sq"]][length(aovtab[["Sum Sq"]])]/aovtab[["Df"]][length(aovtab[["Df"]])]
  nTotal <- sum(aovtab[["Df"]])+1
  dfEffects <- aovtab[["Df"]][1:length(aovtab[["Df"]])-1]
  ssEffects <- aovtab[["Sum Sq"]][1:length(aovtab[["Sum Sq"]])-1]
  msEffects <- ssEffects/dfEffects
  partOmegas <- ((dfEffects*(msEffects-msError)) /
                   (ssEffects + (nTotal -dfEffects)*msError))
  names(partOmegas) <- rownames(aovtab)[1:{residRow-1}]
  if(type=="III"){
    names(partOmegas) <- rownames(aovtab)[1:{residRow}]
  }
  return(partOmegas)
}
#partial_omega_sq(Anova.results, type="III")
#hsd.hoc.results <- PostHocTest(aov.results, method="hsd")
#plot(hsd.hoc.results)
#interaction.plot(main.data$age,main.data$gender,main.data$stress,xlab="Age",ylab="Stress",trace.label = "Gender")
#Random effects, 2 random factors:
#twoway.rand <- aov(Response ~ Administrator * Order + Error(1/Administrator*Order), data=main.data)
#out1 <- summary(twoway.rand)
administrator.df <- as.numeric(out1$`Error: Within`[[1]][1,1])
administrator.MS <- as.numeric(out1$`Error: Within`[[1]][1,3])
order.df <- as.numeric(out1$`Error: Within`[[1]][2,1])
order.MS <- as.numeric(out1$`Error: Within`[[1]][2,3])
interact.df <- as.numeric(out1$`Error: Within`[[1]][3,1])
interact.MS <- as.numeric(out1$`Error: Within`[[1]][3,3])
error.df <- as.numeric(out1$`Error: Within`[[1]][4,1])
error.MS <- as.numeric(out1$`Error: Within`[[1]][4,3])
total.df <- administrator.df + order.df + interact.df + error.df
#  Find F ratios and p values
F.order <- (order.MS)/(interact.MS)
p.F.order <- 1-pf(F.order, order.df, interact.df)
F.administrator <- (administrator.MS/interact.MS)
p.F.administator <- 1-pf(F.administrator, administrator.df, interact.df)
F.interact <- (interact.MS/error.MS)
p.F.interact <- 1-pf(F.interact, interact.df, error.df)
Order.res <- c(order.df, order.MS, F.order, p.F.order)
Administator.res <- c(administrator.df, administrator.MS, F.administrator, p.F.administator)
Interact.res <- c(interact.df, interact.MS, F.interact, p.F.interact)
error.res <- c(error.df,error.MS,NA,NA)
total.res <- c(total.df,NA,NA,NA)
#  Print the results
Random.res <- rbind(Administator.res, Order.res,  Interact.res, error.res, total.res)
`colnames<-`(Random.res,c('df', 'MS', 'F', 'p') )
#boxplot(Response~Administrator*Order,data = main.data)
#pairwise.t.test(main.data$Response, main.data$Order)
#pairwise.t.test(main.data$Response, main.data$Administrator) #if you have interaction, you have to do it on cell (in Excel, code each level as a cell, so 6x3 is 18 cells)
#Mixed Effects (one random, one fixed):
#out1 <- summary(aov( Tension ~ Task*Classroom + Error(1/Classroom), data = main.data2))
Task.df <- as.numeric(out1$`Error: Within`[[1]][1,1])
Task.MS <- as.numeric(out1$`Error: Within`[[1]][1,3])
Classroom.df <- as.numeric(out1$`Error: Within`[[1]][2,1])
Classroom.MS <- as.numeric(out1$`Error: Within`[[1]][2,3])
interact.df <- as.numeric(out1$`Error: Within`[[1]][3,1])
interact.MS <- as.numeric(out1$`Error: Within`[[1]][3,3])
error.df <- as.numeric(out1$`Error: Within`[[1]][4,1])
error.MS <- as.numeric(out1$`Error: Within`[[1]][4,3])
total.df <- Task.df + Classroom.df + interact.df + error.df
#  Find F ratios and p values
F.Classroom <- (Classroom.MS)/(interact.MS)
p.F.Classroom <- 1-pf(F.Classroom, Classroom.df, interact.df)
F.Task <- (Task.MS/interact.MS)
p.F.Task <- 1-pf(F.Task, Task.df, interact.df)
F.interact <- (interact.MS/error.MS)
p.F.interact <- 1-pf(F.interact, interact.df, error.df)
Classroom.res <- c(Classroom.df, Classroom.MS, F.Classroom, p.F.Classroom)
Task.res <- c(Task.df, Task.MS, F.Task, p.F.Task)
Interact.res <- c(interact.df, interact.MS, F.interact, p.F.interact)
error.res <- c(error.df,error.MS,NA,NA)
total.res <- c(total.df,NA,NA,NA)
#  Print the results
Random.res <- rbind(Task.res,Classroom.res, Interact.res, error.res, total.res)
`colnames<-`(Random.res,c('df', 'MS', 'F', 'p') )
#boxplot(Tension~Task*Classroom,data = main.data2)
#pairwise.t.test(main.data2$Tension, main.data2$Task)
#pairwise.t.test(main.data2$Tension, main.data2$Classroom)
#pairwise.t.test(main.data2$Tension, main.data2$Cell)
#Repeated Measures
#repeated_measures <-ezANOVA(data=main.data3,
#dv = Time,    # Dependent variable.
#wid = Person,           # within subject ID
#within = Drug,          # within subject or repeated factor
#detailed = T,           # Produces additional details in output
#between = ,             # There is also an option to define between (fixed) factors as well if present
#type = 3,               # Setting it to type 3 sums of squares
#return_aov = TRUE)
#print(repeated_measures)                       # ges = Generalized Eta-squared Effect Size; see help file for reference
#summary(repeated_measures$aov)
#pairwise.t.test(main.data3$Time, main.data3$Drug, paired = TRUE)
#boxplot(Time~Drug,data = main.data3) 

#Correlation
#pairwise.counts<-count.pairwise(main.data)
#min(pairwise.counts)
#max(pairwise.counts)
#complete.data <- main.data[complete.cases(main.data),]
#correlations <- corr.test(main.data, use ="pairwise", method = "pearson")
#pairs.panels(data.frame(age,tenure,orgconst))
#cor.plot(main.data, upper = FALSE, numbers = FALSE, show.legend = TRUE)
#numbers=true? To include actual correlations. Very cool plot. lol
#scatterHist(main.data$age,main.data$tenure, density = TRUE, ellipse = FALSE, smooth = FALSE, ab = TRUE,
#xlab = "Age", ylab = "Tenure", title = "Scatterplot and Histograms")
#Chronbach's Alpha
#alpha(main.data2)

#Regression:
#unstandardized.lm.results <- lm(performance~jobsat,data=main.data)
#summary(unstandardized.lm.results)
#anova(unstandardized.lm.results)
#standardized.lm.results <- lm(scale(main.data$performance)~scale(main.data$jobsat))
#summary(standardized.lm.results)
#plot(y=unstandardized.lm.results$residuals,x=main.data$jobsat)
#lm.plot <- ggplot(main.data, aes(x=performance, y=jobsat))
#lm.plot <- lm.plot + geom_point()
#lm.plot <- lm.plot + geom_smooth(method=lm, color="black")
#lm.plot <- lm.plot + labs(x="Performance", y="Job Satisfaction")
#lm.plot + theme_bw()
#Partial Correlation:
#pcor.test(x=main.data2$famsat,y=main.data2$famdemand,z=main.data2$depression)
#pcor.test(x=main.data2$famsat,y=main.data2$famdemand,z=main.data2[,c("depression", "childhrs")])
#famdemand.res <- lm(famdemand ~  depression, data=main.data2)
#famdemand.res$residuals
#famdemand.res$fitted.values
#famsat.res <- lm(famsat ~ depression, data=main.data2)
#famsat.res$residuals
#famsat.res$fitted.values
#cor(famdemand.res$residuals,famsat.res$residuals)
#Semipartial Correlation:
#spcor.test(x=main.data2$famsat,y=main.data2$famdemand,z=main.data2$depression)
#blk1 <- lm(famsat ~ famdemand, data=main.data2)
#blk2 <- lm(famsat ~ famdemand + childhrs, data=main.data2)
#anova(blk1,blk2)

#ANCOVA
#b1: difference in intercept #if not sig, same intercept
#b2: slope (of reference) #if not sig, but b1 is, slope is zero and different means
#b3: difference in slope #if not sig, same slope
#look at R2, look at sig.of Gx, then re-estimate if necessary.
#res1 <- lm(GPA ~factor(sex)+MAT+ MAT:factor(sex))
#summary(res1) #is interaction significant
#res2 <- lm(GPA ~factor(sex)+MAT)
#summary(res2)
#OR
#res1 <- lm(foodgram ~ factor(ms)+ BMI+ BMI:factor(ms))
#summary(res1)
#msgrp1 <- subset(main.data, ms==1)
#msgrp1
#msgrp2 <- subset(main.data, ms==2)
#msgrp2
# run regressions for each group to find coefficients relating foodgram to BMI
#res1a <- lm(foodgram ~ BMI, data=msgrp1)
#summary(res1a)
#res1b <- lm(foodgram ~ BMI, data=msgrp2)
#summary(res1b)
#plot(BMI, foodgram, pch=ms, xlab="Body Mass Index", ylab='Food Eaten (grams)')
#abline(res1a, lty=2)
#abline(res1b)
#text(35, .53, 'death prompt')
#text(31, 1.2, 'broken bone prompt')
