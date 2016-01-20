if (!require("pacman")) install.packages("pacman")
pacman::p_load(pander,markdown,stringr,shiny)
#######################


# function derived from the highlightHTMLcells() function of the highlightHTML package
colortable <- function(htmltab, css, style="table-condensed table-bordered"){
  tmp <- str_split(htmltab, "\n")[[1]] 
  CSSid <- gsub("\\{.+", "", css)
  CSSid <- gsub("^[\\s+]|\\s+$", "", CSSid)
  CSSidPaste <- gsub("#", "", CSSid)
  CSSid2 <- paste(" ", CSSid, sep = "")
  ids <- paste0("<td id='", CSSidPaste, "'")
  for (i in 1:length(CSSid)) {
    locations <- grep(CSSid[i], tmp)
    tmp[locations] <- gsub("<td", ids[i], tmp[locations])
    tmp[locations] <- gsub(CSSid2[i], "", tmp[locations], 
                           fixed = TRUE)
  }
  htmltab <- paste(tmp, collapse="\n")
  Encoding(htmltab) <- "UTF-8"
  list(
    tags$style(type="text/css", paste(css, collapse="\n")),
    tags$script(sprintf( 
      '$( "table" ).addClass( "table %s" );', style
    )),
    HTML(htmltab)
  )
}


