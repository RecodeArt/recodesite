---
title: "Square Towers"
translator: "Nick Santaniello"
translator_url: "http://www.robysoft.net/"
slug: "nick-santaniello-direct-untitled-1-various"
artwork_slug: "v1n4-untitled-1"
category: "direct"
description: "See also Vol. 2 No. 3 (image 10, pages 14-15) for more, including code. Input to computer on punch cards"
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 1" by Various (Reiner Schneeberger and unnamed students)
Originally published in "Computer Graphics and Art" vol1 no4 pg 28
Copyright (c) 2012 Nick Santaniello - OSI/MIT license (http://recodeproject/license).
*/

let cols = 11;
let rows = 10;
let offsetX;
let offsetY;
let sqSize = 100;
let sizeDifference = 17;

function setup() {
  createCanvas(1000, 1000);
  offsetX = random(-6, 6);
  offsetY = random(-6, 6);
  rectMode(CENTER);
  strokeWeight(2);
  fill(240);

  // for every row...
  for (let r = 0; r < rows; r++) {
    // for every column...
    for (let c = 0; c < cols; c++) {
      // choose a new offset
      offsetX = random(-7, 7);
      offsetY = random(-7, 7);
      rect(c * sqSize, r * sqSize, sqSize, sqSize);
      for (let i = 1; i < 6; i++) {
        rect((c * sqSize) + (i * offsetX), (r * sqSize) + (i * offsetY), sqSize - (i * sizeDifference), sqSize - (i * sizeDifference));
      }
    }
  }

  noLoop();
}

function draw() {
}
</script>
