ui=navbarPage("mongo query",
              sidebarLayout(
                sidebarPanel(
                 selectInput("country1", "Select Cluster Country", unique(mong$aggregate('[{"$group": {"_id":"$country1"}}]'))),
                 # selectInput("country", 'country', choices = "", selected = ""),
                 
                #  selectInput("country", 'country', choices = "", selected = ""),
                ),
                mainPanel(
                  verbatimTextOutput(outputId = "text1"),
                  dataTableOutput(outputId = "qry_results")
                )
              ))
