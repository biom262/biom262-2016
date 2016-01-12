if (!require("pacman")) install.packages("pacman")
pacman::p_load(shiny)
#########################
shinyUI(
  fluidPage(
    

    title="Error and Power Applet",
    h4("Error and Power Applet"),
    fluidRow(
      column(9,
             plotOutput("errorPlot")
             ,          
             fluidRow(       
               column(5,offset=4,
                      sliderInput("piHA",HTML("Alternative &#960;"),min=.28,max=.76,value=.62,animate=T,step=0.02,width="100%")
               ),
               column(3,""
               )
             ),
             fluidRow(
               column(5,
                      sliderInput("sampleSize","Sample size",min=40,max=1000,value=100,step=10,animate=T,width="100%")
               ),
               column(5,offset=2,
                      sliderInput("sigLevel","Significance level",min=0.005, max=0.2,value=0.05,width="100%",step=0.005,animate=T)
               )  
             )
      ),
      column(3,
             h5("Reality is in the columns"),
             
             tableOutput("errorTable"),
             h5("Your inference is in the rows")
             ,
             fluidRow(
               column(12,
                      textOutput("statsSD")
               )
             ),fluidRow(
               column(12,
                      textOutput("statsPHAT")
               )
             )
      )
    ),
    fluidRow(
      column(9,
             uiOutput("includeHTML")
      ),
      column(3,
             radioButtons("dots",label=h5("Color scheme"),
                          choices=list("Multicolored"=0,"Dotted (good for colorblind)"=1),selected=1)
      )
    )
    
  )
)
