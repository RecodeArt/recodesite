---
title: "Untitled"
translator: "Quin Kennedy"
translator_url: "http://kamikazepirate.com/"
slug: "quin-kennedy-direct-untitled-vera-molnar"
artwork_slug: "v3n2-untitled-veramolnar"
category: "direct"
description: "From the Trapezium series.  Refresh the page to redraw."
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled" by Vera Molnar
Originally published in "Computer Graphics and Art" vol3 no2, 1978
Copyright (c) 2012 Quin Kennedy - OSI/MIT license (http://recodeproject/license).
*/

const numTiles = 14;
const gutterRelativeSize = 0;
const windowSize = 400;
// We need space for each tile, space for each gutter to the left of each tile,
// and space for the final gutter (to the right of the final tile)
const tileSize = Math.floor(windowSize / (numTiles * (1 + gutterRelativeSize) + gutterRelativeSize));
const gutterSize = Math.floor(tileSize * gutterRelativeSize);

function setup() {
  let actualWinSize = (tileSize + gutterSize) * numTiles + gutterSize;
  createCanvas(actualWinSize, actualWinSize);
  noLoop();
}

function draw() {
  background(255);
  stroke(0);
  strokeJoin(ROUND);
  noFill();

  // For each grid cell...
  for (let i = 0, gi = gutterSize; i < numTiles; i++, gi += gutterSize + tileSize) {
    for (let j = 0, gj = gutterSize; j < numTiles; j++, gj += gutterSize + tileSize) {
      drawTrapezium(random(tileSize, width - tileSize - tileSize), random(tileSize / 2, height - tileSize));
    }
  }
}

function drawTrapezium(xCenter, yCenter) {
  let halfTile = tileSize / 2;
  quad(xCenter - tileSize / 2 + random(-tileSize, tileSize), yCenter - halfTile,
       xCenter + tileSize / 2 + random(-tileSize, tileSize), yCenter - halfTile,
       xCenter + tileSize / 2 + random(-tileSize, tileSize), yCenter + halfTile,
       xCenter - tileSize / 2 + random(-tileSize, tileSize), yCenter + halfTile);
}
</script>
