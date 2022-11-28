ui <- fluidPage(
  useShinydashboard(),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "curd.css")),
  
  titlePanel(h1(" Mogli |:::| Curd |:::| App  ",
                align= "center" ,style={'font-size:30px; color:RdBu;text-shadow: 3px 3px 3px #aaa'})),
  tags$hr(),
  sidebarLayout(
    sidebarPanel(width = 2,
                 textInput("user", "User ID" , "Enter Your User ID"),
                 textInput("pass", "Password" , "Enter Your Password"),
                 selectInput ("Extensions", "Select Database", choices = c('Production', 'Testing')),
                 selectInput (inputId = "id", label= "Respondent Details", choices = inflowdata)),
    
    mainPanel(
      fluidRow(
        sidebarPanel(width = 10,
                     tags$header(
                       class = "col-sm-12 title-panel",tags$a(href = "",em(h4("Dear Respondent Kindly Submit Your Details"),align= "center" ,style={'font-size:40px; color:deeppink; 3px 3px 3px #aaa'}))),
                     
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
  )
)