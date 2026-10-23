---
title: "P211A"
translator: "Quin Kennedy"
translator_url: "http://quinkennedy.github.com/"
slug: "quin-kennedy-direct-p211a-manfred-mohr"
artwork_slug: "v3n1-p211a"
category: "direct"
description: ""
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "P211A" by Manfred Mohr
Originally published in "Computer Graphics and Art" v3n1, 1978
Copyright (c) 2012 Quin Kennedy - OSI/MIT license (http://recodeproject/license).
*/


const boxSize = 80;
const cellSize = 190;
const numCells = 7;
const gutter = 10;
const canvasWidth = cellSize * numCells + gutter * (numCells + 1);
const canvasHeight = cellSize + gutter * 2;
let edgePairs = [0, 1,
                 2, 3,
                 1, 3,
                 0, 2,

                 4, 5,
                 6, 7,
                 5, 7,
                 4, 6,

                 0, 4,
                 1, 5,
                 2, 6,
                 3, 7];
let endpoints = [];

function setup() {
  createCanvas(canvasWidth, canvasHeight, WEBGL);
  endpoints = new Array(edgePairs.length);
  noLoop();
}

function draw() {
  strokeJoin(ROUND);
  ortho(0, width, 0, height, -10000, 10000);
  background(255);

  let calcExtended = true;
  let rot = createVector(
                      random(TWO_PI),
                      random(TWO_PI),
                      random(TWO_PI));
  let rotV = createVector(
                      random(-QUARTER_PI / 4, QUARTER_PI / 4),
                      random(-QUARTER_PI / 4, QUARTER_PI / 4),
                      random(-QUARTER_PI / 4, QUARTER_PI / 4));

  for (let k = 0, minX = gutter, minY = gutter, maxX = gutter + cellSize, maxY = gutter + cellSize;
       k < numCells;
       k++, minX += gutter + cellSize, maxX += gutter + cellSize) {
    if (!calcExtended) {
      rot.add(rotV);
      for (let i = 0; i < edgePairs.length; i++) {
        endpoints[i].x += cellSize + gutter;
      }
    }
    // draw square
    drawSquare(minX, minY, maxX, maxY, calcExtended, rot);
    calcExtended = !calcExtended;
  }
}

function drawSquare(minX, minY, maxX, maxY, calcExtended, rot) {
  push();
  translate((minX + maxX) / 2., (minY + maxY) / 2., 0);
  // calculate extended points
  rotateX(rot.x);
  rotateY(rot.y);
  rotateZ(rot.z);
  scale(boxSize);
  noFill();
  stroke(0, 0, 0, 50);
  strokeWeight(2);
  box(1);
  let points = getVertices();
  pop();
  stroke(0);
  strokeWeight(2);
  for (let i = 0; i < edgePairs.length; i += 2) {
    if (calcExtended) {
      calcExtendEdge(i, i + 1, points, minX, minY, maxX, maxY);
    }
    extendEdge(i, i + 1, points);
  }
  stroke(200);
  strokeWeight(1);
  rect(minX, minY, cellSize, cellSize);
}

function getVertices() {
  let points = [];
  let c = 0;
  for (let i = -.5; i <= .5; i += 1) {
    for (let j = -.5; j <= .5; j += 1) {
      for (let k = -.5; k <= .5; k += 1, c++) {
        // Note: p5.js doesn't have modelX/Y/Z, we need to calculate manually
        points[c] = createVector(i * boxSize, j * boxSize, k * boxSize);
      }
    }
  }
  return points;
}

function calcExtendEdge(i1, i2, points, minX, minY, maxX, maxY) {
  let p1 = points[edgePairs[i1]];
  let p2 = points[edgePairs[i2]];
  let pV = p5.Vector.sub(p2, p1);
  let nX = (minX - p1.x) / pV.x;
  let nY = (minY - p1.y) / pV.y;
  let nX2 = (maxX - p1.x) / pV.x;
  let nY2 = (maxY - p1.y) / pV.y;
  let n = Number.MAX_VALUE;
  let n2 = -Number.MAX_VALUE;
  let all = [nX, nY, nX2, nY2];
  for (let j = 0; j < all.length; j++) {
    if (all[j] > 0 && all[j] < n) {
      n = all[j];
    } else if (all[j] < 0 && all[j] > n2) {
      n2 = all[j];
    }
  }
  let pF = p5.Vector.add(p1, p5.Vector.mult(pV, n));
  let pF2 = p5.Vector.add(p1, p5.Vector.mult(pV, n2));
  endpoints[i1] = pF2;
  endpoints[i2] = pF;
}

function extendEdge(i1, i2, points) {
  let p1 = points[edgePairs[i1]];
  let p2 = points[edgePairs[i2]];
  let pF = endpoints[i2];
  let pF2 = endpoints[i1];
  line(p2.x, p2.y, p2.z, pF.x, pF.y, pF.z);
  line(p1.x, p1.y, p2.z, pF2.x, pF2.y, pF2.z);
}
</script>
