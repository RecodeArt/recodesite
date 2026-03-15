---
title: "Segrid"
translator: "Quin Kennedy"
translator_url: "http://kamikazepirate.com/"
slug: "quinn-direct-segrid-john-roy"
artwork_slug: "v2n3-segrid"
category: "direct"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Segrid" by John Roy
Originally published in "Computer Graphics and Art" vol2 no3, 1977
Copyright (c) 2012 Quin Kennedy - OSI/MIT license (http://recodeproject/license).
*/

// Since there are 8 sets of images plus a center empty image plus a 1/2 width of black border
// this gives a canvas size of 8*2+1+.5*2 = 9*2 = 18 cells
// each cell is 20 pixels wide (see comment in drawTile(...))
const pixelSize = 1.5;
const linesPerQuadrant = 5;
// The tile size is the (lines per quadrant + spaces per quadrant) * 2 quadrants per side * pixelSize
const tileSize = linesPerQuadrant * 2 * 2;
const visualTileSize = tileSize * pixelSize;
// Subtract 1 because the center is not doubled
// Subtract another 1 because we only see half of the last tiles
const numTiles = linesPerQuadrant * 4 - 1 - 1;
const windowSize = numTiles * tileSize;
const visualWinSize = numTiles * visualTileSize;

function setup() {
  createCanvas(Math.ceil(visualWinSize), Math.ceil(visualWinSize));
  noLoop();
}

function draw() {
  background(255);
  stroke(0);
  fill(0);
  strokeWeight(1);
  strokeCap(PROJECT);

  push();
  scale(pixelSize);

  // Pick a random grid cell to be the focal point
  // For now we will restrict it to have at most one row/column of empty squares
  let focusX = Math.floor(numTiles / 2);
  let focusY = Math.floor(numTiles / 2);

  // For each grid cell...
  for (let i = 0, gi = 0; i <= numTiles; i++, gi += tileSize) {
    for (let j = 0, gj = 0; j <= numTiles; j++, gj += tileSize) {
      push();
      translate(gi, gj);
      let num = Math.min(Math.max(Math.abs(focusX - i), Math.abs(focusY - j)), linesPerQuadrant * 2);
      drawTile(num);
      pop();
    }
  }
  pop();
}

function drawTile(iteration) {
  // There are two versions of the tile, the first where 5 lines (with 5 spaces) grow in,
  // and the second where each consecutive space gets filled in.
  if (iteration === 0) {
    return;
  }

  push();
  for (let i = 0; i < 4; i++) {
    push();
    translate(-linesPerQuadrant * 2, -linesPerQuadrant * 2);
    drawQuadrant(iteration);
    pop();
    rotate(HALF_PI);
  }
  pop();
}

function drawQuadrant(iteration) {
  if (iteration < linesPerQuadrant) {
    push();
    for (let i = 0; i < linesPerQuadrant; i++) {
      line(0, 0.5, iteration * linesPerQuadrant * 2 / (linesPerQuadrant - 1), 0.5);
      translate(0, 2);
    }
    pop();
  } else {
    drawQuadrant(linesPerQuadrant - 1);
    let lines = iteration - linesPerQuadrant;
    push();
    translate(0, linesPerQuadrant * 2 - 1);
    for (let i = 0; i <= lines; i++) {
      line(0, 0.5, linesPerQuadrant * 2, 0.5);
      translate(0, -2);
    }
    pop();
  }
}
</script>
