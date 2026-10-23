---
title: "Gaussian Distribution"
translator: "Josh Giesbrecht"
translator_url: "http://www.thoughtlost.org/wp/"
slug: "josh-giesbrecht-gaussian-distribution-direct-gaussian-distribution-kerry-jones"
artwork_slug: "v2n2-gaussian-distribution"
category: "direct"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Gaussian Distribution" by Kerry Jones
Originally published in "Computer Graphics and Art" v2n2, 1977
Copyright (c) 2013 Josh Giesbrecht - OSI/MIT license (http://recodeproject/license).
*/

// coded by Josh Giesbrecht

let fg, bg;

function setup() {
  createCanvas(400, 400);
  fg = color(0);
  bg = color(255);

  background(bg);
  update();
}

function draw() {
}

function update() {
  background(255);

  for (let i = 0; i < 7000; i++) {
    let x = floor(random(0, width));
    let y = floor(myGaussian() * height * 0.18) + height * 4/9;

    noStroke();
    fill(fg);
    ellipse(x, y, 4, 4);
  }
}

function mousePressed() {
  update();
}

// ported from http://www.colingodsey.com/javascript-gaussian-random-number-generator/
function myGaussian() {
  let x1, x2, rad;

  do {
    x1 = 2 * random(1) - 1;
    x2 = 2 * random(1) - 1;
    rad = x1 * x1 + x2 * x2;
  } while (rad >= 1 || rad == 0);

  let c = sqrt(-2 * Math.log(rad) / rad);

  return x1 * c;
}
</script>
