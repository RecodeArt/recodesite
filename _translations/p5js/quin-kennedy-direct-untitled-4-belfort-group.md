---
title: "Untitled 4"
translator: "Quin Kennedy"
translator_url: "http://kamikazepirate.com/"
slug: "quin-kennedy-direct-untitled-4-belfort-group"
artwork_slug: "v1n3-untitled-4"
category: "direct"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 4" by The Belfort Group
Originally published in "Computer Graphics and Art" vol1 no3, 1976
Copyright (c) 2012 Quin Kennedy - OSI/MIT license (http://recodeproject/license).
*/

let tiles = [];
const windowSize = 400;
const tileSize = windowSize / 5;

function setup() {
  createCanvas(windowSize, windowSize);
  createTiles();
  noLoop();
}

function draw() {
  background(255);
  imageMode(CENTER);

  for (let i = 0; i < width; i += tileSize) {
    for (let j = 0; j < height; j += tileSize) {
      let tile = Math.floor(random(tiles.length));
      let rotation = Math.floor(random(4));

      push();
      translate(i, j);
      translate(tileSize / 2, tileSize / 2);
      rotate(PI * rotation / 2);
      image(tiles[tile], 0, 0);
      pop();
    }
  }
}

function createTiles() {
  // Quarter circle white on black
  let pg = createGraphics(tileSize, tileSize);
  pg.background(0);
  pg.noStroke();
  pg.fill(255);
  pg.ellipse(0, 0, tileSize * 2, tileSize * 2);
  tiles.push(pg);

  // Quarter circle black on white
  let pg1 = createGraphics(tileSize, tileSize);
  pg1.background(255);
  pg1.noStroke();
  pg1.fill(0);
  pg1.ellipse(0, 0, tileSize * 2, tileSize * 2);
  tiles.push(pg1);

  // Half rectangle white on black
  let pg2 = createGraphics(tileSize, tileSize);
  pg2.background(0);
  pg2.noStroke();
  pg2.fill(255);
  pg2.rect(0, 0, tileSize, tileSize / 2);
  tiles.push(pg2);

  // Half rectangle black on white
  let pg3 = createGraphics(tileSize, tileSize);
  pg3.background(255);
  pg3.noStroke();
  pg3.fill(0);
  pg3.rect(0, 0, tileSize, tileSize / 2);
  tiles.push(pg3);

  // Triangle white on black
  let pg4 = createGraphics(tileSize, tileSize);
  pg4.background(0);
  pg4.noStroke();
  pg4.fill(255);
  pg4.triangle(0, 0, tileSize, 0, 0, tileSize);
  tiles.push(pg4);

  // Triangle black on white
  let pg5 = createGraphics(tileSize, tileSize);
  pg5.background(255);
  pg5.noStroke();
  pg5.fill(0);
  pg5.triangle(0, 0, tileSize, 0, 0, tileSize);
  tiles.push(pg5);

  // Solid black
  let pg6 = createGraphics(tileSize, tileSize);
  pg6.background(0);
  tiles.push(pg6);
}
</script>
