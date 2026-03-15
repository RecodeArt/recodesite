---
title: "Untitled 4 RGB"
translator: "Corneel Cannaerts"
translator_url: "http://introspector.be/"
slug: "corneel-cannaerts-untitled-4-rgb-experimental-untitled-4-various"
artwork_slug: "v1n4-untitled-4"
category: "experimental"
description: "RGB Remix"
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 4" by Various
Originally published in "Computer Graphics and Art" v1n4, 1976
Copyright (c) 2013 Corneel Cannaerts - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

let pad, stepX, stepY, numX, numY;
let hatch;
let rgb;

function setup() {
  createCanvas(820, 1200);
  pad = 10;
  stepX = 80;
  stepY = 40;
  numX = (width - 2 * pad) / stepX;
  numY = (height - 2 * pad) / stepY;
  hatch = 7.0;
  strokeWeight(1.5);
  rgb = [];
  rgb[0] = color(255, 0, 0);
  rgb[1] = color(0, 255, 0);
  rgb[2] = color(0, 0, 255);
}

function draw() {
  background(0);
  for (let i = 0; i < numX; i++) {
    for (let j = 0; j < numY; j++) {
      push();
      translate(i * stepX + pad, j * stepY + pad);
      for (let k = 0; k < 3; k++) {
        stroke(rgb[k]);
        hatch = random(0, 20);
        if (random(1) < 0.5) vertical();
        else horizontal();
      }
      pop();
    }
  }
  noLoop();
}

function vertical() {
  for (let i = 0; i < hatch; i++) {
    line(i * stepX / hatch, 0, i * stepX / hatch, stepY);
  }
}

function horizontal() {
  for (let i = 1; i < hatch + 1; i++) {
    line(0, i * stepY / hatch, stepX, i * stepY / hatch);
  }
}

function mouseClicked() {
  loop();
}
</script>
