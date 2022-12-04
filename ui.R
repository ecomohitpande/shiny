
ui<- fluidPage(
  tags$img(src = "mogli.gif",height = 100, width =300,
           style ="background-size:cover; background-position:right; position:absolute;right:.2em"),
  #setBackgroundImage(src = 'jun1.jfif'),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "curd.css")),
  useShinydashboard(),

  titlePanel(h1(" Mogli |:::| Find |:::| Species  ",
                align= "center" ,style={'font-size:30px; color:RdBu;text-shadow: 3px 3px 3px #aaa'})),

  tabsetPanel(
    tabPanel("Inflow of Mongo Query",icon = icon("users"),
  sidebarLayout(
    sidebarPanel(
      width = 2,
      tags$header(
        class = "col-sm-12 title-panel",
        tags$a(href = "",
               em(h4("Mogli Search Levers"),align= "center" ,style={'font-size:50px; color:RdBu;text-shadow: 4px 4px 4px #aaa'})
               
        )),
      
      selectInput(inputId = "boro", label = "Country",choices = data),
        selectInput(inputId ="cuis", label ="Species", choices = "", selected = ""),
         selectInput(inputId ="sci", label ="Scientific Name", choices = "", selected = ""),
      
      actionButton("sango", "Go!",icon=icon("area-chart"),
                   class = "btn action-button",
                   style = "color: white;
                           background-color: deeppink"),
    ),
    mainPanel(
      tabsetPanel(
        tabPanel('mogli search' ,icon = icon("refresh"),
                 
                 fluidRow(splitLayout(cellWidths = c("80%",'44%'),
                                      
                                      box(addSpinner(leafletOutput("lefplot"),spin = "fading-circle", color = "green"), title = "Various Species on Map", footer = "Source Observation.org", collapsible = TRUE, status = "success", solidHeader = TRUE, width = 80),
                                      box(addSpinner(plotlyOutput("graph"),spin = "fading-circle", color = "green"), title = "Individual Species Count", footer = "Source Observation.org", collapsible = TRUE, status = "success", solidHeader = TRUE, width = 60))),
        ),
        tabPanel("User Guide",icon = icon("check"), 
                 # main panel ----        
                 mainPanel(
                   tabsetPanel(
                     tabPanel(tags$iframe(style="height:500px; width:350%; scrolling=yes", 
                                          src="mogli.p")),
                   ),),),
        tabsetPanel(
          tabPanel('mogli in detail' ,icon = icon("table"),
                   
                   fluidRow(splitLayout(cellWidths = c("124%"),
                                        column(12,
                                               box(withSpinner(DT::dataTableOutput("ltable")),  title = "Species in Detail", footer = "Download Data, Enjoy Mogli Music", 
                                                   collapsible = TRUE, status = "success", solidHeader = TRUE, width = 100))))),
          tags$audio(src = "",type = "audio/mp3",autoplay = TRUE,controls = NA), 
        )
      ),
    )
  )),
  tabPanel("Outflow Mongo Query",icon = icon("users"),
              sidebarLayout(
             sidebarPanel(width = 2,
                          textInput("user", "User ID" , "Enter Your User ID"),
                          textInput("pass", "Password" , "Enter Your Password"),
                          selectInput ("Extensions", "Select Database", choices = c('Production', 'Testing')),
                          selectInput (inputId = "id", label= "Recalling Details", choices = inflowdata)),
           mainPanel(
             tabsetPanel(
               tabPanel('Demo for update Table' ,icon = icon("table"),
             fluidRow(
               sidebarPanel(width = 10,
                            tags$header(
                              class = "col-sm-12 title-panel",tags$a(href = "",em(h4("One can Update Table"),align= "center" ,style={'font-size:40px; color:deeppink; 3px 3px 3px #aaa'}))),
                            fluidRow(column(4,
                                            textInput("Name", "Name", ""),
                                            selectInput ("gender", "Dender Details", choices = c('Male', 'Female','Diverse')),
                                            sliderInput("Age", "Your Age", 10, 45, 25, ticks = FALSE),),
                                     
                                     column(7, offset = 1,
                                            sliderInput("R Shiny Experience", "Number of years using R", 0, 5, 1, ticks = FALSE),
                                            textInput("Email", "Email Mail Address"),
                                            textInput("country", "Country"),
                                            textInput("city", "city"))),
                            actionButton("submit", "Submit")),),
             
             fluidRow(
               column(7,splitLayout(cellWidths = c("105%",'175%'),  
                                    box(DT::dataTableOutput("responses", width = 400),
                                        title = "Live Responses", collapsible = TRUE, status = "primary", 
                                        solidHeader = TRUE, width = 500),
                                    column(7,
                                           box(DT::dataTableOutput("table", width = 500),
                                               title = "Calling Records", collapsible = TRUE, status = "success", 
                                               solidHeader = TRUE, width = 50))
               )))
           ),
           tabPanel('Contact Details' ,icon = icon("table"),
                    fluidRow(
                      sidebarPanel(width = 10,
                                   tags$header(
                                     class = "col-sm-12 title-panel",tags$a(href = "",em(h4("For contact Kindly Submit your Details"),
                                      align= "center" ,style={'font-size:40px; color:deeppink; 3px 3px 3px #aaa'}))),
                                   fluidRow(column(4,
                                                   textInput("Name_test", "Name", ""),
                                                   selectInput ("gender_test", "Dender Details", choices = c('Male', 'Female','Diverse')),
                                                   sliderInput("Age_test", "Your Age", 10, 45, 25, ticks = FALSE),),
                                            
                                            column(7, offset = 1,
                                                   sliderInput("R Shiny Experience_test", "Number of years using R", 0, 5, 1, ticks = FALSE),
                                                   textInput("Email_test", "Email Mail Address"),
                                                   textInput("country_test", "Country"),
                                                   textInput("city_test", "city"))),
                                   actionButton("sub", "Submits")),),
                    
                    fluidRow(
                      column(7,splitLayout(cellWidths = c("105%",'175%'),
                                           box(DT::dataTableOutput("personal", width = 400),
                                               title = "click on submit & Your details will be recorded", collapsible = TRUE, status = "primary",
                                               solidHeader = TRUE, width = 500),
                      )))
          
           ),
           )),),     
           )
))