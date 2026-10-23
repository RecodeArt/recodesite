---
title: "tb2va00"
translator: "thomas neveling"
translator_url: ""
slug: "thomas-neveling-tb2va00-experimental-untitled-1-various"
artwork_slug: "v1n4-untitled-1"
category: "experimental"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 1" by Various
Originally published in "Computer Graphics and Art" v1n4, 1976
Copyright (c) 2013 thomas neveling - OSI/MIT license (http://recodeproject/license).
*/

let w = 1000;
let sqSize = 333;
let cols = Math.floor(w / sqSize);
let rows = Math.floor(w / sqSize);
let offsetX;
let offsetY;
let sizeDifference = 1;

function setup() {
  createCanvas(1000, 1000);
  offsetX = 3;
  offsetY = 3;
  strokeWeight(1);
  fill(0);

  // For every row...
  for (let r = 0; r < rows; r++) {
    // For every column...
    for (let c = 0; c < cols; c++) {
      // Choose a new offset
      offsetX = random(-3, 3);
      offsetY = random(-3, 3);
      rect(c * sqSize, r * sqSize, sqSize, sqSize);

      for (let i = 1; i < (sqSize / sizeDifference); i++) {
        strokeWeight(random(0.5));
        rect((c * sqSize) + (i * offsetX), (r * sqSize) + (i * offsetY),
             sqSize - (i * sizeDifference), sqSize - (i * sizeDifference));
      }
      fill(random(0, 255), random(0, 255), random(0, 255), random(0, 10));
    }
  }
}

function draw() {
}
</script>
