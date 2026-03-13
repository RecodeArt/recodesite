---
title: "Untitled 6"
translator: "Corneel Cannaerts"
translator_url: "http://introspector.be/"
slug: "corneel-cannaerts-untitled-6-direct-untitled-6-hans-korneder"
artwork_slug: "v3n2-untitled-6-Korneder"
category: "direct"
description: "//made during Processing Ghent Recode Workshop //Corneel Cannaerts @introspect0r"
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 6" by Hans Korneder
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2013 Corneel Cannaerts - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

//made during Processing Ghent Recode Workshop 
//Corneel Cannaerts  @introspect0r 

int pad;
int numX;
int numY;
int stepX;
int stepY;
float gridOffSet;
float cenOffSet;
ArrayList<Polygon> polygons;

void setup() {
  size(740, 480);
  pad = 80;
  stepX = 80;
  stepY = 80;
  numX = 8;
  numY = 5;
  gridOffSet = 20;
  cenOffSet = 40;
  initPolygons();
}

void draw() {
  background(255);
  stroke(0);
  strokeWeight(2);
  noFill();
  for (Polygon p:polygons) {
    p.render();
  }
  noLoop();
}

//initialize the polygons
void initPolygons() {
  PVector[][] grid = new PVector[8][6]; 
  polygons =  new ArrayList();
  //make a distorted grid
  for (int i=0; i<numX; i++) {
    for (int j=0; j<numY; j++) {    
      grid[i][j] = new PVector(pad+random(-gridOffSet, gridOffSet)+stepX*i, pad+random(-gridOffSet, gridOffSet)+stepY*j);
    }
  }
  //initialize the polygons and add to arraylist
  for (int i=0; i<numX-1; i++) {
    for (int j=0; j<numY-1; j++) {    
      Polygon temp = new Polygon(grid[i][j], grid[i+1][j], grid[i+1][j+1], grid[i][j+1]);
      polygons.add(temp);
    }
  }
}

void mousePressed() {
  initPolygons();
  loop();
}

//simple polygon class
//stores coordinates and center
//renders offset 
class Polygon {
  PVector a, b, c, d, cen;
  Polygon(PVector a, PVector b, PVector c, PVector d) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;

    //add all coordinates adn divide by 4
    cen = a.get();
    cen.add(b);
    cen.add(c);
    cen.add(d);
    cen.mult(0.25);

    //some centers offset downwards
    if (random(1)<0.5) {
      cen.add(new PVector(random(-cenOffSet, cenOffSet), random(0, cenOffSet)));
    }
  }

  //draw ploygons
  //we interpolate between coordinates and the center using lerp
  void render() {
    for (float i=0; i<1; i+=0.1) {
      beginShape();
      vertex(lerp(a.x, cen.x, i), lerp(a.y, cen.y, i));
      vertex(lerp(b.x, cen.x, i), lerp(b.y, cen.y, i));
      vertex(lerp(c.x, cen.x, i), lerp(c.y, cen.y, i));
      vertex(lerp(d.x, cen.x, i), lerp(d.y, cen.y, i));
      endShape(CLOSE);
      println(i);
    }
    point(cen.x, cen.y);
  }
}
