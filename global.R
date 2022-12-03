library(mongolite)
library(shiny)
library(data.table)
library(dplyr)  



##### Define connection parameters and make connections #####


url_path = 'mongodb+srv://test:test@cluster0.ewr6cqk.mongodb.net/?retryWrites=true&w=majority'

# Connect to the trips collection from sample training DB

mongo_connect = mongo(collection = "st", db = "studentdb",url = url_path, verbose = TRUE)


# list out distinct boroughs
data = mongo_connect$distinct("country")

alldata <- mongo_connect$find('{}')




