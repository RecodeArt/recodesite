---
title: "Zup Tze 30 Complexities"
translator: "Karl Rothermel"
translator_url: ""
slug: "karl-rothermel-zup-tze-30-complexities-experimental-zup-tze-30-paul-shao"
artwork_slug: "v3n2-zup-tze-30"
category: "experimental"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Zup Tze 30" by Paul Shao
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2013 Karl Rothermel - OSI/MIT license (http://recodeproject/license).
*/

const LINE_WIDTH = 1;

function setup() {
  createCanvas(512, 360);
}

// Draws a single cross.
function drawCross(left, top, dim, thickness) {
  let offset_1 = dim/2 - thickness/4;
  let offset_2 = offset_1 + thickness;
  let offset_3 = dim;

  beginShape();
  vertex(left + offset_1, top);
  vertex(left + offset_2, top);
  vertex(left + offset_2, top + offset_1);
  vertex(left + offset_3, top + offset_1);
  vertex(left + offset_3, top + offset_2);
  vertex(left + offset_2, top + offset_2);
  vertex(left + offset_2, top + offset_3);
  vertex(left + offset_1, top + offset_3);
  vertex(left + offset_1, top + offset_2);
  vertex(left, top + offset_2);
  vertex(left, top + offset_1);
  vertex(left + offset_1, top + offset_1);
  vertex(left + offset_1, top);
  endShape(CLOSE);
}

// Draw a stack of crosses.
function drawCrossWithDecay(left, top, base_dim, num_decay, dpos, ddim, dthickness) {
  let thickness = base_dim/2;
  let dim = base_dim;
  let curleft = left;
  let curtop = top;

  for (let i = 0; i < num_decay; i++) {
    drawCross(curleft, curtop, dim, thickness);
    curleft += dpos.x + ddim/2;
    curtop += dpos.y + ddim/2;
    dim -= ddim;
    thickness -= dthickness;
  }
}

function drawCrossMatrix(dim, left, top, rows, cols) {
  let thickness = dim/2;
  let dp1 = createVector(0, -1);
  let dp2 = createVector(1, 0);
  let dp;

  for (let i = 0; i < rows; i++) {
    let rleft = left + i * thickness;
    let rtop = top + i * 1 * thickness;

    for (let j = 0; j < cols; j++) {
      dp = (i % 2 == 0) ? dp1.copy() : dp2.copy();
      dp.mult(-1);
      drawCrossWithDecay(rleft + thickness * 2 * j, rtop - thickness * j, dim, 8, dp, 4, 4.5);
    }
  }
}

function draw() {
  background(255);
  drawCrossMatrix(49, 60, 150, 6, 6);
}
</script>
