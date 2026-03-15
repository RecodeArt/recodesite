---
title: "Untitled 6"
translator: "Corneel Cannaerts"
translator_url: "http://introspector.be/"
slug: "corneel-cannaerts-untitled-6-direct-untitled-6-hans-korneder"
artwork_slug: "v3n2-untitled-6-korneder"
category: "direct"
description: "//made during Processing Ghent Recode Workshop //Corneel Cannaerts @introspect0r"
runs_in_browser: true
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 6" by Hans Korneder
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2013 Corneel Cannaerts - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

//made during Processing Ghent Recode Workshop
//Corneel Cannaerts  @introspect0r

let pad;
let numX;
let numY;
let stepX;
let stepY;
let gridOffSet;
let cenOffSet;
let polygons;

function setup() {
  createCanvas(740, 480);
  pad = 80;
  stepX = 80;
  stepY = 80;
  numX = 8;
  numY = 5;
  gridOffSet = 20;
  cenOffSet = 40;
  initPolygons();
}

function draw() {
  background(255);
  stroke(0);
  strokeWeight(2);
  noFill();
  for (let p of polygons) {
    p.render();
  }
  noLoop();
}

//initialize the polygons
function initPolygons() {
  let grid = [];
  polygons = [];
  //make a distorted grid
  for (let i = 0; i < numX; i++) {
    grid[i] = [];
    for (let j = 0; j < numY; j++) {
      grid[i][j] = createVector(pad + random(-gridOffSet, gridOffSet) + stepX * i, pad + random(-gridOffSet, gridOffSet) + stepY * j);
    }
  }
  //initialize the polygons and add to arraylist
  for (let i = 0; i < numX - 1; i++) {
    for (let j = 0; j < numY - 1; j++) {
      let temp = new Polygon(grid[i][j], grid[i+1][j], grid[i+1][j+1], grid[i][j+1]);
      polygons.push(temp);
    }
  }
}

function mousePressed() {
  initPolygons();
  loop();
}

//simple polygon class
//stores coordinates and center
//renders offset
class Polygon {
  constructor(a, b, c, d) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;

    //add all coordinates and divide by 4
    this.cen = a.copy();
    this.cen.add(b);
    this.cen.add(c);
    this.cen.add(d);
    this.cen.mult(0.25);

    //some centers offset downwards
    if (random(1) < 0.5) {
      this.cen.add(createVector(random(-cenOffSet, cenOffSet), random(0, cenOffSet)));
    }
  }

  //draw polygons
  //we interpolate between coordinates and the center using lerp
  render() {
    for (let i = 0; i < 1; i += 0.1) {
      beginShape();
      vertex(lerp(this.a.x, this.cen.x, i), lerp(this.a.y, this.cen.y, i));
      vertex(lerp(this.b.x, this.cen.x, i), lerp(this.b.y, this.cen.y, i));
      vertex(lerp(this.c.x, this.cen.x, i), lerp(this.c.y, this.cen.y, i));
      vertex(lerp(this.d.x, this.cen.x, i), lerp(this.d.y, this.cen.y, i));
      endShape(CLOSE);
      console.log(i);
    }
    point(this.cen.x, this.cen.y);
  }
}
</script>
