---
title: "Haydn Edginton-King"
translator: "Haydn Edginton-King"
translator_url: ""
slug: "haydn-edginton-king-haydn-edginton-king-direct-from-the-square-series-roger-coqart"
artwork_slug: "v3n2-from-the-square-series"
category: "direct"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "From the Square Series" by Roger Coqart
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2015 Haydn Edginton-King - OSI/MIT license (http://recodeproject/license).
*/

/* @pjs pauseOnBlur="true"; */

let lin = 0;
let col = 0;
let size = 12;

let lin2 = 0;
let col2 = 0;
let size2 = 36;

function setup() {
  createCanvas(400, 400);
  background(0);
  stroke(255);
  strokeWeight(3.2);
  strokeCap(ROUND);
}

function draw() {
  let sorte = round(random(0, 5));
  console.log(sorte);

  if (sorte == 0) {
    line(lin * size, col * size, size + (lin * size), size +  (col * size));
  }
  if (sorte == 1) {
    line(lin * size + size, col * size, lin * size, col * size + size);
  }
  if (sorte == 2) {
    line(lin * size, col * size, size + (lin * size), size +  (col * size));
  }
  if (sorte == 3) {
    line(lin * size + size, col * size, lin * size, col * size + size);
  }
  if (sorte == 4) {
  }

  lin++;

  if (lin * 12 > width) {
    col++;
    lin = 0;
  }

  if (col * 12 > height) {
    noLoop();
  }

  let sorte2 = round(random(0, 5));
  console.log(sorte2);
  strokeCap(ROUND);
  if (sorte2 == 0) {
    line(lin2 * size2, col2 * size2, lin2 * size2 + size2, col2 * size2);
  }
  if (sorte2 == 1) {
    line(lin2 * size2, col2 * size2, lin2 * size2, col2 * size2 + size2);
  }
  if (sorte2 == 2) {
    line(lin2 * size2, col2 * size2, lin2 * size2 + size2, col2 * size2);
  }
  if (sorte2 == 3) {
    line(lin2 * size2, col2 * size2, lin2 * size2, col2 * size2 + size2);
  }
  if (sorte2 == 4) {
  }

  lin2++;

  if (lin2 * 36 > width) {
    col2++;
    lin2 = 0;
  }

  if (col2 * 36 > height) {

  }
}
</script>
