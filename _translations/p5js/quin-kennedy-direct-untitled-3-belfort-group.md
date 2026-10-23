---
title: "Untitled 3"
translator: "Quin Kennedy"
translator_url: "http://kamikazepirate.com/"
slug: "quin-kennedy-direct-untitled-3-belfort-group"
artwork_slug: "v1n3-untitled-3"
category: "direct"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 3" by Belfort Group
Originally published in "Computer Graphics and Art" vol1 no3, 1976
Copyright (c) 2012 Quin Kennedy - OSI/MIT license (http://recodeproject/license).
*/

let points = [];
const windowSize = 400;
const tileSize = windowSize / 6;

function setup() {
  createCanvas(windowSize, windowSize);
  noLoop();

  // Initialize points array
  points = [
    createVector(0, 0),
    createVector(1/3, 1/3),
    createVector(2/3, 2/3),
    createVector(4/3, 4/3),
    createVector(5/3, 5/3),
    createVector(2, 2)
  ];
}

function draw() {
  background(255);
  imageMode(CENTER);

  for (let i = 0; i < width; i += tileSize) {
    for (let j = 0; j < height; j += tileSize) {
      let pg = createGraphics(tileSize, tileSize);
      pg.background(255);
      pg.noStroke();
      pg.fill(0);
      pg.scale(tileSize);

      let black = random(2) >= 1;
      for (let k = 1; k < points.length; k++) {
        black = random(1) > 0.75 ? black : !black;
        if (!black) {
          continue;
        }
        pg.quad(points[k-1].x, 0, points[k].x, 0, 0, points[k].y, 0, points[k-1].y);
      }

      push();
      translate(i, j);
      translate(tileSize / 2, tileSize / 2);
      rotate(PI / 2);
      image(pg, 0, 0);
      pop();
    }
  }
}
</script>
