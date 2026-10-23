---
title: "Diamond Theory Roullete"
translator: "Radames Ajna"
translator_url: "http://www.radames.in/"
slug: "radames-ajna-diamond-theory-roullete-experimental-diamond-theory-steven-h-cullinane"
artwork_slug: "v2n1-diamond-theory"
category: "experimental"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Diamond Theory" by Steven H Cullinane
Originally published in "Computer Graphics and Art" v2n1, 1977
Copyright (c) 2013 Radames Ajna - OSI/MIT license (http://recodeproject/license).
*/

let bits = [
  0, 1, 0, 1,
  2, 3, 2, 3,
  0, 1, 0, 1,
  2, 3, 2, 3
];

let lsize = 100;
let lastTime;
let accTime;
let v = 1;

function setup() {
  createCanvas(Math.floor(lsize * 4 + 100), Math.floor(lsize * 4 + 100));
  background(255);
  randss();
  noStroke();
  lastTime = millis();
  accTime = millis();
}

function draw() {
  background(255);
  push();
  translate(width / 2, height / 2);
  drawTriangle(bits);
  pop();

  if (millis() - lastTime < 5000) {
    v += Math.exp(0.0005 * millis());
    if (millis() - accTime > v) {
      accTime = millis();
      randss();
    }
  } else {
    noLoop();
  }
}

function drawTriangle(bits) {
  push();
  translate(-lsize * 4 / 2, -lsize * 4 / 2);
  for (let x = 0; x < 4; x++) {
    for (let y = 0; y < 4; y++) {
      let i = x + y * 4;
      fill(0);
      push();
      translate(x * lsize, y * lsize);
      beginShape(TRIANGLES);
      switch(bits[i]) {
        case 0:
          // bottom right
          vertex(lsize, lsize);
          vertex(0, lsize);
          vertex(lsize, 0);
          break;
        case 1:
          // bottom left
          vertex(0, 0);
          vertex(0, lsize);
          vertex(lsize, lsize);
          break;
        case 2:
          // top right
          vertex(0, 0);
          vertex(lsize, 0);
          vertex(lsize, lsize);
          break;
        case 3:
          // top left
          vertex(0, 0);
          vertex(lsize, 0);
          vertex(0, lsize);
          break;
      }
      endShape(CLOSE);
      pop();
    }
  }
  pop();
}

// Transpose row r0 with row r1
function transposeRow(bits, r0, r1) {
  let temp = new Array(4);

  for (let x = 0; x < 4; x++) {
    // Keep the values from row r0 on temp
    let i = x + r0 * 4;
    temp[x] = bits[i];

    // Put on row r0 values from row r1
    let i2 = x + r1 * 4;
    bits[i] = bits[i2];
    // Put on row r1 values from r0 i.e. from temp
    bits[i2] = temp[x];
  }
}

function transposeColumn(bits, c0, c1) {
  let temp = new Array(4);

  for (let y = 0; y < 4; y++) {
    // Keep the values from column c1 on temp
    let i = c0 + y * 4;
    temp[y] = bits[i];

    // Put on column c0 values from column c1
    let i2 = c1 + y * 4;
    bits[i] = bits[i2];

    // Put on column c1 values from column c0 i.e. temp
    bits[i2] = temp[y];
  }
}

function transposeQuadrant(bits, q0, q1) {
  let temp = new Array(4);

  // Given a q0 - quadrant 0,1,2,3
  // |0|1|
  // |2|3|
  // Returns x,y initial coordinates

  let x0q0 = (q0 % 2) * 2;
  let y0q0 = q0 > 1 ? 2 : 0;

  let x0q1 = (q1 % 2) * 2;
  let y0q1 = q1 > 1 ? 2 : 0;

  let c = 0;
  for (let i = 0; i < 2; i++) {
    for (let j = 0; j < 2; j++) {
      temp[c] = bits[x0q0 + i + (y0q0 + j) * 4];
      bits[x0q0 + i + (y0q0 + j) * 4] = bits[x0q1 + i + (y0q1 + j) * 4];
      bits[x0q1 + i + (y0q1 + j) * 4] = temp[c];
      c++;
    }
  }
}

function randss() {
  transposeRow(bits, Math.floor(random(0, 4)), Math.floor(random(0, 4)));
  transposeColumn(bits, Math.floor(random(0, 4)), Math.floor(random(0, 4)));
  transposeQuadrant(bits, Math.floor(random(0, 4)), Math.floor(random(0, 4)));
}

function mousePressed() {
  randss();
  redraw();
}
</script>
