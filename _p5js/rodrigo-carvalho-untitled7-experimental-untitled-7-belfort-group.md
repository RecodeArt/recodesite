---
title: "Untitled7"
translator: "Rodrigo Carvalho"
translator_url: "http://www.visiophone-lab.com/"
slug: "rodrigo-carvalho-untitled7-experimental-untitled-7-belfort-group"
artwork_slug: "v1n3-untitled-7"
category: "experimental"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 7" by Belfort Group
Originally published in "Computer Graphics and Art" v1n3, 1976
Copyright (c) 2014 Rodrigo Carvalho - OSI/MIT license (http://recodeproject/license).
*/

/*
Recoding of "Untitled 7" by Belfort Group, 1976
When the code starts it draws the original artwork.
When the SPACE is pressed the animation mode is turned on, generating variations
Press up / down to change the probability of a different line to be created
and left / right to change the speed
*/

// Display size
let w = 750 / 2;
// If the screen is 750, adjust is 6.4. if screen = 750/2, adjust is 3.2
let adjust = 6.4 / 2;
// Background color
let back = 25;

// Number of columns and rows
let col = 75;
let row = 47;

// Size of each square
let rectW = w / 75;

// Keep track of the cell number
let totalCount = 0;

// Probability of a different new line
let ran;
let prob = 0.1;

let dots = [];

// Original sequences
let origA = [1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0];
let origB = [0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1];
let origC = [0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0];

let newLine = [];

// Starts/stops the creation of variations of the original artwork
let generate = false;

// Frame rate
let rate = 8;

function setup() {
  createCanvas(325, 325);
  fill(255);
  stroke(back);
  strokeWeight(2);
  background(back);
  frameRate(rate);

  // Initialize dots array
  for (let i = 0; i < col; i++) {
    dots[i] = new Array(row + 1);
  }

  // Initialize newLine array
  for (let i = 0; i < 75; i++) {
    newLine[i] = 0;
  }

  // Draw original artwork sequence
  original();
}

function draw() {
  if (generate) {
    Generate();
  }
  frameRate(rate);
}

// Create variations of the original artwork
function Generate() {
  // Drawing the current sequence
  for (let i = 0; i < col; i++) {
    for (let j = 0; j < row; j++) {
      if (dots[i][j] === 1) fill(255);
      if (dots[i][j] === 0) fill(back);
      rect(rectW * i, rectW * j + (j * adjust), rectW, rectW);
    }
  }

  // STEP: animating the lines down the screen. The line in the row 0 goes to 1, etc...
  for (let i = 0; i < col; i++) {
    for (let j = row - 1; j > 0; j--) {
      dots[i][j] = dots[i][j - 1];
    }
  }

  // Constraining the possibilities of creating a different line. 10% for new line 90% for the same
  ran = random(1);

  if (ran < prob) {
    // Creating new sequences in the first line, to animate the sequences
    for (let i = 0; i < col; i++) {
      dots[i][0] = Math.round(random(1));
    }
  }
}

function keyPressed() {
  // If space is pressed generate a new sequence
  if (key === ' ') {
    generate = !generate;
  }

  // Up and down keys, change the probability of a different line to be created
  if (keyCode === UP_ARROW) {
    if (prob <= 1.0) prob = prob + 0.1;
  }

  if (keyCode === DOWN_ARROW) {
    if (prob >= 0.0) prob = prob - 0.1;
  }

  // CHANGING SPEED
  if (keyCode === RIGHT_ARROW) {
    if (rate <= 40) rate = rate + 4;
  }

  if (keyCode === LEFT_ARROW) {
    if (rate >= 5) rate = rate - 4;
  }
}

// DRAWING THE ORIGINAL ARTWORK SEQUENCE
function original() {
  for (let i = 0; i < col; i++) {
    for (let j = 0; j < row; j++) {
      if (j < 5) {
        if (origA[totalCount] === 1) fill(255);
        if (origA[totalCount] === 0) fill(back);
        rect(rectW * i, rectW * j + (j * adjust), rectW, rectW);
        dots[i][j] = origA[totalCount];
      }
      if (j >= 5 && j < 29) {
        if (origB[totalCount] === 1) fill(255);
        if (origB[totalCount] === 0) fill(back);
        rect(rectW * i, rectW * j + (j * adjust), rectW, rectW);
        dots[i][j] = origB[totalCount];
      }
      if (j >= 29) {
        if (origC[totalCount] === 1) fill(255);
        if (origC[totalCount] === 0) fill(back);
        rect(rectW * i, rectW * j + (j * adjust), rectW, rectW);
        dots[i][j] = origC[totalCount];
      }
    }
    totalCount++;
  }
}
</script>
