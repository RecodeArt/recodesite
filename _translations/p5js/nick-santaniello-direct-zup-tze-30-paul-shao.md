---
title: "Crosses"
translator: "Nick Santaniello"
translator_url: "http://www.robysoft.net/"
slug: "nick-santaniello-direct-zup-tze-30-paul-shao"
artwork_slug: "v3n2-zup-tze-30"
category: "direct"
description: "None"
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Zup Tze 30" by Paul Shao
Originally published in "Computer Graphics and Art" vol3 no2, 1978
Copyright (c) 2012 Nick Santaniello - OSI/MIT license (http://recodeproject/license).
*/

function setup() {
  createCanvas(800, 800);
  rectMode(CENTER);
  strokeWeight(2);

  // Create 36 crosses.
  let crosses = new Array(36);
  translate(100, 300);

  // for every row...
  for (let r = 0; r < 6; r++) {
    // for every column...
    for (let c = 0; c < 6; c++) {
      push();
      translate(80 * c + r * 40, -40 * c + r * 80);

      // rotate 180 degrees per column.
      rotate(PI * c);

      // rotate 90 degrees per row
      rotate(PI / 2 * r);

      let newCross = new Cross(0, 0);
      newCross.display();
      pop();
    }
  }

  noLoop();
}

function draw() {
}


class Cross {
  constructor(xVal, yVal) {
    this.baseW = 40;
    this.baseH = 120;
    this.sizeDifference = 8;
    this.x = xVal;
    this.y = yVal;
    this.offset = 2;
  }

  display() {
    // I draw each cross as two intersecting rectangles.
    // By drawing two rectangles and a small white square in the middle, I can leverage rectMode(CENTER) as opposed to maintaining 12 seperate line segments per cross. This is my justification for this hack.

    rect(this.x, this.y, this.baseW, this.baseH);
    rect(this.x, this.y, this.baseH, this.baseW);
    // draw the white box
    stroke(255);
    rect(this.x, this.y, this.baseW, this.baseW);
    stroke(0);

    // draw 4 crosses inside each cross.
    for (let i = 1; i <= 4; i++) {
      let w = this.baseW - i * this.sizeDifference;
      let h = this.baseH - i * this.sizeDifference;
      rect(this.x, this.y + this.offset * i, w, h);
      rect(this.x, this.y + this.offset * i, h, w);
      stroke(255);
      rect(this.x, this.y + this.offset * i, w, w);
      stroke(0);
    }
  }
}
</script>
