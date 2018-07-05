#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(lubridate)

# Define server logic required to show map with location
shinyServer(function(input, output) {
  
  # Instead of a marker, this function defines an arrow (with circles) to point to my location
  makeArrow <- function(lat0, lng0){
    delta <- 0.00001
    lat <- seq(from = lat0, by = delta, length.out = 40)
    lat <- c(lat, lat[1:20], rep(lat0, 20))
    lng <- seq(from = lng0, by = delta, length.out = 40)
    lng <- c(lng, rep(lng0, 20), lng[1:20])
    data.frame(lat = lat, lng = lng)
  }
  
  output$showMap <- renderLeaflet({
      my_map <- leaflet() %>% addTiles()
      if (input$findButton == 1){
          # Show my location when clicking the 'find me' button
          circles <- makeArrow(40.806290, -73.963005)
          my_map <- circles %>% leaflet() %>% addTiles() %>% 
                    setView(lat = 40.806290, lng=-73.963005, zoom = 18) %>% 
                    addCircles(weight = 1, radius = 5)
          my_map
      } else{
          # Show view of Manhattan before clicking the 'find me' button 
          my_map <- my_map %>% setView(lat = 40.7675, lng=-73.9758, zoom = 12)
          my_map
      }
  })
  
  timediff <- reactive({
        # Calculate the time interval between the creation of the app and user usage
        dateCreated <- mdy_hms("July 2, 2018 10:55:00")
        today <- now("America/New_York")
        timeInterval <- as.period(today - dateCreated)
        paste(round(as.numeric(timeInterval, "days"),2), "days")
  })
  
  output$text <- renderPrint({
    if (input$findButton == 1){
        # When 'find me' button is clicked show time interval between the creation of the app and user usage
        div(style="background-color:lightblue",
        span("This app was created on ", span(style="font-weight:bold","July 2, 2018.")), br(),
        paste("You are watching it after", timediff(), "Thank you!"))
    }
    if (input$findButton > 2){
          # If the 'find me' button is clicked more than intended, print something funny.
          div(style="background-color:lightblue",
          span(style="font-weight:bold","Magic can only happen once!"))
    }
  })
  
})
