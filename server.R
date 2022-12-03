server=function(input, output, session) {
  
  # observeEvent(
  #   input$cluster,
  #   updateSelectInput(session, "country", "Select Country",
  #                     choices = data$country[data$cluster==input$cluster]))
  # 
  # observeEvent(
  #   mong$aggregate('[{"$group": {"_id":"$country1"}}]'),
  #   updateSelectInput(session, "country", "Select Country",
  #                     choices = mong$aggregate('[{"$group": {"_id":"$country"}}]')[mong$aggregate('[{"$group": {"_id":"$country1"}}]')==mong$aggregate('[{"$group": {"_id":"$country1"}}]')]))
  # 
  qryResults <- reactive({
    
    observeEvent(
      mong$aggregate('[{"$group": {"_id":"$country1"}}]'),
      updateSelectInput(session, "country", "Select Country",
                        choices = mong$aggregate('[{"$group": {"_id":"$country"}}]')[mong$aggregate('[{"$group": {"_id":"$country1"}}]')==mong$aggregate('[{"$group": {"_id":"$country1"}}]')]))
    
      
    region <- list(country = input$country1)

    qry <- paste0('{ "country1" : "',region,'"}')
    df <- loadData(qry)
    return(df)
    df= data.frame(df)

  })
  
  output$qry_results <- renderDataTable({
   qryResults()
     
      # p %>% filter(source== "Eurasian Bullfinch")
    
     
  })
  
  output$text1 <- renderText(nrow(qryResults()))
  
}
