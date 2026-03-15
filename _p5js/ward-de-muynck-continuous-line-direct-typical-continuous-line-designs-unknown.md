---
title: "Continuous line"
translator: "Ward De Muynck"
translator_url: "http://www.liquid-media.com/"
slug: "ward-de-muynck-continuous-line-direct-typical-continuous-line-designs-unknown"
artwork_slug: "v2n3-typical-continuous-line-designs"
category: "direct"
description: "A continuous line"
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Typical Continuous Line Designs" by Unknown
Originally published in "Computer Graphics and Art" v2n3, 1977
Copyright (c) 2013 Ward De Muynck - OSI/MIT license (http://recodeproject/license).
*/

let startX = 100;
let startY = 100;
let endX = 200;
let endY = 200;

let firstX = startX;
let firstY = startX;

let totalLines = 9;

function setup() {
  createCanvas(400, 400);
  noLoop();
}

function draw() {
  background(255);

  for (let x = 0; x < totalLines; x++) {
    strokeWeight(2);
    // stroke(255, 0, 0);
    strokeJoin(ROUND);
    startX = endX;
    startY = endY;
    // stay 10px from the border
    endX = int(random(10, width - 10));
    endY = int(random(10, height - 10));

    liner(endX, endY, startX, startY);
    // add arrow to first line
    if (x < 1) {
      arrow(firstX, firstY, startX, startY);
    }
    if (x > totalLines - 2) {
      stroke(27);
      liner(endX, endY, firstX, firstY);
    }
  }
}

function liner(x1, y1, x2, y2) {
  line(x1, y1, x2, y2);
  push();
  translate(x2, y2);
  pop();
}

function arrow(x1, y1, x2, y2) {
  line(x1, y1, x2, y2);
  push();
  translate(x2, y2);
  let a = atan2(x1 - x2, y2 - y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  pop();
}
</script>
