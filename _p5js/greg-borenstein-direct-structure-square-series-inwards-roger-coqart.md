---
title: "Travelling Through the Square Series - Inwards"
translator: "Greg Borenstein"
translator_url: "http://gregborenstein.com/"
slug: "greg-borenstein-direct-structure-square-series-inwards-roger-coqart"
artwork_slug: "v1n3-structure-square-series-inwards"
category: "direct"
description: '"Structured Square Series -- Inwards", drawing 28 x 28 cm. Other works in the series are "Horizontal Rows", "Outwards", as well as the "Permutation" works.'
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Structure Square Series - Inward" by Roger Coqart
Originally published in "Computer Graphics and Art" vol1 no3, 1976
Copyright (c) 2012 Greg Borenstein - OSI/MIT license (http://recodeproject/license).
*/

let rowSize = 15;
let marginSize = 6;
let boxSize = 14;

let strokes;

function setup() {
  createCanvas(350, 350);
  noFill();
  stroke(0);
  noLoop();

  strokes = [];
  for (let i = 0; i < 8; i++) {
    strokes.push(i);
  }
}

function draw() {
  background(255);

  translate(boxSize * 2, boxSize * 2);

  for (let row = 0; row < rowSize; row++) {
    for (let col = 0; col < rowSize; col++) {
      let x = boxSize * col + marginSize * col;
      let y = boxSize * row + marginSize * row;

      push();
      translate(x, y);
      rect(0, 0, boxSize, boxSize);

      // this is the one clever bit:
      // measure the distance of the square from the
      // center in concentric rings to find out how many segments to draw
      let middle = 7;
      let distFromMiddle = max(abs(row - middle), abs(col - middle));

      // do the strokes in a random different order each time
      shuffle(strokes, true);
      for (let i = 0; i < distFromMiddle; i++) {
        drawSegment(strokes[i], boxSize, boxSize);
      }

      pop();
    }
  }
}

function drawSegment(i, w, h) {
  switch(i) {
  case 0:
    line(0, 0, w, h);
    break;

  case 1:
    line(w, 0, 0, h);
    break;

  case 2:
    line(0, h/2, w, h/2);
    break;

  case 3:
    line(0, h/2, w/2, 0);
    break;

  case 4:
    line(w/2, 0, w, h/2);
    break;

  case 5:
    line(w, h/2, w/2, h);
    break;

  case 6:
    line(w/2, 0, w/2, h);
    break;

  case 7:
    line(w/2, h, 0, h/2);
    break;
  }
}
</script>
