---
title: "Variation on 9 Squares"
translator: "Gerald Kogler"
translator_url: "http://go.yuri.at/"
slug: "gerald-kogler-direct-variation-on-9-squares-roger-vilder"
artwork_slug: "v1n2-variation-on-9-squares"
category: "direct"
description: "From the SDL Collection."
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Variation on 9 Squares" by Roger Vilder
Originally published in "Computer Graphics and Art" vol1 no2, 1976
Copyright (c) 2012 Gerald Kogler - OSI/MIT license (http://recodeproject/license).
*/

let s = 480;        //size of sketch
let num = 3;        //num of lines and columns in grid
let margin = 30;  //margin around rectangles areas
let overlap = 40; //overlap of reactangle areas
let ease = 0.3;   //easing/division factor for non/linear distribution
let mode = 'e';    //mode 'l'==linear, 'e'==exponential distribution
let bg = 0;
let r;
let squares = [];

function setup() {
  createCanvas(480, 480);
  noFill();
  stroke(255);
  r = ((width - 2 * margin) / num) / 2 + overlap / num;

  //make instances of squares
  for (let y = 0; y < num; y++) {
    for (let x = 0; x < num; x++) {
      squares.push(new Square(x, y, ((x + y * num) % 2 == 0)));
    }
  }
}

function draw() {
  background(bg);
  for (let i = 0; i < num * num; i++) {
    squares[i].draw();
  }
}

function keyPressed() {
  if (key == 's') {
    saveCanvas("RogerVilder-" + mode + ease + ".png");
  }
  else if (key == 'b') {
    if (bg == 0) {
      bg = 255;
      stroke(0);
    }
    else {
      bg = 0;
      stroke(255);
    }
  }
  else if (key == 'm') {
    if (mode == 'l') mode = 'e';
    else mode = 'l';
  }
  else if (key == '+') {
    if (ease > 0.15) ease -= 0.1;
  }
  else if (key == '-') {
    if (ease < 1.0) ease += 0.1;
  }
}


class Square {
  constructor(x, y, hor) {
    this.x = x;       //position in grid
    this.y = y;
    this.hor = hor;   //orientation of squares
  }

  draw() {
    let step = 0;
    for (let angle = 0; angle <= HALF_PI; angle += step) {
      if (mode == 'e') step = (HALF_PI + 0.1 - angle) * ease;
      else step = HALF_PI / (ease * 10);

      let cx = margin + this.x * (2 * r - overlap);
      let cy = margin + this.y * (2 * r - overlap);
      let sx, sy;
      if (this.hor) {
        sx = r + r * cos(angle);
        sy = r + r * sin(angle);
      }
      else {
        sx = r + r * sin(angle);
        sy = r + r * cos(angle);
      }
      let sw = (r - sx) * 2;
      let sh = (r - sy) * 2;
      rect(cx + sx, cy + sy, sw, sh);
    }
  }
}
</script>
