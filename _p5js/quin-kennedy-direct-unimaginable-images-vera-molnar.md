## /\*

title: "Unimaginable Images"
translator: "Quin Kennedy"
translator_url: "http://kamikazepirate.com/"
slug: "quin-kennedy-direct-unimaginable-images-vera-molnar"
artwork_slug: "v3n2-unimaginable-images"
category: "direct"
description: ""
runs_in_browser: true
p5_version: 1.11.10

---

<script type="text/javascript">
*/
/*
Part of the ReCode Project(http://recodeproject.com)
  Based on "Unimaginable Images" by Vera Molnar
Originally published in "Computer Graphics and Art" vol3 no2, 1978
Copyright(c) 2012 Quin Kennedy - OSI / MIT license(http://recodeproject/license).
*/

// (from the "196 Trapeziums Series")

const numTiles = 14;
const gutterRelativeSize = .5;
const windowSize = 400;
// we need space for each tile,
// space for each gutter above each tile,
// and space for the final gutter (below of the bottom row)
const tileSize = Math.floor(windowSize / (numTiles _(1 + gutterRelativeSize) + gutterRelativeSize));
const gutterSize = Math.floor(tileSize _ gutterRelativeSize);

function setup() {
  let actualWinSize = (tileSize + gutterSize) \* numTiles + gutterSize;
  createCanvas(actualWinSize, actualWinSize);
  noLoop();
}

function draw() {
  background(255);
  stroke(0);
  strokeJoin(ROUND);
  noFill();
  // for each grid cell...
  for (let i = 0, gi = gutterSize; i < numTiles; i++, gi += gutterSize + tileSize) {
    for (let j = 0, gj = gutterSize; j < numTiles; j++, gj += gutterSize + tileSize) {
      drawTrapezium(gi + tileSize / 2, gj + tileSize / 2);
    }
  }
}

function drawTrapezium(xCenter, yCenter) {
  let topScale = random(-2, 2);
  let bottomScale = random(-2, 2);
  let halfTile = tileSize / 2.;
  quad(xCenter - tileSize / 2 + random(-tileSize, tileSize), yCenter - halfTile,
    xCenter + tileSize / 2 + random(-tileSize, tileSize), yCenter - halfTile,
    xCenter + tileSize / 2 + random(-tileSize, tileSize), yCenter + halfTile,
    xCenter - tileSize / 2 + random(-tileSize, tileSize), yCenter + halfTile);
}
</script>
