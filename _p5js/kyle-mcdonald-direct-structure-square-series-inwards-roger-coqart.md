---
title: "Structured Square Series - Inwards"
translator: "Kyle McDonald"
translator_url: "http://kylemcdonald.net/"
slug: "kyle-mcdonald-direct-structure-square-series-inwards-roger-coqart"
artwork_slug: "v1n3-structure-square-series-inwards"
category: "direct"
description: '"Structured Square Series -- Inwards", drawing 28 x 28 cm. // Other works in the series are "Horizontal Rows", "Outwards", as well as the "Permutation" works.'
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Structured Square Series - Inward" by Roger Coqart
Originally published in "Computer Graphics and Art" vol1 no3, 1976
Copyright (c) 2012 Kyle McDonald - OSI/MIT license (http://recodeproject/license).
*/

let side = 24;
let lines = 8;
let n = lines * 2 + 1;
let margin = side / 2;
let offset = side + margin;
let canvas = (n + 1) * offset;
let enabled = [];

function setup() {
  createCanvas(canvas, canvas);
  enabled = new Array(lines);
  noLoop();
}

function draw() {
  background(255);
  translate(side, side);

  for (let y = 0; y < n; y++) {
    for (let x = 0; x < n; x++) {
      // enable some lines
      let total = max(abs(y - lines), abs(x - lines));
      for (let i = 0; i < lines; i++) {
        enabled[i] = i < total;
      }

      // shuffle the enabled lines
      for (let i = 0; i < lines; i++) {
        let swap = enabled[i];
        let j = floor(random(lines));
        enabled[i] = enabled[j];
        enabled[j] = swap;
      }

      // draw all enabled lines
      push();
      translate(x * offset, y * offset);
      rect(0, 0, side, side);
      if (enabled[0]) line(0, side / 2, side, side / 2);
      if (enabled[1]) line(side / 2, 0, side / 2, side);
      if (enabled[2]) line(0, 0, side, side);
      if (enabled[3]) line(0, side, side, 0);
      if (enabled[4]) line(0, side / 2, side / 2, 0);
      if (enabled[5]) line(side / 2, 0, side, side / 2);
      if (enabled[6]) line(side, side / 2, side / 2, side);
      if (enabled[7]) line(side / 2, side, 0, side / 2);
      pop();
    }
  }
}
</script>
