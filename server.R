server = function(input, output, session) {
  
  ##Whenever a field is filled, aggregate all form data
  
  formData <- reactive({
    data <- sapply(fields, function(x) input[[x]])
    data
  })
  
  # When the Submit button is clicked, save the form data
  observeEvent(input$submit, {
    saveData(formData())
  })
  
  output$responses <- DT::renderDataTable({
    input$submit
    loadData()
  })
  #############################################################################
  
  
  output$table <- DT::renderDataTable({
    
    d= inflowalldata %>% filter(Name== input$id) %>% data.frame()
    
    datatable(d,
              rownames = F,
              extensions = c('Buttons', 'Scroller'),
              options = list(
                headerCallback = JS(
                  "function( thead, data, start, end, display ) {
                           $(thead).closest('thead').find('th').eq(3).css('color', 'black');}"
                ),
                initComplete = JS(
                  "function(settings, json) {",
                  "$(this.api().table().header()).css({'background-color': '', 'color': 'black'});",
                  "}"),
                searching=FALSE,
                dom='lftB',
                pageLength=8,
                deferRender = FALSE,
                buttons = c('copy', 'excel', 'pdf'),
                columnDefs =
                  list(list(className = 'dt-center',
                            targets = "_all")))) 
    
    
  })
  
  
}
