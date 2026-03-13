---
title: "tb2ez01"
translator: "thomas neveling"
translator_url: ""
slug: "thomas-neveling-tb2ez01-experimental-untitled-edward-zajec"
artwork_slug: "v2n4-untitled-zajec"
category: "experimental"
description: "The changes of this base algorithm from Edward Zajec brings color to the results and looks a little bit human made. Intense changes of the figure-functions, now the objects are placed by random numbers. The alpha value is now changed during painting."
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by Edward Zajec
Originally published in "Computer Graphics and Art" v2n4, 1977
Copyright (c) 2013 thomas neveling - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

/* @pjs pauseOnBlur="true"; */

int width=1000;
int height=1000;
int maxf=random(1,7);
int maxW=width/2;
int minW=maxW/3;
int c=0;
int alpha=0;

void setup() {
  size(width,height);
  noStroke();
  smooth();
  background(random(100),random(100),random(100));
  ellipseMode(CENTER);
  rectMode(CENTER);
}

/* 
Each one of the figures in this piece is drawn by a separate 

function, 
that way we could customize their behavior in the future.
Each one of the figures were previously studied to be the more 

accurate possible 
to the original piece.
At the beginning of each one of the functions are defined the 

different values
used to create the figures.
*/

void draw() {
  while (c<maxf){
  alpha=random(5);
  drawEllipse(random(0,width),random(0,height),false);
  drawRectangle(random(0,width),random(0,height),false);
  drawTriangle(random(0,width),random(0,height),false);
  c=c+1;
  }
  if(c %5==0){
  drawEllipse(random(0,width),random(0,height),true);
  c=c+1;
}
  if(c %3==0){
   drawRectangle(random(0,width),random(0,height),true);
  c=c+1;
}
  if(c %2==0){
 drawTriangle(random(0,width),random(0,height),true);
  c=c+1;
}
 

}

void drawEllipse(positionX,positionY,last){
  
  int diameterMax = random(minW,maxW);
  int diameterMin = minW;
  int step=random(2,minW/2);
  int  r=random(0,255);
  int  g=random(0,255);
  int  b=random(0,255); 

  
  for(int d = diameterMin; d < diameterMax; d = d + step){
    
    stroke(1,random(150));
    strokeWeight(random(5));
    if (last)     
    fill(r,255,255,alpha);
    else 
    fill(r,g,b,alpha);
    
    ellipse(positionX, positionY, d, d);
    
  }
  
}

void drawRectangle(positionX,positionY,last){
  
  int diameterMax = random(minW,maxW);
  int diameterMin = minW;
  int step=random(2,minW/2);
  int  r=random(0,255);
  int  g=random(0,255);
  int  b=random(0,255); 

  pushMatrix();
  translate(positionX,positionY);
  rotate(random(1));
 
  
  for(int d = diameterMin; d < diameterMax; d = d + step){
    
    
    stroke(1,random(150));
    strokeWeight(random(5));
    if (last)     
    fill(255,g,255,alpha);
    else 
    fill(r,g,b,alpha);
    if(d + step < diameterMax)
      rect(0, 0, d, d,3);
    else
      rect(0, 0, d, d);
    
  }
  popMatrix();
  
}



void drawTriangle(positionX,positionY,last){
  int diameterMax = random(minW,maxW);
  int diameterMin = minW;
  int step=random(1,5);
  int  r=random(0,255);
  int  g=random(0,255);
  int  b=random(0,255); 


  int x1 = positionX;
  int y1 = positionY;
  int x2 = x1+50;
  int y2 = y1+random(100);
  int x3 = x2-random(250);
  int y3 = y1+random(250);
  int maxTriangles = random(5,maxW/2);


  for(int i = 0; i < maxTriangles; i = i + step){
    
    stroke(1,random(150));
    strokeWeight(random(5));

    if (last)     
    fill(255,255,b,alpha);
    else 
    fill(r,g,b,alpha);
    triangle(x1 + i, y1, x2 - i/2, y2 - i, x3 - i/2, y3 + i);
    
  }
  
}
