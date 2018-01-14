#!/usr/bin/env Rscript

####################################################################################
# M1BI Paris Diderot
# TP analyse statistique de données de transcriptome pour l'UE Outils d'analyse des génomes 2017
# R script for differential expression analysis with microarray data
#  claire.vandiedonck@univ-paris-diderot.fr

####################################################
## Step 1: R session and libraries
####################################################

# start R and set your working directory

# Follow the script stepwise.
# Caution: some steps are currently commented as they might not have to be run. If you have to run them, uncomment the corresponding lines
# Once done, if you want to generate a single pdf file with all the graphs of this practical, uncomment the next line and the last one of the script and run the script again. You may use source("mycsript_name") to do so without copying and pasting each command line.
#pdf("graphics.pdf")

# TIP: to enlarge the display to the width of your terminal, enter a width (e.g 160 good on most labptop screens) in the following command:
options(width=160)

# check which R session and R packages are installed on your R session

sessionInfo()## this commands will return the R and R-packages versions used in your R session
# FOR EXAMPLE:
# R version 3.3.3 (2017-03-06)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 15063)

# locale:
# [1] LC_COLLATE=French_France.1252  LC_CTYPE=French_France.1252    LC_MONETARY=French_France.1252 LC_NUMERIC=C                   LC_TIME=French_France.1252    

# attached base packages:
# [1] stats     graphics  grDevices utils     datasets  methods   base     


# load the required R library for this practical
library (limma) ## The limma package is a Bioconductor R package dedicated to expression microarrays differential analysis. It is now also used for RNASeq data. You may checked it is well loaded by running the command on line 25 again (SessionInfo())
# IF THIS COMMAND ON LINE 39 RETURNS AN ERROR:
# Check which packages are installed on your computer
# first indetify the folders where the packages are installed:
.libPaths()
# then get the names of the packages installed
# if more than one result is returned, you will check which packages are installed in each folder using the following command
list.files(.libPaths()[1]) # to know the packages installed in the first directory
#list.files(.libPaths()[2]) # to know the packages installed in second first directory, etc...
# if you want to know which version is installed:
installed.packages(lib.loc=.libPaths()[1])[,c(1,3)] # to know the packages and the versions installed in the first directory
#installed.packages(lib.loc=.libPaths()[2])[,c(1,3)] # to know the packages and the versions installed in the first directory

# Is limma package in any folder?
## If yes, run again the command line on line 39 of this script. If the error is still returned, call your teacher for some help:)
## If no, is the library BiocInstaller installed in any folder?
### If yes, install BiocInstaller before installing limma with the following command:
### try http:// if https:// URLs are not supported in the next command
# source("https://bioconductor.org/biocLite.R")
# biocLite() # to install the minimum set of bioconductor packages
# You may have to answer some questions: answer yes if you are asked for installing the library in your personnal local directory; say no if it asks for updates as it may take wome time while not being necessary
### If BiocInstaller is installed but limma is not installed, then install limma with the following command:
#biocLite("limma")
# Once done, you should be able to run the command line on row 39 of this script again. If the error is still returned, call your teacher for some help:)


####################################################
## Step 2: Getting your microarrays data
####################################################

# identify your working directory
getwd()
# if your are R beginners, either save manually the file containg the data Microarrays_logValues_parapsilosis.txt in the returned directory, or change your working directory by using the command setwd() and specifying the path inside quotes within the brackets

# data reading if data are in your working directory, otherwise specify their path
dataArrays <- read.table("Microarrays_logValues_parapsilosis.txt", header = T, row.names = 1)

# look at the R objects you generated: gene names are stored as row names
head(dataArrays)
tail(dataArrays)

# rename colnames according to microarray numbers
colnames(dataArrays) <- c("log2(H/N)_rep1", "log2(H/N)_rep2", "log2(H/N)_rep3", "log2(H/N)_rep4")

#check the structure of the new R object
str(dataArrays)


#######################################################################
## Step 3: Differential Expression analysis with microarrays experiments
########################################################################

#####
# Q1. Where microarrays normalised?
#####

# to answer this firts question we will generate two figures of the distribution of the log2(intensity ratios):
#	1. an histogram 
xValues  <- seq(floor(min(dataArrays)), ceiling(max(dataArrays)), by = 0.1) 
par(mfrow = c(2,2))
for(i in 1:ncol(dataArrays)){
		hist(dataArrays[,i], breaks = xValues, 
		xlab = "log2(H/N) value", 
		main = paste("log2(H/N) values\n array #", i))			
}
par(mfrow = c(1,1))

