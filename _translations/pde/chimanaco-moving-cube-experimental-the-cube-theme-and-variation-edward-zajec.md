---
title: "Moving Cube"
translator: "chimanaco"
translator_url: "http://chimana.co/sketch/"
slug: "chimanaco-moving-cube-experimental-the-cube-theme-and-variation-edward-zajec"
artwork_slug: "v1n2-the-cube-theme-and-variation"
category: "experimental"
description: ""
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "The Cube Theme and Variation" by Edward Zajec
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2013 chimanaco - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

//---------
// GLOBALS
//---------

color bgColor = color(0);
color drawColor = color(255, 255, 255);

int strokeW = 3;
int loopNum = 20;
float objetOffsetX = -2;
float objetOffsetY = 2;

int bgOffset = 12;
int bottomW = 560;
int bottomH = 20;
int bottomX = 32;
int bottomY = 278;

int baseX = 250;
int baseY = 15;
int baseX1 = 20;
int baseY1 = 40;
int baseX2 = 90;
int baseY2 = 80;

int marginY = 100;
int firstLY = 100;
int firstMLY = 65;

int speed = 2;
int angle = 0;



//---------
// SETUP
//---------

void setup() {
  // Screen
  size(400, 400);
  smooth();
}

//---------
// DRAW
//---------

void draw() {
  float s = sin(radians(angle));
  float m = map(s, -1, 1, -10, 10);
  float c = map(s, -1, 1, 0, 255);

  // Background
  background(bgColor);

  // update Postion
  objetOffsetX = m;
  objetOffsetY = -m;

  strokeWeight(strokeW);
  stroke(drawColor);

  // drawBG line
  for (int i = 0; i < width; i++) {
    line(i * bgOffset, 0, 0, i * bgOffset);
  }

  fill(bgColor);

  int marginX = baseX1 + baseX2;

  // drawbottom
  drawRect();

  // first left & third top
  drawMultiL(baseX - marginX * 2, baseY + marginY, baseX1, baseY1,
baseX2, baseY2);

  // third right & second top
  drawL(baseX - marginX, baseY - firstLY, baseX1, baseY1 + firstLY,
baseX2, baseY2 + firstLY);

  // base -> second right & second top
  drawL(baseX, baseY, baseX1, baseY1, baseX2, baseY2);

  // first right & second top
  drawL(baseX + marginX, baseY, baseX1, baseY1, baseX2, baseY2);

  // second right & first top
  drawL(baseX, baseY - marginY, baseX2, baseY1, baseX2, baseY2);

  // first right & first top
  drawL(baseX + marginX, baseY - marginY, baseX2, baseY1, baseX2, baseY2);

  angle += speed;
}

/*
  drawRect
 */
void drawRect() {
  pushMatrix();
  translate(bottomX, bottomY);

  for (int i = 0; i < loopNum; i++) {
    float posX = i * objetOffsetX;
    float posY = i * objetOffsetY;

    stroke(drawColor);
    rect(posX, posY, bottomW, bottomH);

    if (i % 2 == 0) {
      stroke(bgColor);
      line(posX, posY, posX + bottomW, posY);
    }
  }
  popMatrix();
}

/*
  draw L
 */
void drawL(int posX, int posY, int x1, int y1, int x2, int y2) {
  for (int i = 0; i < loopNum; i++) {
    pushMatrix();
    translate(posX + i * objetOffsetX, posY + i * objetOffsetY);

    beginShape();
    stroke(drawColor);
    vertex(0, 0);
    vertex(x1, 0);
    vertex(x1, y1);
    vertex(x2, y1);
    vertex(x2, y2);
    vertex(0, y2);
    endShape(CLOSE);

    if (i % 2 == 0) {
      stroke(bgColor);
      line(0, 0, x1, 0);
      line(x1, y1, x2, y1);
    }

    popMatrix();
  }
}

/*
  draw L
 */
void drawMultiL(int posX, int posY, int x1, int y1, int x2, int y2) {
  for (int i = 0; i < loopNum; i++) {
    pushMatrix();
    translate(posX + i * objetOffsetX, posY + i * objetOffsetY);

    beginShape();
    stroke(drawColor);

    for (int j = 0; j < 4; j++) {
      if (j==0) {
        vertex(0, -firstMLY);
        vertex(x1, -firstMLY);
      }
      else {
        vertex(x2 * j + x1 * j, 0);
        vertex(x2 * j + x1 * (j + 1), 0);
      }
      vertex(x2 * j + x1 * (j + 1), y1);
      vertex(x2 * (j + 1) + x1 * (j + 1), y1);
    }

    vertex(x2 * 4 + x1 * 4, y2);
    vertex(0, y2);

    endShape(CLOSE);

    if (i % 2 == 0) {
      stroke(bgColor);

      for (int j = 0; j < 4; j++) {
        if (j==0) {
          line(0, -firstMLY, x1, -firstMLY);
        }
        else {
          line(x2 * j + x1 * j, 0, x2 * j + x1  * (j + 1), 0);
        }
        line(x2 * j + x1 * (j + 1), y1, x2 * (j + 1) + x1 * (j + 1), y1);
      }
    }

    popMatrix();
  }
}
