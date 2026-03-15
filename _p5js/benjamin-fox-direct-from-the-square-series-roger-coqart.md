---
title: "From the Square Series"
translator: "Benjamin Fox"
translator_url: ""
slug: "benjamin-fox-direct-from-the-square-series-roger-coqart"
artwork_slug: "v2n4-from-the-square-series"
category: "direct"
description: "Commissioned for Rhizome.org"
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "From the Square Series" by Roger Coqart
Originally published in "Computer Graphics and Art" vol2 no4, 1977
Copyright (c) 2012 Benjamin Fox - OSI/MIT license (http://recodeproject/license).
*/

let margin = 40;

//specify rows & cols of grid on screen
let screenRows = 3;
let screenCols = 3;
let numScreenCells = screenRows * screenCols;

//specify rows & cols of a grid of tiles
let n = 7;//we're defining as a single var as we want it square
let tileSize = 35;// w / h of the lined tile
let numTiles = n * n;
let centerTile = int(n/2);

let lines;

function setup() {
  //set screen size
  let sW = screenRows * n * tileSize + margin;
  let sH = screenCols * n * tileSize + margin;
  createCanvas(sW, sH);

  //for use later when randomising the lines to draw
  lines = [];
  for (let i = 1; i <= 8; i++) {
    lines.push(i);
  }
}

function draw() {
  stroke(255);
  strokeWeight(2);
  background(0);

  push();
  translate(margin/2, margin/2);

  for (let i = 0; i < numScreenCells; i++) {
    let x = i % screenRows;
    let y = int(i / screenCols);

    //decides on the density of tiles for the cell we are filling
    if (i % 2 == 0) {
      tile(x, y, 8, 2);//max 8 lines per tile, reducing by 2 from center
    } else {
      tile(x, y, 4, 1);//max 4 lines per tile, reducing by 1 from center
    }
  }

  pop();

  noLoop();
}

function mouseReleased() {
  loop();
}

function drawLines(l) {
  //lets randomise the order of lines to draw
  lines = shuffle(lines);

  for (let j = 0; j < l; j++) {

    let i = lines[j];

    switch (i) {
      case 1:
        line(0, 0, tileSize, tileSize);
        break;
      case 2:
        line(0, tileSize, tileSize, 0);
        break;
      case 3:
        line(0, tileSize/2, tileSize, tileSize/2);
        break;
      case 4:
        line(tileSize/2, 0, tileSize/2, tileSize);
        break;
      case 5:
        line(0, tileSize/2, tileSize/2, 0);
        break;
      case 6:
        line(tileSize/2, 0, tileSize, tileSize/2);
        break;
      case 7:
        line(tileSize, tileSize/2, tileSize/2, tileSize);
        break;
      case 8:
        line(tileSize/2, tileSize, 0, tileSize/2);
        break;
    }
  }
}

function tile(col, row, maxLines, reducer) {

  push();
  translate(col * n * tileSize, row * n * tileSize);

  for (let i = 0; i < numTiles; i++) {
    let c = i % n;
    let r = int(i / n);

    let numLines = maxLines - (reducer * max(abs(r - centerTile), abs(c - centerTile)));

    push();
    translate(c * tileSize, r * tileSize);
    drawLines(numLines);

    pop();
  }

  pop();

}
</script>
