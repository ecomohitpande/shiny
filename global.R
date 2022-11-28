library(shiny)
library(mongolite)
library(shinythemes)
library(shinydashboard)
library(shinyWidgets)

library(data.table)
library(dplyr)  
library(tidyr)
library(DT)
library(shinycssloaders)
library(ggplot2)


# 
databaseName <- "studentdb"
collectionName <- "onflow"

fields <- c("Name", "gender","Age", "R Shiny Experience", "Email", "country", "city")


saveData <- function(data) {
  # Connect to the database
  db <- mongo(collection = collectionName,
              url = sprintf(
                "mongodb+srv://test:test@cluster0.ewr6cqk.mongodb.net/?retryWrites=true&w=majority",
                # options()$mongodb$username,
                # options()$mongodb$password,
                # options()$mongodb$host,
                databaseName
              ),
              options = ssl_options(weak_cert_validation = TRUE))
  # Insert the data into the mongo collection as a data.frame
  data <- as.data.frame(t(data))
  db$insert(data)
}

loadData <- function() {
  # Connect to the database
  db <- mongo(collection = collectionName,
              url = sprintf(
                "mongodb+srv://test:test@cluster0.ewr6cqk.mongodb.net/?retryWrites=true&w=majority",
                # options()$mongodb$username,
                # options()$mongodb$password,
                # options()$mongodb$host,
                databaseName
              ),
              options = ssl_options(weak_cert_validation = TRUE))
  # Read all the entries
  data <- db$find()
  data
}
#################################################################################### for inflow 

url_path = 'mongodb+srv://test:test@cluster0.ewr6cqk.mongodb.net/?retryWrites=true&w=majority'

# Connect to the trips collection from sample training DB

mongo_connect = mongo(collection = "onflow", db = "test",url = url_path, verbose = TRUE)


# list out distinct boroughs
inflowdata = mongo_connect$distinct("Name")

inflowalldata <- mongo_connect$find('{}')