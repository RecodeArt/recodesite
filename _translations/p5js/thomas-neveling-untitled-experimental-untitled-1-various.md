---
title: "Untitled"
translator: "Thomas Neveling"
translator_url: ""
slug: "thomas-neveling-untitled-experimental-untitled-1-various"
artwork_slug: "v1n4-untitled-1"
category: "experimental"
description: "Minor changes of the values sizeDifference, offset, iteration, depth of i. New: random width of rect frame."
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 1" by Various
Originally published in "Computer Graphics and Art" v1n4, 1976
Copyright (c) 2013 Thomas Neveling - OSI/MIT license (http://recodeproject/license).
*/

let cols = 10;
let rows = 10;
let offsetX;
let offsetY;
let sqSize = 100;
let sizeDifference = 5;

function setup() {
  createCanvas(1000, 1000);
  offsetX = 3;
  offsetY = 3;
  rectMode(CENTER);
  strokeWeight(1);
  fill(255);

  // for every row...
  for (let r = 1; r < rows; r++) {
    // for every column...
    for (let c = 1; c < cols; c++) {
      // choose a new offset
      offsetX = random(-3, 3);
      offsetY = random(-3, 3);
      rect(c * sqSize, r * sqSize, sqSize, sqSize);
      for (let i = 1; i < 150; i++) {
        strokeWeight(random(1, 5));
        rect((c * sqSize) + (i * offsetX), (r * sqSize) + (i * offsetY),
             sqSize - (i * sizeDifference), sqSize - (i * sizeDifference));
      }
    }
  }
}

function draw() {
}
</script>
