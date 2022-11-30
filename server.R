server <- function(input, output, session) {
  output$product <- renderTable({
    d <- read.csv("d.csv")
    
    d    
    
  })
}
