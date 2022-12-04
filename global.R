##### Load the required libraries #####
library(mongolite)
library(shiny)
library(data.table)
library(dplyr)  

library(leaflet)
library(DT)
library(shinyWidgets)
library(dplyr)
library(plotly)
library(lubridate)
library(shinycssloaders)
library(ggplot2)
library(shinydashboard)
library(webshot)
library(shinyWidgets)

##### Define connection parameters and make connections #####
url_path = 'mongodb+srv://test:test@cluster0.ewr6cqk.mongodb.net/?retryWrites=true&w=majority'

mongo_connect = mongo(collection = "st", db = "studentdb",url = url_path, verbose = TRUE)

data = mongo_connect$distinct("country")

alldata <- mongo_connect$find('{}')
# mongodb+srv://test:<password>@cluster0.ewr6cqk.mongodb.net/test

############################################################################################################# curd app
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
#################################################################################### for inflow to table 

url_path = 'mongodb+srv://test:test@cluster0.ewr6cqk.mongodb.net/?retryWrites=true&w=majority'
mongo = mongo(collection = "onflow", db = "test",url = url_path, verbose = TRUE)

# list out distinct boroughs
inflowdata = mongo$distinct("Name")

inflowalldata <- mongo$find('{}')

############################################ personal data 
databaseName1 <- "test"
collectionName1 <- "personals"

fie <- c("Name_test", "gender_test","Age_test", "R Shiny Experience_test", "Email_test", "country_test", "city_test")

save <- function(data) {
  # Connect to the database
  db1 <- mongo(collection = collectionName1,
              url = sprintf("mongodb+srv://test:test@cluster0.ewr6cqk.mongodb.net/?retryWrites=true&w=majority",databaseName1),
              options = ssl_options(weak_cert_validation = TRUE))
  # Insert the data into the mongo collection as a data.frame
  data <- as.data.frame(t(data))
  db1$insert(data)
}

load <- function() {
  # Connect to the database
  db1 <- mongo(collection = collectionName1,
              url = sprintf("mongodb+srv://test:test@cluster0.ewr6cqk.mongodb.net/?retryWrites=true&w=majority",databaseName1),
              options = ssl_options(weak_cert_validation = TRUE))
  # Read all the entries
  data <- db1$find()
  data
}

