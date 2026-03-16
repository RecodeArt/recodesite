---
title: "P197A"
translator: "Quin Kennedy"
translator_url: "http://quinkennedy.github.com/"
slug: "quin-kennedy-direct-p197a-manfred-mohr"
artwork_slug: "v3n1-p197a"
category: "direct"
description: ""
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "P197A" by Manfred Mohr
Originally published in "Computer Graphics and Art" v3n1, 1978
Copyright (c) 2012 Quin Kennedy - OSI/MIT license (http://recodeproject/license).
*/


const idealCanvasSize = 600;
const numCellsWide = 8;
const boxSize = 300 / (numCellsWide + 2) / 2 * 2; // we want it to be even
const gutterRatio = 1;
const cellWidth = Math.floor(idealCanvasSize / (numCellsWide + gutterRatio * 2)) / 2 * 2; // we want an even number
const gutterWidth = Math.floor(cellWidth * gutterRatio);
const actualCanvasSize = cellWidth * numCellsWide + gutterWidth * 2;
const gutterBleed = .5;

function setup() {
  createCanvas(actualCanvasSize, actualCanvasSize, WEBGL);
  pixelDensity(4);
  noLoop();
}

function draw() {
  drawV1();
}

function drawV1() {
  background(255);
  let topLight = createGraphics(cellWidth, cellWidth, WEBGL);
  let bottomLight = createGraphics(cellWidth, cellWidth, WEBGL);
  let topHeavy = createGraphics(cellWidth, cellWidth, WEBGL);
  let bottomHeavy = createGraphics(cellWidth, cellWidth, WEBGL);

  let halfCellWidth = cellWidth / 2;
  let currOffsetX = gutterWidth;
  let currOffsetY;
  for (let i = 0; i < numCellsWide; i++, currOffsetX += cellWidth) {
    currOffsetY = gutterWidth;
    for (let j = 0; j < numCellsWide; j++, currOffsetY += cellWidth) {
      // render the source material
      let rX = random(TWO_PI);
      let rY = random(TWO_PI);
      let rZ = random(TWO_PI);
      drawBox(topLight, rX, rY, rZ, .8, 255);
      drawBox(topHeavy, rX, rY, rZ, 2, 255);
      rX = random(TWO_PI);
      rY = random(TWO_PI);
      rZ = random(TWO_PI);
      drawBox(bottomLight, rX, rY, rZ, .8, 255);
      drawBox(bottomHeavy, rX, rY, rZ, 2, 255);

      // draw as appropriate,
      // this would be better to do with viewports and scissor oporations,
      // but I can't figure out how to do that in Processing
      copy(topLight, 0, 0, halfCellWidth, cellWidth, currOffsetX, currOffsetY, halfCellWidth, cellWidth);
      copy(bottomLight, halfCellWidth, 0, halfCellWidth, cellWidth, currOffsetX + halfCellWidth, currOffsetY, halfCellWidth, cellWidth);
      let pX = (cellWidth - boxSize) / 2;
      let pY = (cellWidth - boxSize) / 2;
      let cW = boxSize / 2;
      let cH = boxSize;
      copy(topHeavy, pX, pY, cW, cH, currOffsetX + pX, currOffsetY + pY, cW, cH);
      pX += boxSize / 2;
      copy(bottomHeavy, pX, pY, cW, cH, currOffsetX + pX, currOffsetY + pY, cW, cH);
    }
  }
}

function drawBox(g, rotX, rotY, rotZ, weight, backgroundColor) {
  g.push();
  g.ortho();
  g.background(backgroundColor);

  // draw horizontal line
  g.stroke(0);
  g.strokeWeight(1);
  g.line(0, g.height / 2, -boxSize * 3, g.width, g.height / 2, -boxSize * 3);

  // cover the horizontal line
  g.push();
  g.translate(g.width / 2, g.height / 2, -boxSize * 2);
  g.rotateX(rotX);
  g.rotateY(rotY);
  g.rotateZ(rotZ);
  g.noStroke();
  g.fill(backgroundColor);
  g.box(boxSize);
  g.pop();

  // now draw the cube outline
  g.push();
  g.translate(g.width / 2, g.height / 2, 0);
  g.rotateX(rotX);
  g.rotateY(rotY);
  g.rotateZ(rotZ);
  g.stroke(0);
  g.strokeWeight(weight);
  g.noFill();
  g.box(boxSize);
  g.pop();

  // draw vertical line
  g.strokeWeight(1);
  g.line(g.width / 2, 0, boxSize, g.width / 2, g.height, boxSize);
  g.pop();
}

function drawGrid(bHorizontal) {
  let currOffset = gutterWidth + cellWidth / 2;
  let visualGutter = gutterWidth - (Math.floor(gutterWidth * gutterBleed));
  for (let i = 0; i < numCellsWide; i++, currOffset += cellWidth) {
    if (bHorizontal) {
      line(visualGutter, currOffset, -boxSize * 3, width - visualGutter, currOffset, -boxSize * 3);
    } else {
      line(currOffset, visualGutter, boxSize, currOffset, height - visualGutter, boxSize);
    }
  }
}
</script>
