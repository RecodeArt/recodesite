---
title: "Untitled 5"
translator: "Thomas Neveling"
translator_url: ""
slug: "thomas-neveling-untitled-5-experimental-untitled-1-various"
artwork_slug: "v1n4-untitled-1"
category: "experimental"
description: "Minor changes of the values sizeDifference, offset intense change of iteration depth, max i =400. New: rgb colored filling."
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 1" by Various
Originally published in "Computer Graphics and Art" v1n4, 1976
Copyright (c) 2013 Thomas Neveling - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

int cols = 10;
int rows = 10;
float offsetX;
float offsetY;
int sqSize= 100;
int sizeDifference = 3;

void setup() {
  size(1000, 1000);
  offsetX = 3;
  offsetY = 3;
  rectMode(CENTER);
  strokeWeight(1);
  fill(255);
  //for every row...
  for (int r = 1; r<rows; r++) {
    //for every column...
    for (int c = 1; c<cols; c++) {
      //choose a new offset
      offsetX = random(-3,3);
      offsetY = random(-3,3);
      rect(c*sqSize, r*sqSize, sqSize, sqSize);
      for (int i=1; i<400; i++) {
        strokeWeight(random(1,1));

        rect((c*sqSize)+(i*offsetX), (r*sqSize)+(i*offsetY), sqSize - (i*sizeDifference), sqSize - (i*sizeDifference));
       fill(random(220,255),random(220,255),random(220,255));
      }
    }
  }
}

void draw() {
}
