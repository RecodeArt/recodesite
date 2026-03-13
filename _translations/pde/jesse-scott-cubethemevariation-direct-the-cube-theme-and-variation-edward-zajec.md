---
title: "CubeThemeVariation"
translator: "Jesse Scott"
translator_url: "http://processingvancouver.ca/"
slug: "jesse-scott-cubethemevariation-direct-the-cube-theme-and-variation-edward-zajec"
artwork_slug: "v1n2-the-cube-theme-and-variation"
category: "direct"
description: "Made by Jesse Scott as part of Processing Vancouver"
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "The Cube Theme and Variation" by Edward Zajec
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2013 Jesse Scott - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

//---------
// SETUP
//---------

void setup() {
  // Screen
  size(600, 600, P2D);
  background(0);
  fill(0, 255);
  stroke(255, 255);
  smooth();
  strokeWeight(2);
  
  // Angle Lines
  angularLines();
  
  // Rectangles
  wideLoad();
  
  // Turret Shapes
  turret();
  turretML();
  turretMM();
  turretMR();
  
  // Rectangles
  leftRect();
  rightRect();
  
  // Save Image
  save("screen.png");
  
}


  

//---------
// ANGULAR LINES
//---------

void angularLines() {
  pushMatrix();
  
  int offset = 10;
  
  for(int i = 0; i < width * 2; i+= offset) {
    line(0, i, i, 0); 
  }
  
  popMatrix();
}

//---------
// WIDE LOAD
//---------

void wideLoad() {
  pushMatrix();

  int offset = 5;
  int num = 15;
  float x = width * 0.05;
  float y = height * 0.66;
  translate(25, 0);
  
  for(int i = 0; i < num; i++) {
    rect( x - (offset*i), y + (offset*i), width, 30 ); 
  }
  
  popMatrix();
}

//---------
// TURRETS
//---------

void turret() {
  pushMatrix();
  
  int offset = 5;
  int num = 15;
  translate(66, -50);
  for(int i = 0; i < num; i++) {
    translate(-offset, offset);
    beginShape();
      vertex(-5,            height * 0.50);  // Bottom Left
      vertex(width + 5,     height * 0.50);  // Bottom Right
      vertex(width + 5,     height * 0.45);  // Top Right
      
      vertex(width * 0.80,   height * 0.45); // Right Turret Bottom Right
      vertex(width * 0.80,   height * 0.35); // Right Turret Top Right
      vertex(width * 0.75,  height * 0.35);  // Right Turret Top Left
      vertex(width * 0.75,  height * 0.45);  // Right Turret Bottom Left
      
      vertex(width * 0.55,  height * 0.45);  // Middle Turret Bottom Right
      vertex(width * 0.55,  height * 0.35);  // Middle Turret Top Right
      vertex(width * 0.50,  height * 0.35);  // Middle Turret Top Left
      vertex(width * 0.50,  height * 0.45);  // Middle Turret Bottom Left
      
      vertex(width * 0.35,  height * 0.45);  // Left Turret Bottom Right
      vertex(width * 0.35,  height * 0.35);  // Left Turret Top Right
      vertex(width * 0.30,  height * 0.35);  // Left Turret Top Left
      vertex(width * 0.30,  height * 0.45);  // Left Turret Bottom Left
      
      vertex(width * 0.05,  height * 0.45);  // Left Turret Bottom Right
      vertex(width * 0.05,  height * 0.25);  // Left Turret Top Right
      vertex(width * -0.05,  height * 0.25);  // Left Turret Top Left
      vertex(width * -0.05,  height * 0.45);  // Left Turret Bottom Left    
    endShape(CLOSE);
  }  
  popMatrix();
}

void turretML() {
  pushMatrix();
  int offset = 5;
  int num = 15;
  translate(66, -75);
  for(int i = 0; i < num; i++) {
    translate(-offset, offset);
    beginShape();
      vertex(width * 0.30, height * 0.01);  
      vertex(width * 0.30, height * 0.35);  
      vertex(width * 0.45, height * 0.35);
      vertex(width * 0.45, height * 0.25);
      vertex(width * 0.35, height * 0.25);
      vertex(width * 0.35, height * 0.01); 
    endShape(CLOSE);
  }  
  popMatrix();
}

void turretMM() {
  pushMatrix();
  int offset = 5;
  int num = 15;
  translate(66, -75);
  for(int i = 0; i < num; i++) {
    translate(-offset, offset);
    beginShape();
      vertex(width * 0.50, height * 0.10);  
      vertex(width * 0.50, height * 0.35);  
      vertex(width * 0.65, height * 0.35);
      vertex(width * 0.65, height * 0.25);
      vertex(width * 0.55, height * 0.25);
      vertex(width * 0.55, height * 0.10); 
    endShape(CLOSE);
  }   
  popMatrix();
}

void turretMR() {
  pushMatrix();

  int offset = 5;
  int num = 15;
  translate(66, -75);
  for(int i = 0; i < num; i++) {
    translate(-offset, offset);
    beginShape();
      vertex(width * 0.75, height * 0.10);  
      vertex(width * 0.75, height * 0.35);  
      vertex(width * 0.90, height * 0.35);
      vertex(width * 0.90, height * 0.25);
      vertex(width * 0.80, height * 0.25);
      vertex(width * 0.80, height * 0.10); 
    endShape(CLOSE);
  }  
  
  popMatrix();
}

//---------
// SQUARES
//---------

void leftRect() {
  pushMatrix();
  int offset = 5;
  int num = 15;
  translate(66, -150);
  for(int i = 0; i < num; i++) {
    translate(-offset, offset);
    rect(width * 0.50, height * 0.1, width * 0.15, height * 0.1);
  }  
  popMatrix();
}

void rightRect() {
  pushMatrix();
  int offset = 5;
  int num = 15;
  translate(66, -150);
  for(int i = 0; i < num; i++) {
    translate(-offset, offset);
    rect(width * 0.75, height * 0.1, width * 0.15, height * 0.1);
  }  
  popMatrix();
}
