---
title: "Square Spiral"
translator: "Yuri Popov"
translator_url: ""
slug: "yuri-popov-square-spiral-experimental-untitled-3-hans-korneder"
artwork_slug: "v3n2-untitled-3-korneder"
category: "experimental"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 3" by Hans Korneder
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2014 Yuri Popov - OSI/MIT license (http://recodeproject/license).
*/

let angle = 5, _size = 200, step = 2;
let steps = 100, len = 1;
let angs = [];

function setup() {
  createCanvas(800, 400);
  rectMode(CENTER);

  angs[0] = 0;

  for (let i = 1; i < steps; i++) {
    angs[i] = angs[i - 1] + TWO_PI / steps;
  }
}

function draw() {
  background(0);
  translate(width * 0.5, height * 0.5);

  for (let i = 0; i < len; i++) {
    fill(204 / steps * i, 12 / steps * i, 100 / steps * i);

    push();
    rotate(angs[i]);
    let side = _size - (step * i);
    rect(0, 0, side, side);
    pop();
  }

  if (frameCount % 2 === 0) len++;
  if (len === angs.length) len = 1;
}
</script>
