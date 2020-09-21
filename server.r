function(input, output, session) {

  observeEvent(input$actualiza, {
    # Show a modal when the button is pressed
    #shinyalert("Cargando Datos...", "Estamos trayendo los datos actualizados desde Yahoo Finance para que los puedas utilizar", type = "info")
  })
  
  source("script_actualiza.R")
  
  data <- readRDS("data.rds")
  
  output$fecha <-  renderPrint( paste0("Ultima actualización:", Sys.time(), sep = ""))
    
  
  
  # output$fecha <-  renderPrint(Sys.time(  if (input$actualiza > 0 ) {
  #   source("script_actualiza.r")
  #   }
  #   ))

  
  
  
# Parte 2:   ----
  
  
  
  selectedData <- reactive({
    data %>% filter(Industria %in% input$checkGroup)
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  # if (input$Color == Cluster) {
  #   
  # }
  

  output$plot1 <- renderPlot({

    ggplot(selectedData(), aes_string(x = input$Atributo1, y = input$Atributo2,
                                                       label = "Nemo", colour = input$Color)) +
       geom_text(position=position_jitter(h=1,w=1), check_overlap = TRUE) +
       labs(colour= input$Color, title= paste("Grafico", input$Atributo1, "/",  input$Atributo2, sep =" "), subtitle = "Data: Yahoo Finance") +
      theme(legend.position = "none")
    #p <- ggplotly(p)


  })
  
  output$hola <- renderUI({
    HTML(' 
    <strong>Hola</strong><br>
<br>
Bienvenidos a esta plataforma, nos traemos la data desde Yahoo Finance para que puedas analizar el panorama de las acciones de la bolsa en tiempo real.<br>

Cualquier sugerencia es bienvenida<br>

Pueden contactarme en mi Instagram: ptv_analytics <br>  

<br>  
         ') 
  })
  
  output$log <- renderUI({
    HTML(' 
    <strong>Log</strong><br>
<br>
05-08-20:<br>
Corrección nombre variables.<br>
Generación de mensaje al cargar data.<br>
Selección de acciones por industria.<br>
<br>

02-08-20: <br>
Creación Shiny.<br>

Mejoras por incorporar:<br>
- Pestaña de Clustering, permitirá personalizarlo.<br>
- Introducción de nuevas variables en panel principal.<br>
- Incorporación de ponderador para seleccionador de acciones según criterio.<br>


Pueden contactarme a mi correo en (G) mail: pablotapiav <br>  

<br>  
         ') 
  })  
  
  
}
  
  # output$plot1 <- renderPlotly({
  #   
  #   x_var <- paste("Variable",input$Atributo1, sep =" " )
  #   y_var <- paste("Variable",input$Atributo2, sep =" " )
  #   titulo <- paste("Grafico ",input$Atributo1," / ",input$Atributo2)
  #   
  #   t <- list(
  #     family = "sans serif",
  #     size = 14,
  #     color = toRGB("grey50"))
  #   
  #   f <- list(
  #     family = "Courier New, monospace",
  #     size = 18,
  #     color = "#7f7f7f"
  #   )
  #   
  #   x_var <- list(
  #     title = x_var,
  #     titlefont = f
  #   )
  #   
  #   y_var <- list(
  #     title = y_var,
  #     titlefont = f
  #   )
  #   
  #   
  #   plot_ly(selectedData(),x= ~jitter(get(input$Atributo1)), y = ~get(input$Atributo2),type="scatter",color= ~get(input$Color) ,text= ~Nemo) %>%
  #           #hovertext=~paste("Nombre:",selectedData()$Nemo,"<br> Precio Hoy :", selectedData()$Px_Hoy,"<br> Industria :", selectedData()$Industria)) %>%
  #     add_markers()  %>%
  #     add_text(textfont = t, textposition = "top right") %>%
  #     layout(title= titulo, xaxis = x_var, yaxis = y_var)
  # })
  
  # 
  # output$table <- renderTable({  
  #   
  #   z <-reactive({ 
  #     data <- readRDS("dfambas.rds") 
  #     #select(Nombre, Apellido, Club, Edad, Posicion, Nacionalidad, CA, PA, Altura , Division, Liga, input$Var1, input$Var2, input$Var3, input$Var4)
  #     
  #     
  #     data %>% mutate(Ranking= data[[input$Var1]]*input$q1 + data[[input$Var2]]*input$q2 + data[[input$Var3]]*input$q3 + data[[input$Var4]]*input$q4,
  #                     Variable1 = round(data[[input$Var1]],0),
  #                     Variable2 = round(data[[input$Var2]],0),
  #                     Variable3 = round(data[[input$Var3]],0),
  #                     Variable4 = round(data[[input$Var4]],0)) %>% select(Nombre, Apellido,Variable1,Variable2,Variable3, Variable4 ,Ranking)  %>% top_n(5, Ranking) %>% arrange(desc(Ranking) )
  #     
  #     
  #   })
  #   
  #   return(head(z(),n = 5  ))
  #   
  # })
  # 
   