#	2. one boxplot per array
boxplot(dataArrays,outline=F, main="Boxplot of log2FC distributions for each microarray replicate", ylab="log2FC")

# Some descriptive values of the distribution can also be generated automatically:
summary(dataArrays)

# YES, NORMALIZED (distributions normales & centrées réduites)

#####
# Q2. Are data correlated between replicates?
#####

# we generate a matrix of pairwise correlations, display the parirwise correlation plots and add the pvalues of the Pearson statistical tests
panel.cor <- function(x, y, digits=2, prefix2="", cex.cor) {
     usr <- par("usr"); on.exit(par(usr)) 
     par(usr = c(0, 1, 0, 1)) 
     r <- abs(cor(x, y)) 
     txt <- format(c(r, 0.123456789), digits=digits)[1] 
     txt <- paste(prefix2, txt, sep="") 
     if(missing(cex.cor)) cex <- 0.8/strwidth(txt) 
     test <- cor.test(x,y) 
     Signif <- symnum(test$p.value, corr = FALSE, na = FALSE, 
     cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1),
     symbols = c("***", "**", "*", ".", " ")) 
     text(0.5, 0.5, txt, cex = cex * r) 
     text(.8, .8, Signif, cex=cex, col=2) 
      }
pairs(as.matrix(dataArrays), labels=colnames(dataArrays), lower.panel=panel.smooth, upper.panel=panel.cor, main="pairwise correlation of microarray replicates")

# YES, CORRELATED (très significatif ***)

#####
# Q3. Is there a relationship between the mean and the standard deviation of the log(H/N)? Is this a problem?
#####

# compute and plot some descriptive statistic for each gene among the 4 replicates
averageLog <- apply(dataArrays, 1, mean) # mean value for log2(H/N) replicates for each gene
sdValues <- apply(dataArrays, 1, sd)  # sandard deviation for log2(H/N) replicates for each gene

plot(sdValues, averageLog, 
		main = "C. parapsilosis - Microarrays",
		xlab = "Standard deviations", ylab = "Average log2FC",
		pch = 20)
abline(h = 2, col = "red", lty = "dashed")
abline(h = -2, col = "green", lty = "dashed")


#####
# Q4. What is the effect of Bonferroni correction? How many genes are up- or donw-regulated?
#####

## perform Differential Expression analysis with a student t-test
tval <- averageLog/(sdValues/sqrt(ncol(dataArrays))) # tvalues
critical_0.05_t <- qt(1-0.05/2, 4-1)  # calculate t threshold for type 1 error = 5%
length(tval[which(abs(tval) > critical_0.05_t)]) # number of genes with pval < 5%
length(tval[which(tval > critical_0.05_t)])      # number of genes upregulated with pval < 5%
length(tval[which(tval < -critical_0.05_t)])      # number of genes downregulated with pval < 5%

# same with alpha = 1%
critical_0.0001_t <- qt(1-0.0001/2, 4-1)
length(tval[which(abs(tval) > critical_0.0001_t)])
length(tval[which(tval > critical_0.0001_t)])
length(tval[which(tval < -critical_0.0001_t)])

# same  with bonferroni correction
critical_bonf_t <- qt(1-(0.05/(2*length(tval))), 4-1) 
length(tval[which(abs(tval) > critical_bonf_t )])
length(tval[which(tval > critical_bonf_t )])
length(tval[which(tval < -critical_bonf_t )])
upGenes.t <- names(tval[which(tval > critical_bonf_t )])
downGenes.t <- names(tval[which(tval < -critical_bonf_t )])
                       
# plot t values and FC and higlight DE genes
plot(averageLog, tval,
		main = "C. parapsilosis - Microarrays dataset",
		ylab = "tval (Student parameter)", xlab = "LogFC (average value)",
		pch = 20)
abline(h = 0, col = "black")
abline(v = 0, col = "black")
abline(h = critical_bonf_t, col = "red", lty = "dashed")
abline(h = -critical_bonf_t, col = "green", lty = "dashed")
points(averageLog[upGenes.t],tval[upGenes.t], col = "red", pch = 20)	
points(averageLog[downGenes.t],tval[downGenes.t], col = "green", pch = 20)


