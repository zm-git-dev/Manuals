#!/usr/bin/env R 

#usage: Rscript synteny_plot.R guo_linkage_map.txt linkage_map.pdf
library(ggplot2)

args <- commandArgs(TRUE)

synteny <- function(data_file,out_plot){
	pdf(paste(out_plot,'.pdf',sep=""), width=6,height=3.75)
	par(oma=c(1,1,0,0),mar=c(1.8,1.5,1.8,1.5))
	layout(matrix(1:10,2,5,byrow=TRUE))

	input<-read.table(data_file) #the input file
	a<-tapply(input$V2,input$V1,print)
	b<-tapply(input$V3,input$V1,print)

	chr<-c("A01","A02","A03","A04","A05","A06","A07","A08","A09","A10","C01","C02","C03","C04","C05","C06","C07","C08","C09");

	for(i in 1:length(chr)){
		## if the genetic and physical position are with opposing position then using this judgement 
		#if(chr[i]=="C04" || chr[i]=="C06"){
		#	plot(max(a[[chr[i]]])-a[[chr[i]]],b[[chr[i]]]/1000000,xlab="",ylab="",bty="l",col="blue",cex=0.5)
		#}else{
			plot(a[[chr[i]]],b[[chr[i]]]/1000000,xlab="",ylab="",bty="l",col="blue",cex=0.5)
		#}
		mtext("cM",side=1,line=-1,at=max(a[[chr[i]]]),cex=0.6)
		mtext("Mb",side=2,line=-1,at=max(b[[chr[i]]])/1000000,cex=0.6)
		title(chr[i])
	}
	dev.off()
}

synteny(args[1],args[2])
