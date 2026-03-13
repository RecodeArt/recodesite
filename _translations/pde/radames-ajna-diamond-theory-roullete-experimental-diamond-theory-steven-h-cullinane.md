---
title: "Diamond Theory Roullete"
translator: "Radames Ajna"
translator_url: "http://www.radames.in/"
slug: "radames-ajna-diamond-theory-roullete-experimental-diamond-theory-steven-h-cullinane"
artwork_slug: "v2n1-diamond-theory"
category: "experimental"
description: ""
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Diamond Theory" by Steven H Cullinane
Originally published in "Computer Graphics and Art" v2n1, 1977
Copyright (c) 2013 Radames Ajna - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

int bits[] = {
  0, 1, 0, 1, 
  2, 3, 2, 3, 
  0, 1, 0, 1, 
  2, 3, 2, 3
};

float lsize = 100;

long lastTime;
long accTime;

float v=1;
void setup() {
  size(int(lsize*4+100), int(lsize*4+100));
  background(255);
  smooth();

  randss();
  redraw();
  //noLoop();
  noStroke();
  lastTime = millis();
  accTime = millis();
}


void draw() {

  background(255);
  pushMatrix();
  translate(width/2, height/2);
  drawTriangle(bits);
  popMatrix();

  if (millis()-lastTime<5000) {
    v+=exp(0.0005*millis());
    //  println(v); 
    if (millis() - accTime > v) {
      accTime=millis();
      randss();
    }
  }
  else {
    noLoop();
  }
}

void drawTriangle(int bits[]) {
  pushMatrix();
  translate(-lsize*4/2, -lsize*4/2);
  for (int x=0;x<4;x++) {
    for (int y=0;y<4;y++) {
      int i = x + y*4;
      pushStyle();
      fill(0);
      pushMatrix();
      translate(x*lsize, y*lsize);
      beginShape(TRIANGLES);
      switch(bits[i]) {

      case 0:
        // bottom right
        //triangle(lsize, lsize, 0, lsize, lsize, 0);
        vertex(lsize, lsize);
        vertex(0, lsize);
        vertex(lsize, 0);


        break;
      case 1:
        ///bottom left
        //triangle(0, 0, 0, lsize, lsize, lsize);
        vertex(0, 0);
        vertex(0, lsize);
        vertex(lsize, lsize);
        break;
      case 2:
        //top right
        //triangle(0, 0, lsize, 0, lsize, lsize);
        vertex(0, 0);
        vertex(lsize, 0);
        vertex(lsize, lsize);
        break;
      case 3:
        //top left
        //triangle(0, 0, lsize, 0, 0, lsize);
        vertex(0, 0);
        vertex(lsize, 0);
        vertex(0, lsize);
        break;
      }
      endShape(CLOSE);
      popStyle();
      popMatrix();
    }
  }
  popMatrix();
}



/*leva l1 para l2 */
void transposeRow(int bits[], int r0, int r1) {
  int temp[] = new int[4];

  for (int x=0;x<4;x++) {
    //keep the values from row r0 on temp
    int i = x + r0*4;
    temp[x] = bits[i];

    // put on row r0 values from row r1
    int i2 = x + r1*4;
    bits[i] = bits[i2];
    //put on row r1 values from r0 i.e. from temp
    bits[i2] = temp[x];
  }
}

void transposeColumn(int bits[], int c0, int c1) {
  int temp[] = new int[4];

  for (int y=0;y<4;y++) {
    //keep the values from column c1 on temp
    int i = c0 + y*4;
    temp[y] = bits[i];

    //put on column c0 values from column c1
    int i2 = c1 + y*4;
    bits[i] = bits[i2];

    //put on column c1 values from column c0 i.e. temp
    bits[i2] = temp[y];
  }
}

void transposeQuadrant(int bits[], int q0, int q1) {
  int temp[] = new int[4];

  //given a q0 - quadrant 0,1,2,3 
  // |0|1|
  // |2|3|
  //returns x,y initial coordinates 
  // |00|10|20|30|
  // |01|11|21|31|
  // |02|12|22|32|
  // |03|13|23|33| 

  int x0q0 = (q0%2)*2;
  int y0q0;
  if (q0>1) {
    y0q0 =2;
  }
  else {
    y0q0 =0;
  }

  int x0q1 = (q1%2)*2;
  int y0q1;
  if (q1>1) {
    y0q1 =2;
  }
  else {
    y0q1 =0;
  }

  int c=0; 
  for (int i=0;i<2;i++) {
    for (int j=0;j<2;j++) {
      temp[c] = bits[x0q0+i + (y0q0+j)*4];
      bits[x0q0+i + (y0q0+j)*4] = bits[x0q1+i + (y0q1+j)*4];
      bits[x0q1+i + (y0q1+j)*4] = temp[c];
      c++;
    }
  }
}



void randss() {
  transposeRow(bits, (int)random(0, 4), (int)random(0, 4));
  transposeColumn(bits, (int)random(0, 4), (int)random(0, 4));
  transposeQuadrant(bits, (int)random(0, 4), (int)random(0, 4));
}

void mousePressed() {
  randss();
  redraw();
}
