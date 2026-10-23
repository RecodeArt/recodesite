---
title: "Structured Squares"
translator: "Nick Santaniello"
translator_url: "http://www.robysoft.net/"
slug: "nick-santaniello-experimental-structure-square-series-inwards-roger-coqart"
artwork_slug: "v1n3-structure-square-series-inwards"
category: "experimental"
description: 'Partially derived from Greg Borenstein''s translation of Roger Coqart''s "Structured Square Series -- Inwards"'
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Structure Square Series Inwards" by Roger Coqart
Originally published in "Computer Graphics and Art" vol1 no3, 1976
Copyright (c) 2012 Nick Santaniello - OSI/MIT license (http://recodeproject/license).
*/

let margin = 8;
let boxSize = 30;
let cols = 15;
let rows = 15;
let frameCounter = 0;
let targetCol = 1;
let targetRow = 1;
let moveRate = 10;
let dir = 1;

let theLines;

function setup() {
  createCanvas(564, 564);
  background(255);
  stroke(0);
  strokeWeight(2);

  theLines = [];
  for (let i = 0; i < 8; i++) {
    theLines.push(i);
  }

  drawAgain();
}

function drawAgain() {
  background(255);

  // for every row...
  for (let r = 0; r < rows; r++) {
    // for every column...
    for (let c = 0; c < cols; c++) {
      let x = boxSize * c + margin * c;
      let y = boxSize * r + margin * r;

      push();
      translate(x, y);
      rect(0, 0, boxSize, boxSize);

      let targetDistance = max(abs(r - targetRow), abs(c - targetCol));

      // Default to max segments if box is far away
      if (targetDistance > 7) {
        targetDistance = 7;
      }

      // randomize possible lines
      theLines = shuffle(theLines);
      for (let i = 0; i < targetDistance; i++) {
        drawLine(theLines[i], boxSize, boxSize);
      }

      pop();
    }
  }
}

function draw() {
  frameCounter++;

  if (frameCounter > moveRate) {
    switch (dir) {
    case 1:
      targetCol++;
      if (targetCol >= cols - 3) {
        dir++;
      }
      break;
    case 2:
      targetRow++;
      if (targetRow >= rows - 3) {
        dir++;
      }
      break;
    case 3:
      targetCol--;
      if (targetCol <= 2) {
        dir++;
      }
      break;
    case 4:
      targetRow--;
      if (targetRow <= 3) {
        dir = 1;
      }
      break;
    }
    drawAgain();
    frameCounter = 0;
  }
}


function drawLine(whichLine, w, h) {
  switch (whichLine) {
  case 0:
    line(w, 0, 0, h);
    break;
  case 1:
    line(0, 0, w, h);
    break;
  case 2:
    line(0, h / 2, w, h / 2);
    break;
  case 3:
    line(0, h / 2, w / 2, 0);
    break;
  case 4:
    line(w / 2, h, 0, h / 2);
    break;
  case 5:
    line(w / 2, 0, w / 2, h);
    break;
  case 6:
    line(w / 2, 0, w, h / 2);
    break;
  case 7:
    line(w, h / 2, w / 2, h);
    break;
  }
}
</script>
