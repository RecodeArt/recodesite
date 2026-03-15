---
title: "Nouveau Gaussian Distribution"
translator: "Will Secor"
translator_url: "http://www.williamsecor.com/"
slug: "will-secor-nouveau-gaussian-distribution-experimental-gaussian-distribution-kerry-jones"
artwork_slug: "v2n2-gaussian-distribution"
category: "experimental"
description: "Smooth rendering, larger ellipses, transparency, and color as a function of ellipse distance from center. Click to redraw."
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Gaussian Distribution" by Kerry Jones
Originally published in "Computer Graphics and Art" v2n2, 1977
Copyright (c) 2013 Will Secor - OSI/MIT license (http://recodeproject/license).
*/

// Changes: smooth() added, larger ellipses, transparency,
// color as a function of distance from center.

let w = 760;
let h = 330;

function setup() {
  createCanvas(w, h);
  noLoop();
}

function draw() {
  background(255, 255, 255);
  fill(0, 0, 0);
  push();
  translate(0, h / 2);
  boxmuller();
  translate(w / 4, 0);
  boxmuller();
  translate(w / 4, 0);
  boxmuller();
  translate(w / 4, 0);
  boxmuller();
  translate(w / 4, 0);
  boxmuller();
  pop();
}

// Box-Muller transform!  This still seems like magic to me.

function boxmuller() {
  for (let j = 0; j < 5500; j++) {
    let u1 = random(0, 1);
    let u2 = random(0, 1);
    let z0 = sqrt(-2 * log(u1)) * cos(2 * PI * u2);
    let z1 = sqrt(-2 * log(u1)) * sin(2 * PI * u2);
    let temp = (((sqrt((z0 * z0) + (z1 * z1))) / PI) * 100);
    stroke(temp, temp, temp, 50);
    fill(temp, temp, temp, 50);
    ellipse(z0 * w / (1.8 * PI), z1 * h / (1.8 * PI), 4, 4);
  }
}

function mousePressed() {
  redraw();
}
</script>
