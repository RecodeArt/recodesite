---
title: "Social Circle"
translator: "Alonso Araujo"
translator_url: ""
slug: "alonso-araujo-social-circle-experimental-untitled-edward-zajec"
artwork_slug: "v2n4-untitled-zajec"
category: "experimental"
description: "\"Social Circle\" represents the evolution of a social circle of shapes, where the influence of the larger group compels a minority to resemble them in order to stay in the circle."
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by Edward Zajec
Originally published in "Computer Graphics and Art" v2n4, 1977
Copyright (c) 2013 Alonso Araujo - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

/* 
Part of the ReCode Project (http://recodeproject.com)
"Social Circle" by Alonso Araujo
Based on "Untitled" by Edward Zajec
Originally published in "Computer Graphics and Art" v2n4, 1977
Copyright (c) 2013 Alonso Araujo - OSI/MIT license (http://recodeproject/license).
Contact alonso.araujo@outlook.com

"Social Circle" represents the evolution of a social circle of shapes,
where the influence of the larger group compels a minority to resemble
them in order to stay in the circle.

Controls
Move the mouse over the piece to go further in time and see the evolution of the
social circle.
*/

int numero = 1;
int colur = 2;
float rotar = 0.6;
float rotar2 = 1;
int number2 = 1;
int colur2 = 2;
int number3 = 1;
int colur3 = 2;
int triangleOpacity = 255;
int began = 1;

void setup() {
  size(500, 650);
  noStroke();
  smooth();
  background(255);
  ellipseMode(CENTER);
  rectMode(CENTER);
}

void draw() {
  
  drawCenterRectangle();
  drawUpperRectangle();
  if(began == 1){
    drawTriangle();
    drawCompleteCenterEllipse();
    drawCompleteUpperCircle();
    drawCompleteBottomCircle();
  }
  
}

void drawCenterEllipse(){
  
  int diameterMax = 460;
  int diameterMin = 30;
  int positionX = 205;
  int positionY = 205;
  
  if(colur == 1)
    stroke(255,0,0,110);
  else if (colur == 2)
    stroke(1,80);
    
  int d = 33 * numero;
  
    
    strokeWeight(2);
    fill(255,255,255,0);
    ellipse(positionX, positionY, d, d);
    
}

void drawCompleteCenterEllipse(){
  
  int diameterMax = 460;
  int diameterMin = 30;
  int positionX = 205;
  int positionY = 205;
  
  for(int d = diameterMin; d < diameterMax; d = d + 33){
    
    stroke(0.9,10);
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
  rotate(rotar);
  
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
  rotate(rotar);
  
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
  
  if(colur3 == 1)
    stroke(255,0,0,90);
  else if (colur3 == 2)
    stroke(1,80);
  
  int d = number3 * 6;
    
    strokeWeight(2);
    fill(255,255,255,0);
    ellipse(positionX, positionY, d, d);
    
  
  
}

void drawBottomCircle(){

  int diameterMax = 240;
  int diameterMin = 5;
  int positionX = 470;
  int positionY = 525;
  
  if(colur2 == 1)
    stroke(255,0,0,90);
  else if (colur2 == 2)
    stroke(1,80);
  
  int d = 10 * number2;
    
    strokeWeight(2);
    fill(255,255,255,0);
    ellipse(positionX, positionY, d, d);
    
  
  
}

void drawCompleteUpperCircle(){

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

void drawCompleteBottomCircle(){

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
  pushMatrix();
  translate(80,-40);
  rotate(rotar2);
  
  for(int i = 0; i < maxTriangles; i = i + 5){
    
    stroke(1,5 - (mouseX*0));
    strokeWeight(2);
    //fill(255,255,255,0);
    triangle(x1 + i, y1, x2 - i/2, y2 - i, x3 - i/2, y3 + i);
    
  }  
  popMatrix();
}

void mouseMoved(){

  numero++;
  number2++;
  number3++;
  
  if(numero*33 > 490){
    numero = 1;
    colur++;
  }
  
  if(number2*10 > 240){
    number2 = 1;
    colur2++;
  }
  
  if(number3*6 > 124){
    number3 = 1;
    colur3++;
  }
  
  if(colur > 2)
    colur = 1;
  if(colur2 > 2)
    colur2 = 1;
    
    
  drawCenterEllipse();
  drawBottomCircle();
  drawUpperCircle();
  drawTriangle();

  triangleOpacity = 0;
  rotar = rotar + 0.005;
  rotar2 = rotar2 + 0.005;
  began =0;
}
