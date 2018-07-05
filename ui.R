#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Define UI for application that shows my location
shinyUI(
  fluidPage(
  # Application title
  titlePanel("Welcome to this simple 'find me' app"),
  # Show map
  mainPanel(
    leafletOutput("showMap"),
    br(),
    p("I live in New York City, specifically in Manhattan, as shown above. Do you want to know where I am now?"),
    actionButton("findButton",'Find me!'),
    p(""),
    htmlOutput("text")
    )
  )
)
