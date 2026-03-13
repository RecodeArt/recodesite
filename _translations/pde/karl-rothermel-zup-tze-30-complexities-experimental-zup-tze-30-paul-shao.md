---
title: "Zup Tze 30 Complexities"
translator: "Karl Rothermel"
translator_url: ""
slug: "karl-rothermel-zup-tze-30-complexities-experimental-zup-tze-30-paul-shao"
artwork_slug: "v3n2-zup-tze-30"
category: "experimental"
description: ""
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Zup Tze 30" by Paul Shao
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2013 Karl Rothermel - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

static final int LINE_WIDTH = 1; 

void setup() {
  size(512,360); 
}

// Draws a single cross.
void drawCross(int left, int top, int dim, int thickness) {
  int offset_1 = dim/2 - thickness/4;
  int offset_2 = offset_1 + thickness;
  int offset_3 = dim;
  beginShape();
  vertex(left + offset_1, top);
  vertex(left + offset_2, top);
  vertex(left + offset_2, top + offset_1);
  vertex(left + offset_3, top + offset_1);
  vertex(left + offset_3, top + offset_2);
  vertex(left + offset_2, top + offset_2);
  vertex(left + offset_2, top + offset_3);
  vertex(left + offset_1, top + offset_3);
  vertex(left + offset_1, top + offset_2);
  vertex(left,            top + offset_2);
  vertex(left,            top + offset_1);
  vertex(left + offset_1, top + offset_1);
  vertex(left + offset_1, top);
  endShape(CLOSE);
}

// Draw a stack of crosses.
void drawCrossWithDecay(int left, int top, int base_dim, int num_decay,
                        PVector dpos, int ddim, double dthickness) {
  double thickness = base_dim/2;
  int dim = base_dim;
  int curleft = left;
  int curtop = top;
  for (int i = 0; i < num_decay; i++) {
    drawCross(curleft, curtop, dim, (int)thickness);
    curleft += dpos.x + ddim/2;
    curtop += dpos.y + ddim/2;
    dim -= ddim;
    thickness -= dthickness;
  }
}

void drawCrossMatrix(int dim, int left, int top, int rows, int cols) {
  int thickness = dim/2;
  PVector dp1 = new PVector(0,-1);
  PVector dp2 = new PVector(1,0);
  PVector dp;
  for (int i = 0; i < rows; i++) {
    int rleft = left + i * thickness;
    int rtop = top + i * 1 * thickness;
    for (int j = 0; j < cols; j++) {
      dp = i%2==0?dp1:dp2;
      dp.mult(-1);
      drawCrossWithDecay(rleft + thickness * 2 *j, rtop - thickness * j, dim, 8, dp, 4, 4.5);
    } 
  }
}

void draw() {
  background(0xffffff);
  drawCrossMatrix(49, 60, 150, 6, 6);
}