#Define the server logic required to draw the output
shinyServer(
  function(input,output){
    # Expression that generates the plot. The expression is
    # wrapped in a call to renderPlot to indicate that:
    #
    #  1) It is "reactive" and therefore should re-execute automatically
    #     when inputs change
    #  2) Its output type is a plot  
    cssNoDots <- c("#bgyellow {background-color: #FFFF99;}",
                   "#bgblue {background-color: #0099FF;}",
                   "#bgred {background-color: #FF3366;}",
                   "#bgcyan {background-color: #66FFFF;}"
    )
    cssDots <- c("#bgpurple {background-color: #7F6AFA;}",
                 "#bgorange {background-color: #F49816;}",
                 "#bglightpurple {background-color: #D6B7F6;}",
                 "#bglightorange {background-color: #F7CF97;}"
    )
    
    piH0 = 0.5 
    xvals=seq(0,1,by=0.001)
    getpiHA<-reactive({input$piHA})
    getSigLevel<-reactive({input$sigLevel})
    getSampleSize<-reactive({input$sampleSize})
    getSEH0<-reactive({sqrt(piH0*(1-piH0)/input$sampleSize)})
    getAlphaPosition<-reactive({qnorm(1-input$sigLevel,piH0,sqrt(piH0*(1-piH0)/input$sampleSize))})
    getYValsH0<-reactive({dnorm(xvals,piH0,sqrt(piH0*(1-piH0)/input$sampleSize))})
    getYValsHA<-reactive({dnorm(xvals,input$piHA,sqrt(piH0*(1-piH0)/input$sampleSize))})
    getDots<-reactive({input$dots})
    getIncludeHTML<-reactive({if (input$dots==1){return(includeHTML("includeDots.html"))}else{return(includeHTML("include.html"))}})
    
    magenta=rgb(.4,0,1)
    green=rgb(1,.7,0)
    cyan=rgb(0,1,1)
    blue=rgb(0,0,1)
    yellow=rgb(1,1,0,.7)
    red=rgb(1,0,0)
    
    output$errorPlot <- renderPlot({
      
      #Get reactive components
      piHA=getpiHA()
      sampleSize=getSampleSize()
      seH0=getSEH0()
      sigLevel=getSigLevel()
      alphaPosition=getAlphaPosition()
      yvalsH0=getYValsH0()
      yvalsHA=getYValsHA()
      dots=getDots()
      
      #Draw distribution outlines
      plot(xvals,yvalsH0,type="l",,xlab="proportion",yaxt='n',ylab="frequency of getting a particular proportion (height of a bar of dots)",lwd=1)
      lines(xvals,yvalsHA)
      
      #New version - error regions are dots and the full distributions are shaded (or maybe just left)
      
      #Alt is behind, null is striped in front
      #except if piA is < pi0 in which case blue alt good region is in front of red type I region
      
      #Draw Alt distribution no error
      
      iL=which(xvals>=alphaPosition)[1]
      iR=length(xvals)
      xv=c(xvals[iL],xvals[iL:iR],xvals[iR],xvals[iL])
      yv=c(0,yvalsHA[iL:iR],0,0)
      altLater=0
      if (dots==1){
        polygon(xv,yv,col=green)
      } else {
        if (piHA<piH0){
          altLater=1
        } else {
          polygon(xv,yv,col=cyan)
        }
      }
      
      
      
      
      
      
      #Draw Null distribution no error
      iL=1
      iR=which(xvals>=alphaPosition)[1]
      xv=c(xvals[iL],xvals[iL:iR],xvals[iR],xvals[iL])
      yv=c(0,yvalsH0[iL:iR],0,0)
      if (dots==1){
        polygon(xv,yv,col=magenta)#,density=20,angle=90)
      } else {
        polygon(xv,yv,col=blue,density=20,angle=90)       
      }
      
      
      #Draw Type II error
      iL=1
      iR=which(xvals>=alphaPosition)[1]
      xv=c(xvals[iL],xvals[iL:iR],xvals[iR],xvals[iL])
      yv=c(0,yvalsHA[iL:iR],0,0)
      
      if (dots==1){
        
        xvSub=seq(iL,iR,by=15)
        xv2=xvals[xvSub]
        yv2=yvalsHA[xvSub]
        nonZero=which(yv2>.0001)
        yv2=yv2[nonZero]
        xv2=xv2[nonZero]
        yv3=unlist(sapply(yv2,function(x){seq(0,x,by=.4)}))#may need to play with this .1 thing to find the right vertical dot spacing
        xv3=unlist(sapply(yv2,function(x){length(seq(0,x,by=.4))}))
        if (!is.null(xv3)){
          xv4=xv2[unlist(sapply(1:length(xv3),function(x,y){numeric(y[x])+x},xv3))]
          points(xv4,yv3,col=green,pch=16)
        }
      } else {
        polygon(xv,yv,col=yellow)
      }
      
      
      #Draw Type I error
      abline(v=alphaPosition,,lty="longdash",col="darkgreen",lwd=2)
      
      iL=which(xvals>=alphaPosition)[1]
      iR=length(xvals)
      xv=c(xvals[iL],xvals[iL:iR],xvals[iR],xvals[iL])
      yv=c(0,yvalsH0[iL:iR],0,0)
      
      if (dots==1){
        xvSub=seq(iL,iR,by=15)
        xv2=xvals[xvSub]
        yv2=yvalsH0[xvSub]
        nonZero=which(yv2>.0001)
        yv2=yv2[nonZero]
        xv2=xv2[nonZero]
        yv3=unlist(sapply(yv2,function(x){seq(0,x,by=.4)}))#may need to play with this .1 thing to find the right vertical dot spacing
        xv3=unlist(sapply(yv2,function(x){length(seq(0,x,by=.4))}))
        if (!is.null(xv3)){
          xv4=xv2[unlist(sapply(1:length(xv3),function(x,y){numeric(y[x])+x},xv3))]
          points(xv4,yv3,col=magenta,pch=16)          
        }
      } else {
        polygon(xv,yv,col=red,density=40,angle=90)
      }    
      if (altLater){
        iL=which(xvals>=alphaPosition)[1]
        iR=length(xvals)
        xv=c(xvals[iL],xvals[iL:iR],xvals[iR],xvals[iL])
        yv=c(0,yvalsHA[iL:iR],0,0)
        
        polygon(xv,yv,col=cyan)
      }
      
      
      if (dots==1){
        lines(xvals,yvalsHA,col=green,lwd=2)
        lines(xvals,yvalsH0,col=magenta,lwd=2)
      }        
      
      
      
      
    })#end render plot
    
    output$errorTable<-renderUI({
      #Get reactive components
      piHA=getpiHA()
      seH0=getSEH0()
      sigLevel=getSigLevel()
      alphaPosition=getAlphaPosition()
      dots=getDots()
      
      
      #Determine error table
      errorTab=array(0,dim=c(2,2))
      #Type I
      errorTab[1,1]=sigLevel
      #Null good
      errorTab[2,1]=1-sigLevel
      #Alt good = power
      errorTab[1,2]=pnorm(alphaPosition,piHA,seH0,lower.tail=F)
      #Type II
      errorTab[2,2]=1-errorTab[1,2]
      
      errorDF=data.frame(errorTab,row.names=c("Alt true","Null true"))
      names(errorDF)=c("Null true","Alt true")
      #errorDF
      
      if (dots==1){
        errorTab=data.frame(Null.true=c(sprintf("%0.2f #bglightpurple",errorTab[1,1]),
                                        sprintf("%0.2f #bgpurple",errorTab[2,1])),
                            Alt.true=c(sprintf("%0.2f #bgorange",errorTab[1,2]),
                                       sprintf("%0.2f #bglightorange",errorTab[2,2])),
                            row.names=c("Alt true","Null true")
        )
        css=cssDots
      } else {
        errorTab=data.frame(Null.true=c(sprintf("%0.2f #bgred",errorTab[1,1]),
                                        sprintf("%0.2f #bgblue",errorTab[2,1])),
                            Alt.true=c(sprintf("%0.2f #bgcyan",errorTab[1,2]),
                                       sprintf("%0.2f #bgyellow",errorTab[2,2])),
                            row.names=c("Alt true","Null true")
        )
        css=cssNoDots
      }
      htmlErrorTab=markdownToHTML(text=pandoc.table.return( errorTab, style="rmarkdown",split.tables=Inf),fragment.only=TRUE)
      colortable(htmlErrorTab,css)
    })
    
    output$statsSD<-renderText({
      seH0=getSEH0()
      sprintf("SD: %0.3f",seH0)     
    })
    output$statsPHAT<-renderText({
      alphaPosition=getAlphaPosition()
      HTML(sprintf("p hat value for the significance level cutoff:  %0.2f",alphaPosition)  )    
    })
    
    output$includeHTML<-renderUI({
      getIncludeHTML()
      
    })
    
    
  }#function def
)#shinyServer