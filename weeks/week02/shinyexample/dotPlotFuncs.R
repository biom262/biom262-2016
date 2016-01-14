makeXYDots<-function(distribution){
  #takes a distribution (list of data points, not necessarily ordered)
  #and makes a set of xy pairs where each x
  #want it to keep the same order as in the original distribution, but the ys
  #for any given x are increasing
  distribution=distribution[!is.na(distribution)]
  h=hist(distribution,breaks=c(unique(distribution),max(distribution)+.0000000001),right=F,plot=F)
  x=sort(distribution)
  y=numeric(length(x))
  curI=1
  for (i in 1:length(h$counts)){
    if (h$counts[i]>0){
      y[curI:(curI+h$counts[i]-1)]=1:h$counts[i]
      curI=curI+h$counts[i]
    }
  }
  q=list()
  q$x=x
  q$y=y
  return(q)
}

makeXYDotsBinned<-function(distribution,binSDFactor){
  #takes a distribution (list of data points, not necessarily ordered)
  #and makes a set of xy pairs where each x
  #want it to keep the same order as in the original distribution, but the ys
  #for any given x are increasing
  distribution=distribution[!is.na(distribution)]
  bsdf=sd(distribution)/binSDFactor
  h=hist(distribution,breaks=seq(min(distribution)-bsdf*3,max(distribution)+bsdf*3,by=bsdf),right=F,plot=F)
  x=sort(distribution)
  y=numeric(length(x))
  curI=1
  for (i in 1:length(h$counts)){
    if (h$counts[i]>0){
      y[curI:(curI+h$counts[i]-1)]=1:h$counts[i]
      curI=curI+h$counts[i]
    }
  }
  q=list()
  q$x=x
  q$y=y
  return(q)
}


makeXYDotsNoHistJumbled<-function(distribution,binSDFactor){
  distribution=distribution[!is.na(distribution)]
  bsdf=sd(distribution)/binSDFactor
  mn=min(distribution)
  mx=max(distribution)
  bins=seq(mn-bsdf*3,mx+bsdf*3,by=bsdf)
  counts=numeric(length(bins))
  for (i in 2:(length(bins)-1)){
    counts[i]=sum(distribution>=bins[i] & distribution<bins[i+1])
  }
  x=sort(distribution)
  y=numeric(length(x))
  xjumbled=numeric(length(x))
  curI=1
  for (i in 1:length(counts)){
    if (counts[i]>0){
      y[curI:(curI+counts[i]-1)]=1:counts[i]
      if (counts[i]>1){
        xjumbled[curI:(curI+counts[i]-1)]=sample(x[curI:(curI+counts[i]-1)],counts[i],replace=F)
      }else{
        xjumbled[curI]=x[curI]
      }
      curI=curI+counts[i]
    }
  }
  q=list()
  q$x=xjumbled
  q$y=y
  return(q)
}




makeXYDotsJumbled<-function(distribution,jumb){
  #takes a distribution (list of data points, not necessarily ordered)
  #and makes a set of xy pairs where each x
  #want it to keep the same order as in the original distribution, but the ys
  #for any given x are increasing
  distribution=distribution[!is.na(distribution)]
  #break it up into SD/10 cats
  w=sd(distribution)/jumb
  br=seq(min(distribution)-3*w,max(distribution)+3*w,by=w)
  h=hist(distribution,breaks=br,right=F,plot=F)
  x=sort(distribution)
  y=numeric(length(x))
  xjumbled=numeric(length(x))
  curI=1
  for (i in 1:length(h$counts)){
    if (h$counts[i]>0){
      y[curI:(curI+h$counts[i]-1)]=1:h$counts[i]
      if (h$counts[i]>1){
        xjumbled[curI:(curI+h$counts[i]-1)]=sample(x[curI:(curI+h$counts[i]-1)],h$counts[i],replace=F)
      }else{
        xjumbled[curI]=x[curI]
      }
      curI=curI+h$counts[i]
    }
  }
  q=list()
  q$x=xjumbled
  q$y=y
  return(q)
}


makeJiggerXYDots<-function(distribution){
  #takes a distribution (list of data points, not necessarily ordered)
  #and makes a set of xy pairs where each x
  #want it to keep the same order as in the original distribution, but the ys
  #for any given x are increasing
  distribution=distribution[!is.na(distribution)]
  h=hist(distribution,breaks=c(floor(unique(distribution)),max(distribution)+.0000000001),right=F,plot=F)
  x=sort(distribution)
  y=numeric(length(x))
  curI=1
  for (i in 1:length(h$counts)){
    y[curI:(curI+h$counts[i]-1)]=1:h$counts[i]
    curI=curI+h$counts[i]
  }
  q=list()
  q$x=x
  q$y=y
  return(q)
}


plotDotPlot<-function(distribution){
  #par(mfrow=c(3,1))
  dots=makeXYDots(distribution)
  plot(dots$x,dots$y,pch=16,xlab="value",ylab="count",main="Actual sample",xlim=c(min(distribution),max(distribution)))
}


plotDotPlotJumbled<-function(distribution,densityToo,jumb){
  #par(mfrow=c(3,1))
  distribution=distribution[!is.na(distribution)]
  dots=makeXYDotsJumbled(distribution,jumb)
  plot(dots$x,dots$y,pch=16,xlab="Points",ylab="Count",xlim=c(min(distribution),max(distribution)))
  if (densityToo==1){  dens=density(distribution)
                       lines(dens$x,dens$y)
                       
                       dens$y=dens$y*length(dots$x)
                       lines(dens$x,dens$y)
  }
}

chooseFromXYDots<-function(dots,sampleSize){
  #chooses dots from xy dot list and then replots with number over (because sample with replacement)
  indicesChosen=sample(1:length(dots$x),sampleSize,replace=T)
  newDots=makeXYDots(dots$x[indicesChosen])
  
  par(mfrow=c(3,1))
  mfg(c(1,1))
  plot(dots$x,dots$y,pch=16,xlab="value",main="Actual sample",xlim=c(dots$x[1],dots$x[length(dots$x)]))
  mfg(c(2,1))
  plot(c(dots$x[1],dots$x[length(dots$x)]),c(max(newDots$y),0),pch=16,xlab="value",main="Bootstrap sample",xlim=c(dots$x[1],dots$x[length(dots$x)]),col="white")
  for (iC in 1:sampleSize){
    mfg(c(1,1))
    #color red on actual sample plot
    points(dots$x[indicesChosen[iC]],1,col="red",pch=16)
    #plot on bootsrap sample plot
    points(dots$x[indicesChosen[iC]],dots$y[indicesChosen[iC]],col="red",pch=16)
    Sys.sleep(.4)
    
  }
}