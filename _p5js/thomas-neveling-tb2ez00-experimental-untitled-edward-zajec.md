---
title: "tb2ez00"
translator: "Thomas Neveling"
translator_url: ""
slug: "thomas-neveling-tb2ez00-experimental-untitled-edward-zajec"
artwork_slug: "v2n4-untitled-zajec"
category: "experimental"
description: "The changes of this base algorithm from Edward Zajec brings color to the results and looks a little bit human made. Intense changes of the figure-functions, now the objects are placed by random numbers. The alpha value is now changed during painting."
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by Edward Zajec
Originally published in "Computer Graphics and Art" v2n4, 1977
Copyright (c) 2013 Thomas Neveling - OSI/MIT license (http://recodeproject/license).

The changes of this base algorithm from Edward Zajec brings color to the results
and looks a little bit human made.
Intense changes of the figure-functions, now the objects are placed by random numbers.
The alpha value is now changed during painting.
*/

let w = 1000;
let h = 1000;
let maxf ;
let minW = 100;
let maxW = w;
let c = 0;
let alpha = 0;

function setup() {
  createCanvas(w, h);
  noStroke();
  background(0);
  ellipseMode(CENTER);
  rectMode(CENTER);
  maxf = Math.floor(random(1, 30));
}

/*
Each one of the figures in this piece is drawn by a separate function,
that way we could customize their behavior in the future.
Each one of the figures were previously studied to be the more accurate possible
to the original piece.
At the beginning of each one of the functions are defined the different values
used to create the figures.
*/

function draw() {
  while (c < maxf) {
    alpha = random(10);
    drawEllipse(random(0, w), random(0, h));
    drawRectangle(random(0, w), random(0, h));
    drawTriangle(random(0, w), random(0, h));
    c = c + 1;
  }
}

function drawEllipse(positionX, positionY) {
  let diameterMax = random(minW, maxW);
  let diameterMin = minW;
  let step = random(2, minW / 2);
  let r = random(50, 100);
  let g = random(50, 100);
  let b = random(50, 100);

  for (let d = diameterMin; d < diameterMax; d = d + step) {
    stroke(1, random(150));
    strokeWeight(random(5));
    fill(r, g, b, alpha);
    ellipse(positionX, positionY, d, d);
  }
}

function drawRectangle(positionX, positionY) {
  let diameterMax = random(minW, maxW);
  let diameterMin = minW;
  let step = random(2, minW / 2);
  let r = random(150, 205);
  let g = random(150, 205);
  let b = random(150, 205);

  push();
  translate(positionX, positionY);
  rotate(random(1));

  for (let d = diameterMin; d < diameterMax; d = d + step) {
    stroke(1, random(150));
    strokeWeight(random(5));
    fill(r, g, b, alpha);
    if (d + step < diameterMax) {
      rect(0, 0, d, d, 3);
    } else {
      rect(0, 0, d, d);
    }
  }
  pop();
}

function drawTriangle(positionX, positionY) {
  let diameterMax = random(minW, maxW);
  let diameterMin = minW;
  let step = random(1, 5);
  let r = random(200, 255);
  let g = random(200, 255);
  let b = random(200, 255);

  let x1 = positionX;
  let y1 = positionY;
  let x2 = x1 + 50;
  let y2 = y1 + random(100);
  let x3 = x2 - random(250);
  let y3 = y1 + random(250);
  let maxTriangles = random(5, maxW / 2);

  for (let i = 0; i < maxTriangles; i = i + step) {
    stroke(1, random(150));
    strokeWeight(random(5));
    fill(r, g, b, alpha);
    triangle(x1 + i, y1, x2 - i / 2, y2 - i, x3 - i / 2, y3 + i);
  }
}
</script>
