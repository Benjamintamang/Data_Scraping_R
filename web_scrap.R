####Data Scraping from a website
##Web data
##Packages that can be sued to scrap data from the web are RCurl, XML and stringr
install.packages("RCurl")
install.packages("XML")
install.packages("stringr")
install.packages("plyr") ##for sptting data


##Loading the libraries
library(RCurl)
library(XML)
library(stringr)
library(plyr)
library("httr")

###Example
##Reading the URL of a website
url <- "http://www.geos.ed.ac.uk/~weather/jcmb_ws/"

##Gather the html links present in the website
links <-getHTMLLinks(rawToChar(GET(url)$content))
print(links)

##Identify only the links echich point to the JCMB 2015 files
filenames <- links[str_detect(links, "JCMB_2015")]

##Store the file names as a list
filenames_list <- as.list(filenames)

##Create a function to download the files by passing the URL and filenames ans list

downloadcsv <- function(mainurl, filename){
  filedetails <- str_c(mainurl, filename)
  download.file(filedetails, filename)
}

##Now apply the l_ply function and save the files into the current R working directory
l_ply(filenames, downloadcsv, mainurl = "http://www.geos.ed.ac.uk/~weather/jcmb_ws/")
