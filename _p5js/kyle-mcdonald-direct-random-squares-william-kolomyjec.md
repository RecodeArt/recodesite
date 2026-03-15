---
title: "Random Squares"
translator: "Kyle McDonald"
translator_url: "http://kylemcdonald.net/"
slug: "kyle-mcdonald-direct-random-squares-william-kolomyjec"
artwork_slug: "v2n3-random-squares"
category: "direct"
description: "Image shown is a cropped version of full output."
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Random Squares" by William Kolomyjec
Originally published in "Computer Graphics and Art" vol2 no3, 1977
Copyright (c) 2012 Kyle McDonald - OSI/MIT license (http://recodeproject/license).
*/

/*
 methods:
 1. vernacular
   preserve the spirit of the image
   least work
   but the influence of the original tool is lost
 2. rosetta
   preserve the spirit of the code itself
   connects old languages to new languages
 3. revival
   write a parser to run the original code
   most work
   preserves everything but the output medium (plotter)
*/

function setup() {
  createCanvas(500, 700);
  background(255);
  noLoop();
}

function draw() {
  //vernacular();
  rosetta();
}

/*
 translation notes:
 * BASIC uses 1-indexed arrays, Java uses 0-indexed arrays
 * lines with  //? have no corollary in this environment
 * with a few exceptions, there is no decorative whitespace in the original code
 * RANF(0) corresponds to random(1)
 * the HYPLT plotter interface is replaced with beginShape/endShape helper functions
*/

function rosetta() {
  // ******************PROGRAMMED FOR COMPUTER GRAPHICS AND ART BY BILL KULOMYJEC
  let A = Array(4).fill(0).map(() => Array(2).fill(0));
  let B = Array(4).fill(0).map(() => Array(2).fill(0));
  let AA = Array(4).fill(0).map(() => Array(2).fill(0));
  let BB = Array(4).fill(0).map(() => Array(2).fill(0));

  // PROVIDE MEMORY FOR 2 SETS OF SQUARES, RANDOMIZE
  randomSeed(0); //CALL RANST
  // DEFINE VARIABLES
  let NUMX = 5;
  let NUMY = 7;
  // BSS=THE SIZE OF THE SIDE OF THE SQUARE, SSPCT=THE PERCENT
  // OF THE SIZE OF THE INSIDE SQUARE
  let BSS = 1.25;
  let SSPCT = 0.20;
  let HFBSS = BSS / 2.0;
  // VLIMIT IS THE MAXIMUM AMOUNT THE INNER SQUARE MAY VARY
  let VLIMT = HFBSS - (BSS * SSPCT / 2.0);
  // SET UP CORNERS OF BIG SQUARE
  A[0][0] = HFBSS;
  A[0][1] = HFBSS;
  A[1][0] = -HFBSS;
  A[1][1] = HFBSS;
  A[2][0] = -HFBSS;
  A[2][1] = -HFBSS;
  A[3][0] = HFBSS;
  A[3][1] = -HFBSS;
  // SCALE DOWN SMALL SQUARE BY SSPCT
  for (let J = 0; J < 4; J++) {
    for (let K = 0; K < 2; K++) {
      B[J][K] = A[J][K] * SSPCT;
    }
  }
  // INITIALIZE PLOTTER
  HYPLT(0.0, 0.0, 0);
  // BEGIN DRAWING RANDOM SQUARE MODULES
  for (let J = 0; J < NUMY; J++) {
    let YC = J * BSS;
    for (let K = 0; K < NUMX; K++) {
      let XC = K * BSS;
      // ADJUST OUTER SQUARE TO RELATIVE LOCATION
      for (let L = 0; L < 4; L++) {
        AA[L][0] = A[L][0] + XC;
        AA[L][1] = A[L][1] + YC;
      }
      // DETERMINE X AND Y VARIANCE BASED ON VLIMT
      let XVAR = random(1) * VLIMT - (VLIMT / 2.0);
      let YVAR = random(1) * VLIMT - (VLIMT / 2.0);
      // ADJUST INNER SQUARE TO RELATIVE LOCATION, ADD VARIANCE
      for (let M = 0; M < 4; M++) {
        BB[M][0] = B[M][0] + XVAR + XC;
        BB[M][1] = B[M][1] + YVAR + YC;
      }
      // DETERMINE RANDOM NUMBER OF INTERVALS (BETWEEN 2 AND 10)
      let NSPCS = floor(9 * random(1) + 2);
      // PLOT EACH MODULE
      for (let N = 0; N < NSPCS; N++) {
        // P CALCULATES RELATIVE SPACING ON NSPCS
        let P = N / (NSPCS - 1);
        let X = AA[3][0] + P * (BB[3][0] - AA[3][0]);
        let Y = AA[3][1] + P * (BB[3][1] - AA[3][1]);
        // MOVE THE PEN TO THE LAST CORNER OF THE SQUARE
        HYPLT(X, Y, 2);
        // PLOT INTERMEDIATE SQUARES
        for (let I = 0; I < 4; I++) {
          X = AA[I][0] + P * (BB[I][0] - AA[I][0]);
          Y = AA[I][1] + P * (BB[I][1] - AA[I][1]);
          HYPLT(X, Y, 1);
        }
      }
    }
  }
  // TERMINATE
  HYPLT(0.0, 0.0, -1);
}

// HYPLT implementation with beginShape/endShape
let plotterState = 0; // UP
const UP = 0;
const DOWN = 1;

function penDown() {
  if (plotterState == UP) {
    noFill();
    beginShape();
    plotterState = DOWN;
  }
}

function penUp() {
  if (plotterState == DOWN) {
    endShape(CLOSE);
    plotterState = UP;
  }
}

function penMove(x, y) {
  vertex(x, y);
}

function HYPLT(x, y, mode) {
  if (mode == -1) { // finish
    penUp();
  } else if (mode == 0) { // initialize
    strokeWeight(0);
    // original used the range (-0.625, -0.625) to (5.625, 8.15)
    // perhaps in or cm? we use 80x zoom to convert to pixels.
    scale(80, 80);
    translate(0.625, 0.625);
  } else if (mode == 1) { // down + move
    penDown();
    penMove(x, y);
  } else if (mode == 2) { // close/up
    penUp();
  }
}

function vernacular() {
  rectMode(CENTER);
  noFill();
  let side = 100;

  for (let y = 0; y < 7; y++) {
    for (let x = 0; x < 5; x++) {
      let n = floor(random(2, 11));
      let ox = random(side / 2) + side / 4;
      let oy = random(side / 2) + side / 4;

      for (let i = 0; i < n; i++) {
        let curSide = map(i, 0, n - 1, 0.2, 1) * side;
        let cx = x * side + map(i, 0, n - 1, ox, side / 2);
        let cy = y * side + map(i, 0, n - 1, oy, side / 2);
        rect(cx, cy, curSide, curSide);
      }
    }
  }
}
</script>
