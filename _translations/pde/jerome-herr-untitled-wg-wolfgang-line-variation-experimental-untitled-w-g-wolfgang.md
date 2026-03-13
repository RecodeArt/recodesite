---
title: "Untitled - WG Wolfgang (line variation)"
translator: "Jerome Herr"
translator_url: "https://www.facebook.com/AwesomeBrain"
slug: "jerome-herr-untitled-wg-wolfgang-line-variation-experimental-untitled-w-g-wolfgang"
artwork_slug: "v1n4-untitled-5"
category: "experimental"
description: "click to change the pattern"
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by W G Wolfgang
Originally published in "Computer Graphics and Art" v1n4, 1976
Copyright (c) 2013 Jerome Herr - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

float incr_x, incr_y, x, y, r, theta;
int countLine = 0; // how many lines in a (vertical) row?
int countCross = 0; // how many crosses in a (vertical) row?
int margin = 20;
int counter = -1;
int isX[] = {
};
int val;
int steps_x, steps_y; // number of rows and columns
int max = 4; // max number of symbols in a row, vertically!

void setup() {
  size(600, 600);
  theta = 0;
  //stroke(0);
  strokeWeight(1);
  strokeCap(SQUARE);

  steps_x = 10; //number of columns
  steps_y = 12; //number of lines

  incr_x = (width-2*margin)/float(steps_x);
  incr_y = (height-2*margin)/float(steps_y);

  drawPattern();
}

void draw() {

}

void drawPattern() {
  background(0);
  for (x = margin; x < width-margin; x += incr_x) {
    for (y = margin; y < height-margin; y += incr_y) {
      counter += 1;
      r = random(1);
      if (counter>2*steps_y-1) {
        if (isX[counter-2*steps_y]+isX[counter-steps_y]== 2) {
          val = 0;
        } 
        else if (isX[counter-2*steps_y]+isX[counter-steps_y]== 0) {
          val = 1;
        } 
        else {
          if (r >0.6) {
            val = 1;
          } 
          else {
            val = 0;
          }
        }
      } 
      else {
        if (r >0.5) {
          val = 1;
        } 
        else {
          val = 0;
        }
      }
      if (countLine == max) {
        val = 1;
      }
      if (countCross == max) {
        val = 0;
      }
      isX = append(isX, val);
      if (isX[counter] == 1) {
        isCross();
      } 
      else {
        isLine();
      }
    }
  }
}


void mouseClicked() {
  drawPattern();
}

void isCross() {
  stroke(80);
  noFill();
  rect(x, y, incr_x, incr_y);
  countCross += 1;
  countLine =0;
}

void isLine() {
  stroke(255);
  noFill();
  rect(x, y, incr_x, incr_y);
  countCross = 0;
  countLine +=1;
}
