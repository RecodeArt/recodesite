---
title: "P5Aeleana"
translator: "Makio135"
translator_url: ""
slug: "makio135-p5aeleana-direct-aeleana-manuel-barbadillo"
artwork_slug: "v1n2-aeleana"
category: "direct"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Aeleana" by Manuel Barbadillo
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2013 Makio135 - OSI/MIT license (http://recodeproject/license).
*/

function setup() {
  createCanvas(400, 400);
  drawPattern(0, 0, 200, true, 0);
  drawPattern(200, 0, 200, false, PI/2);
  drawPattern(0, 200, 200, false, -PI/2);
  drawPattern(200, 200, 200, true, PI);
  noLoop();
}

function drawPattern(x, y, Size, black, angle) {
  let pg = createGraphics(200, 200);
  pg.noStroke();
  pg.background(black ? 0 : 255);
  pg.push();
  pg.translate(Size/2, Size/2);
  pg.rotate(angle);
  pg.fill(black ? 255 : 0);
  pg.rect(-125, -100, Size + 25, Size, 25, 25);
  pg.fill(black ? 0 : 255);
  pg.rect(-125, -100, Size, Size - 25, 25, 25);

  for (let i = 0; i < 6; i++) {
    black = !black;
    pg.fill(black ? 0 : 255);
    pg.rect(-125, -125, Size/2 + 25, 175 - i * 25, 25, 25);
  }

  for (let i = 0; i < 4; i++) {
    black = !black;
    pg.fill(black ? 0 : 255);
    let cornerRadius = (Size/2 - i * 25 > 25) ? 25 : 15;
    pg.rect(0, -Size/2 + i * 25, Size/2 - i * 25, (i == 0) ? Size/2 : Size - (2 * i) * 25, cornerRadius, cornerRadius);
  }

  pg.pop();

  image(pg, x, y);
}
</script>
