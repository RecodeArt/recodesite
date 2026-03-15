---
title: "Detail from Tapestry"
translator: "Juan Sebastian Robles"
translator_url: ""
slug: "juan-sebastian-robles-detail-from-tapestry-direct-detail-from-tapestry-jean-claude-marquette"
artwork_slug: "v1n2-detail-from-tapestry"
category: "direct"
description: 'A free adaptation/interpretation of the original piece, with a bit of extra "little variation"'
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Detail from Tapestry" by Jean Claude Marquette
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2020 Juan Sebastian Robles - OSI/MIT license (http://recodeproject/license).
*/

let lim;

function setup() {
  createCanvas(416, 500);
  fill(63);
  noStroke();
  lim = random();
  background(240 * (lim * 10));
  drawSquares();
}

function drawSquare(x, y) {
  for (let i = 0; i < 26; i += 2) {
    for (let j = 0; j < 26; j += 2) {
      if (random() > lim) {
        rect(x + i, y + j, 2, 2);
      }
    }
  }
}

function drawSquares() {
  for (let i = round(random(-10, 10)); i < 20; i++) {
    for (let j = round(random(-10, 10)); j < 20; j++) {
      if (random() > lim) {
        drawSquare(i * 26, j * 26);
      }
    }
  }
}

function mousePressed() {
  lim = random();
  background(240 * (lim * 10));
  drawSquares();
}
</script>
