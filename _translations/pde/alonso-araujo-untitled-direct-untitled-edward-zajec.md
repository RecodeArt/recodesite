---
title: "Untitled"
translator: "Alonso Araujo"
translator_url: ""
slug: "alonso-araujo-untitled-direct-untitled-edward-zajec"
artwork_slug: "v2n4-untitled-zajec"
category: "direct"
description: ""
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by Edward Zajec
Originally published in "Computer Graphics and Art" v2n4, 1977
Copyright (c) 2013 Alonso Araujo - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

void setup() {
  size(500, 650);
  noStroke();
  smooth();
  background(255);
  ellipseMode(CENTER);
  rectMode(CENTER);
}

/* 
Each one of the figures in this piece is drawn by a separate function, 
that way we could customize their behavior in the future.
Each one of the figures were previously studied to be the more accurate possible 
to the original piece.
At the beginning of each one of the functions are defined the different values
used to create the figures.
*/
void draw() {
  
  drawCenterEllipse();
  drawCenterRectangle();
  drawUpperRectangle();
  drawUpperCircle();
  drawBottomCircle();
  drawTriangle();
  
}

void drawCenterEllipse(){
  
  int diameterMax = 460;
  int diameterMin = 30;
  int positionX = 205;
  int positionY = 205;
  
  for(int d = diameterMin; d < diameterMax; d = d + 33){
    
    stroke(1,10);
    strokeWeight(2);
    fill(255,255,255,0);
    ellipse(positionX, positionY, d, d);
    
  }
  
}


void drawCenterRectangle(){
  
  int diameterMax = 250;
  int diameterMin = 15;
  int positionX = 317;
  int positionY = 460;
  pushMatrix();
  translate(positionX,positionY);
  rotate(0.6);
  
  for(int d = diameterMin; d < diameterMax; d = d + 10){
    
    
    stroke(1,10);
    strokeWeight(1.2);
    fill(255,255,255,0);
    if(d + 10 < diameterMax)
      rect(0, 0, d, d,3);
    else
      rect(0, 0, d, d);
    
  }
  popMatrix();
  
}

void drawUpperRectangle(){
  
  int diameterMax = 150;
  int diameterMin = 15;
  int positionX = 288;
  int positionY = 180;
  pushMatrix();
  translate(positionX,positionY);
  rotate(0.6);
  
  for(int d = diameterMin; d < diameterMax; d = d + 10){
    
    stroke(1,10);
    strokeWeight(1.2);
    fill(255,255,255,0);
    if(d + 10 < diameterMax)
      rect(0, 0, d, d,3);
    else
      rect(0, 0, d, d);
    
  }
  popMatrix();
  
   
}

void drawUpperCircle(){

  int diameterMax = 124;
  int diameterMin = 1;
  int positionX = 375;
  int positionY = 250;
  
  for(float d = diameterMin; d < diameterMax; d = d + 6){
    
    stroke(0.5,2);
    strokeWeight(2);
    fill(255,255,255,0);
    ellipse(positionX, positionY, d, d);
    
  }
  
}

void drawBottomCircle(){

  int diameterMax = 240;
  int diameterMin = 5;
  int positionX = 470;
  int positionY = 525;
  
  for(float d = diameterMin; d < diameterMax; d = d + 10){
    
    stroke(0.5,2);
    strokeWeight(2);
    fill(255,255,255,0);
    ellipse(positionX, positionY, d, d);
    
  }
  
}

void drawTriangle(){

  int x1 = 10;
  int y1 = 32;
  int x2 = 116;
  int y2 = 92;
  int x3 = 116;
  int y3 = -33;
  int maxTriangles = 70;
  
  for(int i = 0; i < maxTriangles; i = i + 5){
    
    stroke(0.5,20);
    strokeWeight(2);
    fill(255,255,255,0);
    triangle(x1 + i, y1, x2 - i/2, y2 - i, x3 - i/2, y3 + i);
    
  }
  
}
