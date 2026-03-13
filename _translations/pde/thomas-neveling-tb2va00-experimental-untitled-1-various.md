---
title: "tb2va00"
translator: "thomas neveling"
translator_url: ""
slug: "thomas-neveling-tb2va00-experimental-untitled-1-various"
artwork_slug: "v1n4-untitled-1"
category: "experimental"
description: ""
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 1" by Various
Originally published in "Computer Graphics and Art" v1n4, 1976
Copyright (c) 2013 thomas neveling - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

int width=1000;
int sqSize= 333;
int cols = width/sqSize;
int rows = width/sqSize;
float offsetX;
float offsetY;

int sizeDifference = 1;

void setup() {
  size(1000, 1000);
  offsetX = 3;
  offsetY = 3;
  //rectMode(CENTER);
  strokeWeight(1);
  fill(0);

  //for every row...
  for (int r = 0; r<rows; r++) {
    //for every column...
    for (int c = 0; c<cols; c++) {
      //choose a new offset
      offsetX = random(-3,3);
      offsetY = random(-3,3);
      rect(c*sqSize, r*sqSize, sqSize, sqSize);
      for (int i=1; i<(sqSize/sizeDifference); i++) {
        strokeWeight(random(.5));
        rect((c*sqSize)+(i*offsetX), (r*sqSize)+(i*offsetY), sqSize - (i*sizeDifference), sqSize - (i*sizeDifference));
      }
fill(random(0,255),random(0,255),random(0,255),random(0,10));    
}          
  }
}

void draw() {
}
