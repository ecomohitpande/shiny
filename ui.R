ui <- fluidPage(
  
  div(style="display:inline-block; height:10%; vertical-align:center;position:absolute; left: 1310px",
                    sliderInput(inputId = "var4", label = "Variable D", min = 0, max = 100, step = 10, value = 20)),
                
                div(style="display:inline-block; height:10%; vertical-align:center;position:absolute;right:.2em", 
                    sliderInput(inputId = "var5", label = "Variable E", min = 100, max = 500, step = 100, value = 50))
)
