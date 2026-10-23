---
title: "Nubs"
translator: "Nick Santaniello"
translator_url: "http://www.robysoft.net/"
slug: "nick-santaniello-experimental-untitled-1-various"
artwork_slug: "v1n4-untitled-1"
category: "experimental"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 1" by Variouis
Originally published in "Computer Graphics and Art" vol1 no4, 1976
Copyright (c) 2012 Nick Santaniello - OSI/MIT license (http://recodeproject/license).
*/

// by Various (Reiner Schneeberger and unnamed students)

// See also Vol. 2 No. 3 (image 10, pages 14-15) for more, including code. Input to computer on punch cards

let cols = 11;
let rows = 10;
let frmRate = 60;
let updateCounter = 0;
let sqSize = 100;
let sizeDifference = 17;
let nubs;

function setup() {
  createCanvas(1000, 1000);

  rectMode(CENTER);
  strokeWeight(2);
  fill(240);
  nubs = [];
  for (let i = 0; i < 110; i++) {
    let newNub = new Nub();
    nubs.push(newNub);
  }

  // for every row...
  for (let r = 0; r < rows; r++) {
    // for every column...
    for (let c = 0; c < cols; c++) {
      // set the beginning position of each Nub.
      nubs[r * c].update();
    }
  }
}

function draw() {
  background(255);

  for (let r = 0; r < rows; r++) {
    // for every column...
    for (let c = 0; c < cols; c++) {
      // move each Nub to their target offset.
      let currentNub = 10 * r + 1 * c;
      let row = r;
      let col = c;

      // Ugh, what a hack. Must go back and fix this later.
      if (r == 0) {
        row = 5;
      }
      if (c == 0) {
        col = 3;
      }

      nubs[row * col].run(r, c);
    }
  }

  // increase the frame count
  updateCounter++;

  // every X frames, update the Nubs target offsets.
  if (updateCounter > frmRate) {
    update();
    // reset the update counter
    updateCounter = 0;
  }
}

function update() {
  for (let i = 0; i < 110; i++) {
    nubs[i].update();
  }
}

class Nub {
  constructor() {
    this.cols = 11;
    this.rows = 10;
    // define a starting offset for the Nub.
    this.offsetX = random(-7, 7);
    this.offsetY = random(-7, 7);
    this.targetX = 0;
    this.targetY = 0;
    this.sqSize = 100;
    this.sizeDifference = 17;
  }

  run(r, c) {
    // A very primitive check. If the Nub has not reached its target, move it towards its target by 0.1 pixels per frame.
    if (this.offsetX != this.targetX) {
      if (this.offsetX < this.targetX) {
        this.offsetX = this.offsetX + 0.1;
      }
      if (this.offsetX > this.targetX) {
        this.offsetX = this.offsetX - 0.1;
      }
    }
    if (this.offsetY != this.targetY) {
      if (this.offsetY < this.targetY) {
        this.offsetY = this.offsetY + 0.1;
      }
      if (this.offsetY > this.targetY) {
        this.offsetY = this.offsetY - 0.1;
      }
    }

    // Draw the rectangle and 5 interior rectangles with the appropriate offset.
    rect(c * this.sqSize, r * this.sqSize, this.sqSize, this.sqSize);
    for (let i = 1; i < 6; i++) {
      rect((c * this.sqSize) + (i * this.offsetX), (r * this.sqSize) + (i * this.offsetY), this.sqSize - (i * this.sizeDifference), this.sqSize - (i * this.sizeDifference));
    }
  }

  update() {
    // choose a new target offset for the Nub.
    this.targetX = random(-7, 7);
    this.targetY = random(-7, 7);
  }
}
</script>
