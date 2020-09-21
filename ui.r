library("shiny")
library("shinythemes")
library("shinyWidgets")
library("shinydashboard")
library("leaflet")
library("ggplot2")
library("dplyr")
library("ggrepel")
library("plotly")
#if (require(devtools)){install.packages("devtools")}

#devtools::install_github("AnalytixWare/ShinySky")
library(shinysky)



variables <- c("Razon Circulante" = "Razon_Circulante",
               "Promedio 2019" = "Prom2019",
               "Flujo Caja Op" = "FCO",
               "Precio Hoy" = "Px_Hoy",
               "Prop. Px hoy/prom 2019" = "prop",
               "MktCap" = "Market Cap",
               "Precio Prom 2019" = "Prom",
               "Prom Px a FCO por Ind" = "prom_pxfco")

VarIndustrias <- c("Serv. Bas.", "Consumo", "Otro", "Banca", "Inmob.", "Pesca", "Minera", "Industrial", "Retail")


ui <- shinyUI(fluidPage(
  busyIndicator(text = "Estamos trayendo los datos actualizados desde Yahoo Finance para que los puedas utilizar .. no serán mas de 30 segundos.", wait = 0),
  
  for(i in 1:10) {
    Sys.sleep(0.2)
    # Dirk says using cat() like this is naughty ;-)
    #cat(i,"\r")
    # So you can use message() like this, thanks to Sharpie's
    # comment to use appendLF=FALSE.
    message(i,"\r",appendLF=FALSE)
    flush.console()
  },
  
  # Application title
  titlePanel(title="Acciones Bolsa Stgo"),       
  tabsetPanel(
    
    tabPanel("Introducción",
             navlistPanel(
               "Bienvenidos",
               tabPanel("Hola",
                        uiOutput("fecha"),
                        #shiny::actionButton("actualiza", "Cargar Datos", icon = icon("refresh")),
                        uiOutput("hola")),
               tabPanel("Log",
                        uiOutput("log"))
               )),
    
    tabPanel("Panel Principal",
             sidebarLayout(
               sidebarPanel(
                 selectizeInput("Atributo1",  #xaxis 
                                label = "AtributoX",
                                choices = variables, selected = NA),
                 selectizeInput("Atributo2",  #yaxis 
                                label = "AtributoY",
                                choices = variables, selected ="prop"),
                 
                 # sliderInput("clusters", "Numero de Clusters (K-Means):",
                 #             value = 10, min = 1, max = 9, round = TRUE, dragRange = FALSE),
                 radioButtons("Color", label = "Color Por:",
                              choices = c("Industria", "cluster"), 
                              selected = "Industria"),
                 checkboxGroupInput("checkGroup", label = h3("Industrias"), 
                                    choices = VarIndustrias,
                                    selected = VarIndustrias)
                
                 # radioButtons("Color", label = "Color Por:",
                 #              choices = list("Club" = "Club", "Division" = "Division"), 
                 #              selected = "Club"),
               ),
               mainPanel(
                 plotOutput("plot1"))))

    
    
               )))