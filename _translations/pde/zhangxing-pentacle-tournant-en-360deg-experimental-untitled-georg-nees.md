---
title: "pentacle tournant en 360°"
translator: "zhangxing"
translator_url: ""
slug: "zhangxing-pentacle-tournant-en-360deg-experimental-untitled-georg-nees"
artwork_slug: "v1n2-untitled18"
category: "experimental"
description: "Après untitled de George nees, le rond est créé par les lignes. Cela me fait penser au concept du Kandinsky, le rond est un carré qui tourne sans fini. Donc j'ai crée plusieurs pentacles qui tournent pour avoir les différents ronds, enfin obtenir un dessin graphique"
runs_in_browser: false
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by Georg Nees
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2015 zhangxing - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

int num = 2;
int step = 10;
float centx, centy;
Particle[] pArr;



void setup() {
  size(500, 500);
  frameRate(12);
  clearBackground();
  smooth();
  
  centx = width/2;
  centy = height/2;
  
  pArr = new Particle[num];
  for (int i=0;i<num;i++) {
    pArr[i] = new Particle(i);
  }
}

void clearBackground() {
  background(255);
  // graph paper
  int gap = 10;
  strokeWeight(1);
  stroke(140, 40);
  for (int x=0;x<width;x+=gap) {
     line(x, 0, x, height);
  }
  for (int y=0;y<height;y+=gap) {
    line(0, y, width, y);
  } 
}



void draw() {
  // clearBackground();
  for (int i=0;i<num;i++) {
    pArr[i].update();
  }
}



class Particle {
  int id;
  int count, life, step;
  float origx, origy;
  float x1, y1, x2, y2;
  int rd, gr, bl, alph;
  float angle, radius;
  
  Particle (int num) {
    id = num;
    init();
  }
  
  void trace(String str) {
    // println("Particle " + id + ": " + str);
  }
  
  void init() {
    trace("init");
    count = 0;
    step = 10;
    life = 720;
    radius = random(width * 2) + 50;
    
    origx = centx + (radius * cos(angle));
    origy = centy + (radius * sin(angle));
    x1 = origx;
    y1 = origy;
    
    rd = int(random(255));
    // gr = int(random(255));
    // bl = int(random(255));
    bl = gr = rd;  // grey
  }
  
  void update() {
    count += step;
    angle = count; 
    // project x2,y2 from x1,y1, and draw a line to it
    x2 = centx + (radius * cos(angle));
    y2 = centy + (radius * sin(angle));
    // draw line to it
    strokeWeight(1);
    stroke(rd, gr, bl);
    line(x1, y1, x2, y2);
    // reset for next update
    x1 = x2; y1 = y2; 
    // if (x1 > width) { x1 = 0; }
    // if (y1 > height) { y1 = 0; }
    // expiration  
    if (count >= life) { init(); }
  }
  
}
