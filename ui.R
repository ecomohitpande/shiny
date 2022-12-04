ui=fluidPage(
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "cs.css")),
  
  selectInput(inputId = "boro", label = "Borough",choices = data),
  selectInput(inputId ="cuis", label ="country", choices = "", selected = ""),
  
  mainPanel(
    tableOutput(outputId = "table")
  )
  
)