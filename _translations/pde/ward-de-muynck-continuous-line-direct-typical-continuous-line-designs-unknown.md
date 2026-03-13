---
title: "Continuous line"
translator: "Ward De Muynck"
translator_url: "http://www.liquid-media.com/"
slug: "ward-de-muynck-continuous-line-direct-typical-continuous-line-designs-unknown"
artwork_slug: "v2n3-typical-continuous-line-designs"
category: "direct"
description: "A continuous line"
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Typical Continuous Line Designs" by Unknown
Originally published in "Computer Graphics and Art" v2n3, 1977
Copyright (c) 2013 Ward De Muynck - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

int startX = 100;
int startY = 100;
int endX = 200;
int endY = 200;

int firstX = startX;
int firstY = startX;

int totalLines =  9;

void setup() {
  size(400, 400);
  noLoop();
}

void draw() {
  background(255);

  for (int x=0; x< totalLines;x++) {
    strokeWeight(2);
    //stroke(255, 0, 0);
    strokeJoin(ROUND);
    startX = endX;
    startY = endY;
    //stay 10px from the border
    endX = int(random(10, width-10));
    endY = int(random(10, height-10));

    liner(endX, endY, startX, startY);
    //add arrow to first line
    if (x<1) {
      arrow(firstX, firstY,startX, startY);
    }
    if (x>totalLines-2) {
      stroke(27);
      liner(endX, endY, firstX, firstY);
    }
  }
}


void liner(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  popMatrix();
} 

void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
}
