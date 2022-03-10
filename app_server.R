#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shiny")
require(EpiModel)

server <- function(input, output) {
  
  output$intro_img <- renderUI({
    tags$img(src = "https://i.postimg.cc/jq1S0rcV/24masks-2048x966.jpg")
  })
  
  output$interp_img <- renderUI({
    tags$img(src = "https://media.istockphoto.com/vectors/people-celebrating-the-end-of-the-covid-19-quarantine-vector-id1223342905?k=6&m=1223342905&s=170667a&w=0&h=EuWTaUTkGTL2nKYZKBNmcjxt5745iswkfWCRIG-cdC4=")
  })
  
  output$plot1 <- renderPlot({
    if (input$plot1var == "No Mask") {
      param <- param.dcm(inf.prob = 1.0, act.rate = 1.12, rec.rate = 1/7)
    } else if (input$plot1var == "Strong Mask Deployment") {
      param <- param.dcm(inf.prob = 0.2, act.rate = 1.12, rec.rate = 1/7)
    } else if (input$plot1var == "Moderate Mask Deployment") {
      param <- param.dcm(inf.prob = 0.5, act.rate = 1.12, rec.rate = 1/7)
    } else if (input$plot1var == "Weak Mask Deployment") {
      param <- param.dcm(inf.prob = 0.8, act.rate = 1.12, rec.rate = 1/7)
    }
    init <- init.dcm(s.num = 7766925, i.num = 1, r.num = 0)
    control <- control.dcm(type = "SIR", nsteps = 365, dt = 0.5)
    mod <- dcm(param, init, control)
    
    plot(mod)
  })
  
  output$plot2 <- renderPlot({
    if (input$plot2var == "No vaccination protocol") {
      param <- param.dcm(inf.prob = 1.2, act.rate = 1.12, rec.rate = 1/7)
    } else if (input$plot2var == "Strict vaccination protocol") {
      param <- param.dcm(inf.prob = 0.4, act.rate = 1.12, rec.rate = 1/7)
    }
    init <- init.dcm(s.num = 7766925, i.num = 1, r.num = 0)
    control <- control.dcm(type = "SIR", nsteps = 365, dt = 0.5)
    mod <- dcm(param, init, control)
    
    plot(mod)
  })
  
  output$plot3 <- renderPlot({
    if (input$plot3var == "No Mask") {
      param.icm <- param.icm(inf.prob = c(1.0), act.rate = 0.5, rec.rate = 1/7)
    } else if (input$plot3var == "Strong Mask Deployment") {
      param.icm <- param.icm(inf.prob = c(0.2), act.rate = 0.5, rec.rate = 1/7)
    } else if (input$plot3var == "Moderate Mask Deployment") {
      param.icm <- param.icm(inf.prob = c(0.5), act.rate = 0.5, rec.rate = 1/7)
    } else if (input$plot3var == "Weak Mask Deployment") {
      param.icm <- param.icm(inf.prob = c(0.8), act.rate = 0.5, rec.rate = 1/7)
    }

    init.icm <- init.icm(s.num = 700, i.num = 1, r.num = 0)
    control.icm <- control.icm(type = "SIR", nsims = 100, nsteps = 365)
    mod.icm <- icm(param.icm, init.icm, control.icm)
    plot(mod.icm)
  })
  
  output$plot4 <- renderPlot({
    if (input$plot4var == "No vaccination protocol") {
      param.icm <- param.icm(inf.prob = c(1.0), act.rate = 1.12, rec.rate = 1/7)
    } else if (input$plot4var == "Strict vaccination protocol") {
      param.icm <- param.icm(inf.prob = c(0.4), act.rate = 1.12, rec.rate = 1/7)
    }
    
    init.icm <- init.icm(s.num = 700, i.num = 1, r.num = 0)
    control.icm <- control.icm(type = "SIR", nsims = 100, nsteps = 365)
    mod.icm <- icm(param.icm, init.icm, control.icm)
    plot(mod.icm)
  })
}

shinyServer(server)
