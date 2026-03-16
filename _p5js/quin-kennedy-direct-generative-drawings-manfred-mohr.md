---
title: "Generative Drawings"
translator: "Quin Kennedy"
translator_url: "http://quinkennedy.github.com/"
slug: "quin-kennedy-direct-generative-drawings-manfred-mohr"
artwork_slug: "v1n4-generative-drawings"
category: "direct"
description: ""
runs_in_browser: false
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Generative Drawings" by Manfred Mohr
Originally published in "Computer Graphics and Art" v1n4, 1976
Copyright (c) 2012 Quin Kennedy - OSI/MIT license (http://recodeproject/license).
*/


const cellWidth = 30;
const boxSize = 7;
let numEdges = 9;
const cubeEdges = 12;
const numUnique = factorial(cubeEdges) / (factorial(numEdges) * factorial(cubeEdges - numEdges));
const numCellsWide = Math.ceil(Math.sqrt(numUnique));
const gutterWidth = 10;
const canvasWidth = numCellsWide * cellWidth + gutterWidth * 2;
const showMirror = true;
const closerMatch = true;

function factorial(n) {
  let output = 1;
  for (; n > 0; n--) {
    output *= n;
  }
  return output;
}

function setup() {
  createCanvas(canvasWidth * (showMirror ? 2 : 1), canvasWidth, WEBGL);
  noLoop();
}

function draw() {
  background(0);
  noFill();
  stroke(255);
  strokeWeight(1.5);
  ortho();
  drawGrid();
  drawSet();
  if (showMirror) {
    translate(width / 2, 0, 0);
    drawGrid();
    numEdges = cubeEdges - numEdges;
    drawSet();
  }
}

function drawSet() {
  push();
  let currCubeEdges = (closerMatch ? initCubeFlags() : 0);
  let rX = PI / 3;
  let rY = 0;
  let rZ = PI * 2 / 3;
  translate(gutterWidth + cellWidth / 2., numCellsWide * cellWidth + gutterWidth - cellWidth / 2., 0);
  for (let i = 0; i < numCellsWide; i++) {
    push();
    for (let j = 0; j < numCellsWide; j++) {
      push();
      rotateX(rX);
      rotateY(rY);
      rotateZ(rZ);
      scale(boxSize);
      if (closerMatch) {
        drawCube(currCubeEdges);
        currCubeEdges = getNextCube(currCubeEdges);
      } else {
        for (; currCubeEdges <= 0xfff; currCubeEdges++) {
          if (numFlags(currCubeEdges) == numEdges) {
            drawCube(currCubeEdges);
            currCubeEdges++;
            break;
          }
        }
      }
      pop();
      translate(0, -cellWidth, 0);
    }
    pop();
    translate(cellWidth, 0, 0);
  }
  pop();
}

function numFlags(f) {
  let output = 0;
  while (f > 0) {
    if ((f & 1) == 1) {
      output++;
    }
    f >>= 1;
  }
  return output;
}

function drawGrid() {
  let currX = gutterWidth;
  for (let i = 0; i <= numCellsWide; i++, currX += cellWidth) {
    line(currX, gutterWidth, currX, numCellsWide * cellWidth + gutterWidth);
    line(gutterWidth, currX, numCellsWide * cellWidth + gutterWidth, currX);
  }
}

function initCubeFlags() {
  let firstFlags = 0;
  for (let i = 0; i < numEdges; i++) {
    firstFlags <<= 1;
    firstFlags++;
  }
  return firstFlags;
}

function getNextCube(sideFlags) {
  return incrementFlags(sideFlags, cubeEdges - 1);
}

function incrementFlags(sideFlags, lastValidIndex) {
  let myMask = 1;
  let bitMask = 1;
  for (let i = 1; i <= lastValidIndex; i++) {
    bitMask <<= 1;
    myMask <<= 1;
    myMask++;
  }
  if ((sideFlags & bitMask) > 1) {
    // if there are no flags below us, we are done, return 0;
    if ((sideFlags & (myMask >> 1)) == 0) {
      return 0;
    }
    // move the flags below us
    let nextFlags = incrementFlags(sideFlags, lastValidIndex - 1);
    // if we receive 0, we are done with the whole series
    if (nextFlags == 0) {
      return 0;
    }
    // otherwise reset our flag to directly after theirs
    while (bitMask > 0 && (nextFlags & (bitMask >> 1)) == 0) {
      bitMask >>= 1;
    }
    return (nextFlags | bitMask);
  } else {
    // move this flag up by one position
    // find where the flag is
    while (bitMask > 0 && (sideFlags & (bitMask >> 1)) == 0) {
      bitMask >>= 1;
    }
    // mask my section, remove the current flag and add the new flag
    return (((sideFlags & myMask) ^ (bitMask >> 1)) | bitMask);
  }
}

function drawCube(sideFlags) {
  if (closerMatch) {
    if ((sideFlags & 0x1) != 0) {
      line(1, -1, -1, 1, 1, -1);
    }
    if ((sideFlags & 0x2) != 0) {
      line(1, 1, 1, 1, -1, 1);
    }
    if ((sideFlags & 0x4) != 0) {
      line(-1, -1, 1, -1, 1, 1);
    }
    if ((sideFlags & 0x8) != 0) {
      line(-1, -1, -1, 1, -1, -1);
    }
    if ((sideFlags & 0x10) != 0) {
      line(1, -1, -1, 1, -1, 1);
    }
    if ((sideFlags & 0x20) != 0) {
      line(-1, -1, 1, 1, -1, 1);
    }
    if ((sideFlags & 0x40) != 0) {
      line(-1, -1, -1, -1, -1, 1);
    }
    if ((sideFlags & 0x80) != 0) {
      line(-1, -1, -1, -1, 1, -1);
    }
    if ((sideFlags & 0x100) != 0) {
      line(-1, 1, -1, 1, 1, -1);
    }
    if ((sideFlags & 0x200) != 0) {
      line(1, 1, 1, 1, 1, -1);
    }
    if ((sideFlags & 0x400) != 0) {
      line(1, 1, 1, -1, 1, 1);
    }
    if ((sideFlags & 0x800) != 0) {
      line(-1, 1, -1, -1, 1, 1);
    }
  } else {
    if ((sideFlags & 0x1) != 0) {
      line(-1, -1, -1, -1, -1, 1);
    }
    if ((sideFlags & 0x2) != 0) {
      line(-1, -1, -1, -1, 1, -1);
    }
    if ((sideFlags & 0x4) != 0) {
      line(-1, -1, -1, 1, -1, -1);
    }
    if ((sideFlags & 0x8) != 0) {
      line(1, 1, 1, 1, 1, -1);
    }
    if ((sideFlags & 0x10) != 0) {
      line(1, 1, 1, 1, -1, 1);
    }
    if ((sideFlags & 0x20) != 0) {
      line(1, 1, 1, -1, 1, 1);
    }
    if ((sideFlags & 0x40) != 0) {
      line(-1, -1, 1, 1, -1, 1);
    }
    if ((sideFlags & 0x80) != 0) {
      line(-1, -1, 1, -1, 1, 1);
    }
    if ((sideFlags & 0x100) != 0) {
      line(-1, 1, -1, 1, 1, -1);
    }
    if ((sideFlags & 0x200) != 0) {
      line(-1, 1, -1, -1, 1, 1);
    }
    if ((sideFlags & 0x400) != 0) {
      line(1, -1, -1, 1, 1, -1);
    }
    if ((sideFlags & 0x800) != 0) {
      line(1, -1, -1, 1, -1, 1);
    }
  }
}
</script>
