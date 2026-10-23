---
title: "Untitled_6"
translator: "Rodrigo Carvalho"
translator_url: "http://www.visiophone-lab.com/"
slug: "rodrigo-carvalho-untitled-6-experimental-untitled-6-belfort-group"
artwork_slug: "v1n3-untitled-6"
category: "experimental"
description: 'Recoding of "Untitled 6" by Belfort Group Published originaly in "Computer Graphics and Art" 1976 When the code starts it draws the original artwork. When the SPACE is pressed variations of the original are created.'
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 6" by Belfort Group
Originally published in "Computer Graphics and Art" v1n3, 1976
Copyright (c) 2013 Rodrigo Carvalho - OSI/MIT license (http://recodeproject/license).
*/

// Size screen
let w = 600;

// Number of col and row
let row = 12;
let col = 16;

// Total of cells
let total = col * row;
// Keep track of the cell number
let totalCount = 0;

// Rect size
let rectW = w / 16;
let rectH = w / 12;

// Original artwork sequence
let originalSeq = [
  "b", "b", "w", "w", "w", "b", "b", "w", "w", "b", "b", "w",
  "b", "b", "b", "b", "b", "b", "b", "w", "w", "b", "b", "b",
  "w", "w", "b", "b", "b", "b", "b", "w", "w", "b", "b", "b",
  "w", "w", "b", "w", "b", "b", "w", "b", "b", "b", "b", "b",
  "b", "b", "b", "w", "b", "b", "w", "b", "b", "b", "b", "b",
  "b", "b", "b", "w", "b", "b", "w", "b", "w", "w", "w", "b",
  "w", "b", "b", "b", "b", "b", "b", "b", "b", "b", "b", "b",
  "w", "b", "b", "b", "b", "b", "b", "b", "b", "b", "b", "b",
  "w", "b", "b", "b", "b", "w", "w", "w", "w", "w", "w", "b",
  "b", "b", "b", "b", "w", "b", "b", "w", "b", "b", "b", "w",
  "b", "b", "b", "b", "w", "b", "b", "w", "b", "b", "b", "b",
  "b", "b", "b", "b", "w", "b", "b", "w", "w", "w", "w", "b",
  "b", "w", "w", "w", "w", "b", "b", "b", "b", "w", "b", "w",
  "b", "w", "b", "b", "b", "b", "b", "b", "b", "w", "b", "w",
  "b", "w", "b", "b", "b", "b", "b", "b", "b", "w", "b", "w",
  "b", "b", "b", "w", "b", "b", "w", "b", "b", "w", "b", "w"
];

// Prob
let ran;

// Dynamic probability. If last one was white, it will improve the next one
let prob = 0.25;

let generate = false;

function setup() {
  createCanvas(w, w);
  background(0);
  noStroke();
  fill(200, 10);

  // Draw original artwork sequence
  original();
}

function draw() {
  // The sketch doesn't draw anything unless the space is pressed
  if (generate) {
    for (let i = 0; i < col; i++) {
      for (let j = 0; j < row; j++) {
        ran = random(1);
        if (ran < prob) {
          fill(255);
          prob = 0.40;
        } else {
          fill(160);
          prob = 0.20;
        }
        rect(j * rectH, i * rectW, rectH, rectW);
      }
    }
  }
  generate = false;
}

function keyPressed() {
  // If space is pressed generate a new sequence
  if (key === ' ') {
    generate = !generate;
  }
}

function original() {
  for (let i = 0; i < col; i++) {
    for (let j = 0; j < row; j++) {
      if (originalSeq[totalCount] === "w") {
        fill(255);
        prob = 0.40;
      } else {
        fill(160);
        prob = 0.20;
      }

      rect(j * rectH, i * rectW, rectH, rectW);
      totalCount++;
    }
  }
}
</script>
