---
title: "Untitled 2"
translator: "Genevieve Hoffman"
translator_url: "http://www.genevievehoffman.com/portfolio.html"
slug: "genevieve-hoffman-direct-untitled-2-various"
artwork_slug: "v1n4-untitled-2"
category: "direct"
description: "Made by Reiner Shneeberger and students."
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by Various
Originally published in "Computer Graphics and Art" vol1 no4, 1976
Copyright (c) 2012 Genevieve Hoffman - OSI/MIT license (http://recodeproject/license).
*/

// by Reiner Schneeberger and students
// Computer graphics made at the University of Munich (West Germany)

//1. Size of the sheet of paper.
//2. A scale distortion of 1:2 in one direction.
//3. The routine SNEKAD with eight parameters. 
//The routine SNEKAO proves here two elements: 
//1. <horizontal lines> 2. <vertical lines>. 
//These squares occur in a random order. 
//The scale distortion of 1:2 stretches the elements in one direction to produce graying effects.

int cols = 10;
int rows = 80;
int counter = 0;

void setup() {
  size(540, 800);
  background(255);
  stroke(0);

  float horiz = width/cols;
  float vert = horiz/2;

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      float rand = random(0, 2);    
      if (rand > 1) {
        //draw vertical lines
        for (float k = 0; k < horiz; k+=horiz/8) {
          line(j*horiz+k, i*vert, j*horiz+k, i*vert+vert);
        }
      } 
      else {
        //draw horizontal lines
        for(float k = 0; k < vert; k+=vert/8) {
          line(j*horiz, i*vert+k, j*horiz+horiz, i*vert + k);
        }
      }
    }
  }
}

void draw() {
}

void keyPressed() {
  saveFrame("Reiner_Schneeberger_Untitled2_####.jpg");
}
