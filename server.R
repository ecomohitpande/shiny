server=function(input, output, session){
  
  # observe the selectinput borough & populate the cuisine selectinput
  # update select input logic below
  
  observeEvent(
    input$boro,
    {q = paste0('{ "country" : "',input$boro , '"}')
    updateSelectInput(session, "cuis", "country",
                      choices = mongo_connect$distinct("country", query = q))
    })
  
  
  output$table <- renderTable({
    
    d= alldata %>% filter(country== input$cuis) %>% data.frame()
    d
    
    
  })
  
}
