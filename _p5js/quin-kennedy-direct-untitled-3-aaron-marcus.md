---
title: "Untitled 3"
translator: "Quin Kennedy"
translator_url: "http://quinkennedy.github.com/"
slug: "quin-kennedy-direct-untitled-3-aaron-marcus"
artwork_slug: "v3n2-untitled-3-marcus"
category: "direct"
description: ""
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Untitled 3" by Aaron Marcus
Originally published in "Computer Graphics and Art" v3n2, 1978
Copyright (c) 2012 Quin Kennedy - OSI/MIT license (http://recodeproject/license).
*/

const numLines = 21;
const numShapes = 7;
const lineHalfHeight = 16;
const borderPixelSize = 15;
const canvasSize = numLines * 2 * lineHalfHeight + borderPixelSize * 2;
const aspectRatio = 670 / 700; // taken from reproduction in PDF
const defaultStep = Math.floor(lineHalfHeight / 3);
const longDiagWidth = Math.tan(radians(30)) * lineHalfHeight;
const shortDiagWidth = Math.tan(radians(30)) * (lineHalfHeight / 2);

function setup() {
  // The combination of 1.5 stroke and no smoothing creates an attractive raw look
  createCanvas(Math.floor(canvasSize * aspectRatio), canvasSize);
  noLoop();
}

function draw() {
  background(0);
  stroke(255);
  noFill();
  strokeWeight(1.5);
  strokeJoin(MITER);
  strokeCap(PROJECT);

  push();
  translate(borderPixelSize, borderPixelSize + lineHalfHeight);
  for (let i = 0; i < numLines; i++) {
    drawLine();
    translate(0, lineHalfHeight * 2);
  }
  pop();
}

function drawLine() {
  push();
  let pixelsRemaining = width - borderPixelSize * 2;
  let pixelsPrevious = 0;
  line(0, 0, pixelsRemaining, 0);

  while (pixelsRemaining > 0) {
    let rightSideUpFirst = random(1) < 0.5;
    let shapeIndex = Math.floor(random(numShapes));

    // Small items are more common, quick hack
    if (shapeIndex >= 2 && random(1) < 0.5) {
      shapeIndex = Math.floor(random(2));
    }
    // Large arcs are less common, quick hack
    if (shapeIndex === 6 && random(1) < 0.5) {
      shapeIndex = Math.floor(random(numShapes - 1));
    }

    let pixelsUsed = drawShape(shapeIndex, pixelsRemaining, pixelsPrevious, rightSideUpFirst);
    if (shapeIndex < 3) {
      shapeIndex = Math.floor(random(3));
      pixelsUsed = Math.max(pixelsUsed, drawShape(shapeIndex, pixelsRemaining, pixelsPrevious, !rightSideUpFirst));
    }
    translate(pixelsUsed, 0);
    pixelsRemaining -= pixelsUsed;
    pixelsPrevious += pixelsUsed;
  }
  translate(pixelsRemaining, 0);
  drawShape(0, defaultStep, pixelsPrevious, true);
  pop();
}

function drawShape(i, pixelsRemaining, pixelsPrevious, rightSideUp) {
  push();
  let toReturn = defaultStep;

  if (!rightSideUp) {
    switch(i) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        rotate(PI);
        break;
    }
  }

  let forward = random(1) < 0.5;

  switch(i) {
    case 0: // short vertical
      line(0, -lineHalfHeight / 2, 0, 0);
      break;

    case 1: // short diagonal
      if ((forward ? pixelsRemaining : pixelsPrevious) < Math.ceil(shortDiagWidth)) {
        toReturn = 0;
        break;
      }
      line(random(1) < 0.5 ? -shortDiagWidth : shortDiagWidth, -lineHalfHeight / 2, 0, 0);
      break;

    case 2: // blank
      break;

    case 3: // long diagonal
      if (pixelsRemaining < Math.ceil(longDiagWidth) || pixelsPrevious < Math.ceil(longDiagWidth)) {
        toReturn = 0;
        break;
      }
      line(forward ? longDiagWidth : -longDiagWidth, -lineHalfHeight,
           forward ? -longDiagWidth : longDiagWidth, lineHalfHeight);
      break;

    case 4: // long vertical
      line(0, -lineHalfHeight, 0, lineHalfHeight);
      break;

    case 5: // small circle
      ellipse(0, -lineHalfHeight / 2, lineHalfHeight / 4, lineHalfHeight / 4);
      break;

    case 6: // large arc
      if (pixelsRemaining < lineHalfHeight * 2) {
        toReturn = 0;
        break;
      }
      arc(lineHalfHeight, 0, lineHalfHeight * 2, lineHalfHeight * 2,
          rightSideUp ? PI : 0,
          rightSideUp ? TWO_PI : PI);
      toReturn = lineHalfHeight * 2 + defaultStep;
      break;
  }
  pop();
  return toReturn;
}
</script>
