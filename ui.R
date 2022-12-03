ui=fluidPage(
  selectInput(inputId = "boro", label = "Borough",choices = data),
  selectInput(inputId ="cuis", label ="country", choices = "", selected = ""),
  
  mainPanel(
    tableOutput(outputId = "table")
  )
  
)
