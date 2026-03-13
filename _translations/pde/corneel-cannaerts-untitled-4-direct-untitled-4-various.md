---
title: "Untitled 4"
translator: "Corneel Cannaerts"
translator_url: "http://introspector.be/"
slug: "corneel-cannaerts-untitled-4-direct-untitled-4-various"
artwork_slug: "v1n4-untitled-4"
category: "direct"
description: "Direct Translation of Untitled 4 Click mouse to regenerate with different random values."
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 4" by Various
Originally published in "Computer Graphics and Art" v1n4, 1976
Copyright (c) 2013 Corneel Cannaerts - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

int pad, stepX, stepY, numX, numY;
float hatch;

void setup() {
  size(820, 1200); 
  smooth();
  pad =10;
  stepX = 80;
  stepY = 40;
  numX = (width-2*pad)/stepX;
  numY = (height-2*pad)/stepY;
  hatch = 7.0;
  strokeWeight(1.1);
}

void draw() {
  background(255);
  for (int i=0; i<numX; i++) {
    for (int j=0; j<numY; j++) {
      pushMatrix();
      translate(i*stepX+pad,j*stepY+pad);
      if(random(1)<0.5) vertical();
      else horizontal();
      popMatrix();
    }
  }
  noLoop();
}

void vertical() {
  for(int i=0; i<hatch; i++){   
    line(i*stepX/hatch, 0, i*stepX/hatch,stepY);   
  } 
}

void horizontal() {
  for(int i=1; i<hatch+1; i++){   
    line(0,i*stepY/hatch, stepX, i*stepY/hatch);   
  } 
}

void mouseClicked(){
  loop();
}