#####
# Q5. Do the FC values change using limma? How do the moderated t stats of limma behave compared to student t stats and to the initial standard deviation? Is that satisfactory?
#####

####
## perform Differential Expression analysis using limma

fit <- lmFit(dataArrays)   # Linear model estimation
limmaRes <- eBayes(fit)   # Bayesian statistics
limmaTable <- topTable(limmaRes, number = nrow(dataArrays))
limmaRes2 <- limmaTable[row.names(dataArrays),]# sort genes according to their initial order in dataArrays

# compare logFC values obtained with LIMMA
plot(limmaRes2[, "logFC"], averageLog, pch = 20, xlab = "logFC calculated with LIMMA", ylab = "LogFC (average value)")
cor.test(limmaRes2[, "logFC"], averageLog)
abline(0, 1)

# compare t of limma with tval obtained with Student regarding to FC
plot(averageLog, tval,
		main = "C. parapsilosis - Microarrays dataset",
		ylab = "t (Student in black and LIMMA in purple)", xlab = "LogFC (average value)",
		pch = 20)
points(averageLog, limmaRes2[,"t"], pch = 20, col = "purple")
abline(h = 0, col = "black")
abline(v = 0, col = "black")

# compare t of limma with tval obtained with Student regarding to initial standard deviation (we have no access to the limma estimated standard deviation of the group of genes g behaving like the gene of interest)
plot(sdValues, tval,
		main = "C. parapsilosis - Microarrays dataset",
		ylab = "t (Student in black and LIMMA in purple)", xlab = "Initial Standard deviation",
		pch = 20)
points(sdValues, limmaRes2[,"t"], pch = 20, col = "purple")
abline(h = 0, col = "black")


#####
# Q6. With limma and an adjusted type I error of 0.0001, how many genes are DE? up-regluated? down-regulated? Are they the same genes as the ones found using the student tests?
#####

# genes differentially expressed with microarrays
length(which(limmaRes2$adj.P.Val < 0.0001))
dim(limmaRes2[which(limmaRes2$adj.P.Val < 0.0001 & limmaRes2$logFC > 0),])
dim(limmaRes2[which(limmaRes2$adj.P.Val < 0.0001 & limmaRes2$logFC < 0),])
upGenes.limma <- limmaRes2[which(limmaRes2$adj.P.Val < 0.0001 & limmaRes2$logFC > 0),]
downGenes.limma <- limmaRes2[which(limmaRes2$adj.P.Val < 0.0001 & limmaRes2$logFC < 0),]


# volcano plot
plot(-log10(limmaRes2$adj.P.Val) ~ limmaRes2$logFC, pch="", xlim=c(-6,6),ylim=c(0,7), xlab="",ylab="",bty="n",xaxt="n", yaxt="n"  )
title("Hypoxia versus Normoxia", font.main=1, cex.main=0.9)
axis(1, at=-6:6, tcl=-0.5,cex=0.7, labels=F )
mtext(-6:6,side=1,line=1,at=-6:6, cex=0.7)
axis(2, at=0:7, tcl=-0.2,cex=0.7, labels=F )
mtext(0:7,side=2,line=0.5,at=0:7, cex=0.7)
points(-log10(limmaRes2$adj.P.Val) ~ limmaRes2$logFC, pch=16, cex=0.5, col="grey")
points(-log10(upGenes.limma$adj.P.Val) ~ upGenes.limma$logFC,pch=16, cex=0.5, col="red")
points(-log10(downGenes.limma$adj.P.Val) ~ downGenes.limma$logFC,pch=16,cex=0.5, col="green")
mtext("log2(FC)", side = 1, line = 2, cex=0.8)
mtext("-log10 (adjusted p-value)", side=2, line=1.5, cex=0.8)

# compare with student genes
length(intersect(downGenes.t,row.names(upGenes.limma)))
length(setdiff(row.names(downGenes.limma), upGenes.t))
length(setdiff(downGenes.t,row.names(upGenes.limma)))
length(intersect(downGenes.t,row.names(downGenes.limma)))
length(setdiff(row.names(downGenes.limma), downGenes.t))
length(setdiff(downGenes.t,row.names(downGenes.limma)))


# save the output containing the results in your local folder
write.table(dataArrays.analyzed, quote = F, sep = "\t", file = "Microarrays_diffAnalysis.txt", row.name=F)

#dev.off() # to uncomment if you want to run the script at once and generate a unique pdf file with all figures
