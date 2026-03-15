---
title: "P210"
translator: "Calvin Hu"
translator_url: "http://www.calvin.hu/"
slug: "calvin-hu-direct-p210-manfred-mohr"
artwork_slug: "v3n1-p210"
category: "direct"
description: ""
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "P210" by Manfred Mohr
Originally published in "Computer Graphics and Art" vol3 no1, 1978
Copyright (c) 2012 Calvin Hu - OSI/MIT license (http://recodeproject/license).
*/

let screenHeight = 960;
let screenWidth = 960;
let offset = 30;
let interval = 300;
let cubeSide = 100;

function draw_cube(slength, permutation, strokeCube, strokeOutline) {
  let side = slength/2;
  let start_point = -side;
  let dHeight = 2;
  let dWidth = 125;
  if (permutation[0]) {
    strokeWeight(strokeOutline);
    line(start_point, start_point + dHeight, start_point - dWidth, start_point, start_point + dHeight, side + dWidth);
    line(start_point, start_point - dHeight, start_point - dWidth, start_point, start_point - dHeight, side + dWidth);

    line(side, start_point + dHeight, start_point - dWidth, side, start_point + dHeight, side + dWidth);
    line(side, start_point - dHeight, start_point - dWidth, side, start_point - dHeight, side + dWidth);

    line(side, side + dHeight, start_point - dWidth, side, side + dHeight, side + dWidth);
    line(side, side - dHeight, start_point - dWidth, side, side - dHeight, side + dWidth);

    line(start_point, side + dHeight, start_point - dWidth, start_point, side + dHeight, side + dWidth);
    line(start_point, side - dHeight, start_point - dWidth, start_point, side - dHeight, side + dWidth);

    strokeWeight(strokeCube);
    line(side, side, start_point, side, side, side);
    line(side, start_point, start_point, side, start_point, side);
    line(start_point, start_point, start_point, start_point, start_point, side);
    line(start_point, side, start_point, start_point, side, side);
  }
  if (permutation[1]) {
    strokeWeight(strokeOutline);
    line(start_point + dHeight, start_point - dWidth, start_point, start_point + dHeight, side + dWidth, start_point);
    line(start_point - dHeight, start_point - dWidth, start_point, start_point - dHeight, side + dWidth, start_point);

    line(start_point + dHeight, start_point - dWidth, side, start_point + dHeight, side + dWidth, side);
    line(start_point - dHeight, start_point - dWidth, side, start_point - dHeight, side + dWidth, side);

    line(side + dHeight, start_point - dWidth, start_point, side + dHeight, side + dWidth, start_point);
    line(side - dHeight, start_point - dWidth, start_point, side - dHeight, side + dWidth, start_point);

    line(side + dHeight, start_point - dWidth, side, side + dHeight, side + dWidth, side);
    line(side - dHeight, start_point - dWidth, side, side - dHeight, side + dWidth, side);
    strokeWeight(strokeCube);
    line(start_point, start_point, start_point, start_point, side, start_point);
    line(start_point, start_point, side, start_point, side, side);
    line(side, start_point, start_point, side, side, start_point);
    line(side, start_point, side, side, side, side);
  }
  if (permutation[2]) {
    strokeWeight(strokeOutline);
    line(start_point - dWidth, start_point + dHeight, start_point, side + dWidth, start_point + dHeight, start_point);
    line(start_point - dWidth, start_point - dHeight, start_point, side + dWidth, start_point - dHeight, start_point);

    line(start_point - dWidth, start_point + dHeight, side, side + dWidth, start_point + dHeight, side);
    line(start_point - dWidth, start_point - dHeight, side, side + dWidth, start_point - dHeight, side);

    line(start_point - dWidth, side + dHeight, start_point, side + dWidth, side + dHeight, start_point);
    line(start_point - dWidth, side - dHeight, start_point, side + dWidth, side - dHeight, start_point);

    line(start_point - dWidth, side + dHeight, side, side + dWidth, side + dHeight, side);
    line(start_point - dWidth, side - dHeight, side, side + dWidth, side - dHeight, side);
    strokeWeight(strokeCube);
    line(start_point, start_point, start_point, side, start_point, start_point);
    line(start_point, start_point, side, side, start_point, side);
    line(start_point, side, start_point, side, side, start_point);
    line(start_point, side, side, side, side, side);
  }
}

function setup() {
  createCanvas(screenWidth, screenHeight, WEBGL);
  background(255);
  rectMode(CORNERS);
  ortho();
  noLoop();
}

function draw() {
  push();
  translate(offset-interval/2, offset-interval/2);

  let sides;
  for (let i = 0; i < 3; i++) {
    translate(interval, 0);
    push();
    for (let j = 1; j <= 3; j++) {
      let refreshSides = [
        false, false, false
      ];
      sides = refreshSides;
      translate(0, interval);
      if (j != 1) {
        for (let k = 1; k < j + 1; k++) {
          sides[(i + k) % 3] = true;
        }
      }
      else {
        sides[i] = true;
      }
      push();
      rotateX(PI * 3/16);
      rotateY(PI * 3/10);
      rotateZ(PI/12);
      draw_cube(cubeSide, sides, 3, 1);
      pop();
    }
    pop();
  }
  pop();

  hint(DISABLE_DEPTH_TEST);
  noStroke();
  fill(255);
  for (let i = 0; i < 4; i++) {
    rect(0, i * interval, screenWidth, i * interval + offset*2);
    rect(i * interval, 0, i * interval + offset * 2, screenHeight);
  }

  strokeWeight(1);
  stroke(0);
  for (let i = 1; i <= 2; i++) {
    line(offset, offset + i*interval, screenWidth - offset, offset + i*interval);
    line(offset + i*interval, offset, offset + i*interval, screenHeight - offset);
  }
}
</script>
