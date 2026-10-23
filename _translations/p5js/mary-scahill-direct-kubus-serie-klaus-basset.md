---
title: "Kube Series"
translator: "Mary Scahill"
translator_url: ""
slug: "mary-scahill-direct-kubus-serie-klaus-basset"
artwork_slug: "v1n2-kubus-serie"
category: "direct"
description: ", but appears slightly different than it does when run in the Processing IDE."
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Kubus Serie" by Klaus Basset
Originally published in "Computer Graphics and Art" vol1 no2, 1976
Copyright (c) 2012 Mary Scahill - OSI/MIT license (http://recodeproject/license).
*/


// these values refer to the overal height of each row and column of the grid
let rowHeight = 9;
let colWidth = 7;
// these arrays store the necessary translation values for each cube
let transX = [14, 17, -17, 17, -26, 17, -17, 17];
let transY = [13, 0, 17, 0, -26, 0, 17, 0];

function setup() {
  createCanvas(387, 479);
  background(255);
  stroke(0);
  strokeWeight(1);

  fill(255);

  // calls upon function for drawing a rectangle of ellipses
  ellipseRect(7, 9, width - 14, height - 18);

  for (let i = 0; i < 8; i++) {
    translate(transX[i] * colWidth, transY[i] * rowHeight);
    fill(255);
    noStroke();
    rect(-2, -4, 91, 117); // this is just here so that the cross texture will be opaque
    stroke(0);
    crossRect(0, 0, 91, 117); // draws crosses (or plus signs) on top of white rectangles
    parallelDashEllipse(91, 0, 49, 126); // draws dashes within ellipses in parallelogram
    parallelCrossEllipse(7, 117, 84, 63); // draws crosses within ellipses in parallelogram
  }

  noLoop();
}

function draw() {
}

// function for drawing cross
function drawCross(xPos, yPos, lineLength) {
  let lineAx = xPos - floor(lineLength / 2);
  let lineAx2 = xPos + floor(lineLength / 2);
  let lineBy = yPos - floor(lineLength / 2);
  let lineBy2 = yPos + floor(lineLength / 2);
  line(lineAx, yPos, lineAx2, yPos);
  line(xPos, lineBy, xPos, lineBy2);
}

// function for drawing dash
function drawDash(xPos, yPos, lineLength) {
  let lineAx = xPos - floor(lineLength / 2);
  let lineAx2 = xPos + floor(lineLength / 2);
  line(lineAx, yPos, lineAx2, yPos);
}

// function for drawing a rectangle filled with crosses
function crossRect(xPos, yPos, rectWidth, rectHeight) {
  for (let i = xPos; i < xPos + rectWidth; i += 7) {
    for (let j = yPos; j < yPos + rectHeight; j += 9) {
      drawCross(i, j, 4);
    }
  }
}

// function for drawing rectangle filled with dashes
function dashRect(xPos, yPos, rectWidth, rectHeight) {
  for (let i = xPos; i < xPos + rectWidth; i += 7) {
    for (let j = yPos; j < yPos + rectHeight; j += 9) {
      drawDash(i, j, 4);
    }
  }
}

// function for drawing rectangle filled with ellipses
function ellipseRect(xPos, yPos, rectWidth, rectHeight) {
  fill(255);
  for (let i = xPos; i < xPos + rectWidth; i += 7) {
    for (let j = yPos; j < yPos + rectHeight; j += 9) {
      ellipse(i, j, 7, 7);
    }
  }
}

// function for drawing parallelogram filled with ellipses
function parallelEllipse(xPos, yPos, paraWidth, sideHeight) {
  fill(255);
  let h = 0;
  for (let i = 0; i < paraWidth; i += 7) {
    for (let j = h; j < sideHeight + h; j += 9) {
      ellipse(xPos + i, yPos + j, 7, 7);
    }
    h += 9;
  }
}

// function for drawing parallelogram filled with crosses
function parallelCross(xPos, yPos, paraWidth, sideHeight) {
  fill(255);
  let h = 0;
  for (let i = 0; i < paraWidth; i += 7) {
    for (let j = h; j < sideHeight + h; j += 9) {
      drawCross(xPos + i, yPos + j, 4);
    }
    h += 9;
  }
}

// function for drawing parallelogram filled with dashes
function parallelDash(xPos, yPos, paraWidth, sideHeight) {
  let h = 0;
  for (let i = 0; i < paraWidth; i += 7) {
    for (let j = h; j < sideHeight + h; j += 9) {
      drawDash(xPos + i, yPos + j, 4);
    }
    h += 9;
  }
}

// function for drawing parallelogram filled with crosses and ellipses
function parallelCrossEllipse(xPos, yPos, paraWidth, sideHeight) {
  fill(255);
  let h = 0;
  for (let i = h; i < sideHeight; i += 9) {
    for (let j = 0; j < paraWidth; j += 7) {
      ellipse(xPos + h + j, yPos + i, 7, 7);
      drawCross(xPos + h + j, yPos + i, 4);
    }
    h += 7;
  }
}

// function for drawing parallelogram filled with dashed and ellipses
function parallelDashEllipse(xPos, yPos, paraWidth, sideHeight) {
  fill(255);
  let h = 0;
  for (let i = 0; i < paraWidth; i += 7) {
    for (let j = h; j < sideHeight + h; j += 9) {
      ellipse(xPos + i, yPos + j, 7, 7);
      drawDash(xPos + i, yPos + j, 4);
    }
    h += 9;
  }
}
</script>
