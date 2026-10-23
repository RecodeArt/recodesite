---
title: "Hannover Fair Pyramids"
translator: "Thomas Crevoisier"
translator_url: ""
slug: "thomas-crevoisier-hannover-fair-pyramids-experimental-untitled-georg-nees"
artwork_slug: "v1n2-untitled12"
category: "experimental"
description: "An interpretation of this by using a recursive algorithm."
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by Georg Nees
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2013 Thomas Crevoisier - OSI/MIT license (http://recodeproject/license).
*/

function setup() {
  createCanvas(800, 800, WEBGL);
  stroke(255);
  noFill();
}

function draw() {
  background(0);

  push();
  translate(-width / 2 + width / 2, -height / 2 + 10, 0);
  branch(10, 60);
  pop();
}

function drawPyramid(xS, yS, zS, h) {
  // Calculate coordinate of the other points of the pyramid, having the height h of this pyramid and coordinates of the highest point
  let x1 = xS;
  let y1 = yS + h;
  let z1 = zS + h / Math.sqrt(2);

  let x2 = xS + h * Math.sqrt(6) / 4;
  let y2 = yS + h;
  let z2 = zS - h * Math.sqrt(2) / 4;

  let x3 = xS - h * Math.sqrt(6) / 4;
  let y3 = yS + h;
  let z3 = zS - h * Math.sqrt(2) / 4;

  // Draw the four faces of the pyramids
  beginShape();
  vertex(xS, yS, zS);
  vertex(x1, y1, z1);
  vertex(x2, y2, z2);
  endShape(CLOSE);

  beginShape();
  vertex(xS, yS, zS);
  vertex(x2, y2, z2);
  vertex(x3, y3, z3);
  endShape(CLOSE);

  beginShape();
  vertex(xS, yS, zS);
  vertex(x3, y3, z3);
  vertex(x1, y1, z1);
  endShape(CLOSE);

  beginShape();
  vertex(x1, y1, z1);
  vertex(x2, y2, z2);
  vertex(x3, y3, z3);
  endShape(CLOSE);
}

function branch(N, h) {
  N -= 1;

  if (N > 0) {
    // Calculate the next three points which are the other points of the pyramids
    let x1 = 0;
    let y1 = h;
    let z1 = h / Math.sqrt(2);

    let x2 = h * Math.sqrt(6) / 4;
    let y2 = h;
    let z2 = -h * Math.sqrt(2) / 4;

    let x3 = -h * Math.sqrt(6) / 4;
    let y3 = h;
    let z3 = -h * Math.sqrt(2) / 4;

    // Use the recursive function to draw a pyramid for the three points for which we calculate coordinates
    push();
    drawPyramid(0, 0, 0, h);
    translate(x1, y1, z1);
    branch(N, h);
    pop();

    push();
    drawPyramid(0, 0, 0, h);
    translate(x2, y2, z2);
    branch(N, h);
    pop();

    push();
    drawPyramid(0, 0, 0, h);
    translate(x3, y3, z3);
    branch(N, h);
    pop();
  }
}
</script>
