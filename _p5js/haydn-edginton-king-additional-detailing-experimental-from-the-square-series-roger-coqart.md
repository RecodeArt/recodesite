---
title: "Additional Detailing"
translator: "Haydn Edginton-King"
translator_url: ""
slug: "haydn-edginton-king-additional-detailing-experimental-from-the-square-series-roger-coqart"
artwork_slug: "v3n2-from-the-square-series"
category: "experimental"
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
let sizer = 6;

let lin2 = 0;
let col2 = 0;
let sizer2 = 24;

let lin3 = 0;
let col3 = 0;
let sizer3 = 12;

let lin4 = 0;
let col4 = 0;
let sizer4 = 48;

function setup() {
  createCanvas(400, 400);
  background(0);
  stroke(255);
  strokeWeight(1);
  strokeCap(ROUND);
}

function draw() {
  let sorte = round(random(0, 5));

  if (sorte == 0) {
    line(lin * sizer, col * sizer, sizer + (lin * sizer), sizer +  (col * sizer));
  }
  if (sorte == 1) {
    line(lin * sizer + sizer, col * sizer, lin * sizer, col * sizer + sizer);
  }
  if (sorte == 2) {
  }
  if (sorte == 3) {
  }
  if (sorte == 4) {
  }

  lin++;

  if (lin * sizer > width) {
    col++;
    lin = 0;
  }

  if (col * sizer > height) {
    noLoop();
  }

  let sorte2 = round(random(0, 5));

  if (sorte2 == 0) {
    line(lin2 * sizer2, col2 * sizer2, sizer2 + (lin2 * sizer2), sizer2 +  (col2 * sizer2));
  }
  if (sorte2 == 1) {
    line(lin2 * sizer2 + sizer2, col2 * sizer2, lin2 * sizer2, col2 * sizer2 + sizer2);
  }
  if (sorte2 == 2) {
  }
  if (sorte2 == 3) {
  }
  if (sorte2 == 4) {
  }

  lin2++;

  if (lin2 * sizer2 > width) {
    col2++;
    lin2 = 0;
  }

  if (col2 * sizer2 > height) {
  }

  let sorte3 = round(random(0, 5));

  if (sorte3 == 0) {
    line(lin3 * sizer3, col3 * sizer3, sizer3 + (lin3 * sizer3), sizer3 +  (col3 * sizer3));
  }
  if (sorte3 == 1) {
    line(lin3 * sizer3 + sizer3, col3 * sizer3, lin3 * sizer3, col3 * sizer3 + sizer3);
  }
  if (sorte3 == 2) {
    line(lin3 * sizer3, col3 * sizer3, sizer3 + (lin3 * sizer3), sizer3 +  (col3 * sizer3));
  }
  if (sorte3 == 3) {
    line(lin3 * sizer3 + sizer3, col3 * sizer3, lin3 * sizer3, col3 * sizer3 + sizer3);
  }
  if (sorte3 == 4) {
  }

  lin3++;

  if (lin3 * sizer3 > width) {
    col3++;
    lin3 = 0;
  }

  if (col3 * sizer3 > height) {
  }

  let sorte4 = round(random(0, 5));

  if (sorte4 == 0) {
    line(lin4 * sizer4 + sizer4, col4 * sizer4, lin4 * sizer4, col4 * sizer4 + sizer4);
  }
  if (sorte4 == 1) {
    line(lin4 * sizer4 + sizer4, col4 * sizer4, lin4 * sizer4, col4 * sizer4 + sizer4);
  }
  if (sorte4 == 2) {
  }
  if (sorte4 == 3) {
  }
  if (sorte4 == 4) {
  }

  lin4++;

  if (lin4 * sizer4 > width) {
    col4++;
    lin4 = 0;
  }

  if (col4 * sizer4 > height) {
  }
}
</script>
