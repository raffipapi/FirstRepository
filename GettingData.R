# Function to read and export data in different formats
# Author: raffaella.paparcone
###############################################################################


library(RCurl)
library(XML)
library(sqldf)
library(stringr)

#-----------------------OLD Reading function -------------------------#

Get_df <- function(URL, FileType, Source, ENCODING){
	 
  CompleteURL <- paste(URL, FileType, sep="")
   
  if(Source == "Analytics"){
		USERPWD<-"Raffaella.Papercone:Raffaella.Papercone1"	
	}
	else{
		USERPWD <- "raffaella.paparcone:Leila8Maya1!"
	}
  
  
  TMP <- getURL(CompleteURL, userpwd = USERPWD, .encoding = ENCODING)
  
	if (FileType=="CSV"){
		Accounts <- read.csv(textConnection(TMP))
	} else{
		Accounts <- xmlInternalTreeParse(TMP)
		AcctsParsed <- xmlToDataFrame(Accounts)
	}
}

#-----------------------NEW Reading function -------------------------#

NewGet_df <- function(URL, Source, ENCODING){
	
	CompleteURL <- paste(URL, "CSV&sysparm_default_export_fields=all", sep="")
	print(CompleteURL)
	if(Source == "Analytics"){
		USERPWD<-"Raffaella.Papercone:Raffaella.Papercone1"	
	}
	else{
		USERPWD <- "raffaella.paparcone:Leila8Maya1!"
	}
	
	
	TMP <- getURL(CompleteURL, userpwd = USERPWD, .encoding = ENCODING)
	df <- read.csv(textConnection(TMP))
}
#-----------------------------------------------------------------#

#-----------------------Opening a table in Excel ------------------#

OpenInExcel <- function(My_df) {
	#mycsv <- tempfile(fileext='.csv') 
	# creating just a string help creating an Excel file with a NON CRAZY name. 
	mycsv <- "Table.csv"
	write.csv(My_df, mycsv, row.names=FALSE)
	system(paste("open ", mycsv))
}

