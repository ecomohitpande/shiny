library(shiny)
library(mongolite)
library(tidyverse)
library(data.table)
library(jsonlite)


# df <- data.frame(id = c(1,2,3),
#                   region1 = c("r1", "r1", "r2"),
#                  vars = c("v1", "v2", "r3"))
#mong$insert(df)

## insert into database
connection_string= 'mongodb+srv://test:test@cluster0.ewr6cqk.mongodb.net/?retryWrites=true&w=majority'
mong <-  mongo(collection="st", db="studentdb", url=connection_string)

loadData <- function(qry){
  mong <- mongo(collection="st", db="studentdb", url=connection_string,
                verbose = TRUE)
  
  df <- mong$find(qry)
  return(df)
}



