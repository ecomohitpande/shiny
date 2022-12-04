
server=function(input, output, session){
  
  
  observeEvent(
    input$boro,
    {q = paste0('{ "country" : "',input$boro , '"}')
    
    updateSelectInput(session, "cuis", "Species",
                      choices = mongo_connect$distinct("species", query = q))
    })
  
  observeEvent(
    input$cuis,
    {q = paste0('{ "species" : "',input$cuis , '"}')
    
    updateSelectInput(session, "sci", "Scientific Name",
                      choices = mongo_connect$distinct("scientific", query = q))
    })

  
  l<- eventReactive(eventExpr = input$sango,     
                    valueExpr = {
                      Sys.sleep(1)
                      
                      {
                        d<-alldata %>% filter(scientific== input$sci)
                        
                        d$longitudeDecimal <- as.numeric(d$longitudeDecimal)
                        d$latitudeDecimal <- as.numeric(d$latitudeDecimal) 
                     
                        leaflet(data = d) %>% addTiles() %>% addCircleMarkers(lng = ~longitudeDecimal,lat = ~latitudeDecimal,
                                                                              popup = ~paste0(
                                                                                "<img src='",link,"' width='50px' height='50px'>")
                        )
                      }
                    }, 
                    ignoreNULL = FALSE)
  
  output$lefplot <-  renderLeaflet(l())
  
  
  ##mogli graph----  
  g<- eventReactive(eventExpr = input$sango,
                    valueExpr = {
                      Sys.sleep(1)

                      {
                        d<-alldata %>% filter(scientific== input$sci) %>% data.frame()
                        plot_ly(d, y = ~d$individualCount, x = ~d$date, type = 'bar', mode = 'lines',
                                marker = list(color = 'rgb(245, 246, 249, 1)',
                                              line = list(color = 'rgb(8,48,107)',
                                                          width = 1.5))) %>%
                          layout(title = '',
                                 yaxis = list(title = 'In Numbers',zeroline = TRUE),
                                 xaxis = list(title = 'Months')) %>%
                          layout(plot_bgcolor = "")
                      }
                    },
                    ignoreNULL = FALSE)

  output$graph<-  renderPlotly(g())
  

t<- eventReactive(eventExpr = input$sango,
                  valueExpr = {
                    Sys.sleep(1)
                    {
                      d<-alldata %>% filter(scientific== input$sci) %>% data.frame()
                      d$individualCount <- as.numeric(d$individualCount)
                      
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
                                  pageLength=2,
                                  deferRender = TRUE,
                                  scrollY = 250,
                                  scroller = TRUE,
                                  buttons = c('copy', 'excel', 'pdf'),
                                  columnDefs =
                                    list(list(className = 'dt-center',
                                              targets = "_all"))))  %>%
                      
                        formatStyle(names(d),
                                    background = styleColorBar(range(d$individualCount), '#CCFFCC'),
                                    backgroundSize = '98% 88%',
                                    backgroundRepeat = 'no-repeat',
                                    backgroundPosition = 'center')
                    }
                  },
                  ignoreNULL = FALSE)

output$ltable <-  DT::renderDataTable(t())
###################################################################################################################################### outflow 
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
############################################################################################## personal

form <- reactive({
  data <- sapply(fie, function(x) input[[x]])
  data
})

# When the Submit button is clicked, save the form data
observeEvent(input$sub, {
  save(form())
})

output$personal <- DT::renderDataTable({
  input$sub
  load=load() %>% data.frame()
  drops <- c("gender_test","Age_test", "R Shiny Experience_test", "Email_test", "country_test", "city_test")
  load[ , !(names(load) %in% drops)]
  
    
})


}