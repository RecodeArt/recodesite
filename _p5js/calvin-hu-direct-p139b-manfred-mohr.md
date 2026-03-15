---
title: "P139B"
translator: "Calvin Hu"
translator_url: ""
slug: "calvin-hu-direct-p139b-manfred-mohr"
artwork_slug: "v3n1-p139b"
category: "direct"
description: ""
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "P139B" by Manfred Mohr
Originally published in "Computer Graphics and Art" v3n1, 1978
Copyright (c) 2012 Calvin Hu - OSI/MIT license (http://recodeproject/license).
*/

let OFFSETX = 150;
let OFFSETY = 150;
let INTERVAL = 200;
let CUBESIZE = 100;
let SCREENWIDTH = 900;
let SCREENHEIGHT = 300;

function draw_cube(slength, permutation) {
  let side = slength/2;
  let start_point = -side;
  if (permutation[0])
    line(start_point, start_point, start_point, start_point, start_point, side);
  if (permutation[1])
    line(start_point, start_point, start_point, start_point, side, start_point);
  if (permutation[2])
    line(start_point, start_point, start_point, side, start_point, start_point);
  if (permutation[3])
    line(start_point, start_point, side, start_point, side, side);
  if (permutation[4])
    line(start_point, start_point, side, side, start_point, side);
  if (permutation[5])
    line(start_point, side, start_point, side, side, start_point);
  if (permutation[6])
    line(start_point, side, start_point, start_point, side, side);
  if (permutation[7])
    line(side, start_point, start_point, side, side, start_point);
  if (permutation[8])
    line(side, start_point, start_point, side, start_point, side);
  if (permutation[9])
    line(side, side, start_point, side, side, side);
  if (permutation[10])
    line(side, start_point, side, side, side, side);
  if (permutation[11])
    line(start_point, side, side, side, side, side);
}

function setup() {
  createCanvas(SCREENWIDTH, SCREENHEIGHT, WEBGL);
  background(255);
  noLoop();
  ortho();
  strokeWeight(2);
}

function draw() {
  let permutation = [true, true, false, true, true, true, true, false, true, true, true, false];
  let missingSides = [11, 7, 2, 2];
  translate(OFFSETX, OFFSETY);
  push();
  for (let i = 0; i < 4; i++) {
    push();
    rotateX(PI * -4/3 + PI * 1/54);
    rotateY(PI * -4/3 + PI * 1/54);
    rotateZ(PI * -4/3 + PI * 1/54);
    draw_cube(CUBESIZE, permutation);
    pop();
    translate(INTERVAL, 0);
    permutation[missingSides[i]] = true;
  }
  pop();

  stroke(0, 0, 0, 80);
  let permutation2 = [true, false, true, true, false, false, true, true, true, true, true, true];
  let missingSides2 = [4, 1, 5, 5];
  push();
  for (let i = 0; i < 4; i++) {
    push();
    rotateX(PI/6 + PI/72);
    rotateY(-PI/9 - PI/72);
    rotateZ(PI/18);
    draw_cube(CUBESIZE, permutation2);
    pop();
    translate(INTERVAL, 0);
    permutation2[missingSides2[i]] = true;
  }
  pop();
}
</script>
