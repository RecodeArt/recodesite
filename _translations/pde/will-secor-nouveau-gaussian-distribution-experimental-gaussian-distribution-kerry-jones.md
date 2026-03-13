---
title: "Nouveau Gaussian Distribution"
translator: "Will Secor"
translator_url: "http://www.williamsecor.com/"
slug: "will-secor-nouveau-gaussian-distribution-experimental-gaussian-distribution-kerry-jones"
artwork_slug: "v2n2-gaussian-distribution"
category: "experimental"
description: "Smooth rendering, larger ellipses, transparency, and color as a function of ellipse distance from center. Click to redraw."
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Gaussian Distribution" by Kerry Jones
Originally published in "Computer Graphics and Art" v2n2, 1977
Copyright (c) 2013 Will Secor - OSI/MIT license (http://recodeproject/license).
*/


// Changes: smooth() added, larger ellipses, transparency, 
// color as a function of distance from center.

int w = 760;
int h = 330;

void setup() {
  smooth();
  size(w,h);
  noLoop();
}

void draw() {
  background(255,255,255);
  fill(0,0,0);
  pushMatrix();
  translate(0,h/2);
  boxmuller();
  translate(w/4,0);
  boxmuller();
  translate(w/4,0);
  boxmuller();
  translate(w/4,0);
  boxmuller();
  translate(w/4,0);
  boxmuller();
  popMatrix();
}

// Box-Muller transform!  This still seems like magic to me.

void boxmuller() {
  for (int j = 0; j < 5500; j++) {
    float u1 = random(0,1);
    float u2 = random(0,1);
    float z0 = sqrt(-2*log(u1))*cos(2*PI*u2);
    float z1 = sqrt(-2*log(u1))*sin(2*PI*u2);
    float temp = (((sqrt((z0*z0)+(z1*z1)))/PI)*100);
    stroke(temp,temp,temp,50);
    fill(temp,temp,temp,50);
    ellipse(z0*w/(1.8*PI),z1*h/(1.8*PI),4,4);
  }
}

void mousePressed(){
  redraw();
}
