---
title: "Gaussian Distribution"
translator: "Josh Giesbrecht"
translator_url: "http://www.thoughtlost.org/wp/"
slug: "josh-giesbrecht-gaussian-distribution-direct-gaussian-distribution-kerry-jones"
artwork_slug: "v2n2-gaussian-distribution"
category: "direct"
description: ""
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Gaussian Distribution" by Kerry Jones
Originally published in "Computer Graphics and Art" v2n2, 1977
Copyright (c) 2013 Josh Giesbrecht - OSI/MIT license (http://recodeproject/license).
*/

// coded by Josh Giesbrecht

color fg = color(0);
color bg = color(255);

void setup() {
  size(400,400);
  smooth();
  background(bg);
  
  update();
}

void draw(){
  
}

void update() {
  background(255);
  //fill(0,20);
  //rect(0,0,400,400);
  
  for (int i=0;  i<7000; i++)  {
    int x = (int)random(0,width);
    int y = floor((int)(myGaussian() * height*0.18)) + height*4/9;
    //int y = (int)random(0,400);
    //int y = (int)(rnd.nextGaussian() * 10) + 200;
    noStroke();
    fill(fg);
    ellipse(x, y, 4, 4);
  }
}

void mousePressed() {
  update();
}

// ported from http://www.colingodsey.com/javascript-gaussian-random-number-generator/
float myGaussian() {
  float x1, x2, rad;
 
  do {
    x1 = 2 * random(1) - 1;
    x2 = 2 * random(1) - 1;
    rad = x1 * x1 + x2 * x2;
  } while(rad >= 1 || rad == 0);
 
  float c = sqrt(-2 * (float)Math.log(rad) / rad);
 
  return x1 * c;
};
