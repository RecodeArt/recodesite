---
title: "Untitled 4"
translator: "Will Secor"
translator_url: "http://www.williamsecor.com/"
slug: "will-secor-untitled-4-direct-untitled-4-various"
artwork_slug: "v1n4-untitled-4"
category: "direct"
description: "Click to redraw."
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 4" by Various
Originally published in "Computer Graphics and Art" v1n4, 1976
Copyright (c) 2013 Will Secor - OSI/MIT license (http://recodeproject/license).
*/


// This sketch does not exactly duplicate the original, rather it
// contains the same proportion of rotated elements, per column,
// as the original in Computer Graphics and Art.  This is detailed 
// in the array "rotated" below.

int cols = 25;
int rows = 36;

void setup() {
  size(900,1296);
  noLoop();
  smooth();
}

void draw(){
  background(255);
  stroke(0);
  strokeWeight(2);
  int[] rotated = {
    0,3,5,8,6,9,4,14,14,15,16,16,24,20,20,21,25,29,25,28,29,31,35,35,36};
  column(36,4,36,rotated);
}

void element(int wide,int spacing) {
  for (int i = 0; i <= wide; i = i + spacing) {
    line(i,0,i,wide);
  }
}

void column(int wide, int spacing, int total, int[] rotated) {
  
  // create a 2D array, populate each column with the appropriate number
  // of rotated elements, then shuffle the columns

  int[][] numbers = new int[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j= 0; j < rows; j++) {
      if (rotated[i] > 0) {
        numbers[i][j] = 1;
      }
      else {
        numbers[i][j] = 0;
      }
      rotated[i] = rotated[i] - 1;
    }
  }
  shuffle(numbers);
  
  // draw according to instructions in the array (1 = rotated)
  
  for (int z = 0; z < cols; z++) {
    for (int m = 0; m < total; m++) {
      if (numbers[z][m] < 1) {
        pushMatrix();
        translate(z*wide,(wide*m));
        element(wide, spacing);
        popMatrix();
      }
      else {
        pushMatrix();
        translate(z*wide,wide*(m+1));
        rotate(radians(270));
        element(wide,spacing);
        popMatrix();
      }
    }  
  }
  
  // draw in some white lines to simulate depth
  
  for (int x = 1; x < cols-1; x++) {
    for (int y= 0; y < rows-1; y++) {
      if ((numbers[x][y] == 1) && (numbers[x][y+1] == 0)) {
        stroke(255);
        line(x*wide,((y+1)*wide),((x+1)*wide),((y+1)*wide));
      }
    }
  }
  
  for (int x = 1; x < cols-1; x++) {
    for (int y= 0; y < rows; y++) {
      if ((numbers[x][y] == 1) && (numbers[x+1][y] == 0)) {
        stroke(255);
        line((x+1)*wide,y*wide,(x+1)*wide,(y+1)*wide);
      }
    }
  }
}



//Fisher-Yates shuffle, good times!

void shuffle(int[][] numbers) {
  for (int k = 0; k < cols; k++) {
    for (int i = numbers[k].length-1; i > 0; i = i - 1) {
      int j = int(random(i+1));
      int temp1 = numbers[k][i];
      int temp2 = numbers[k][j];
      numbers[k][i] = temp2;
      numbers[k][j] = temp1;
    }
  }
}

void mousePressed(){
  redraw();
}
