---
title: "Moving Cube"
translator: "chimanaco"
translator_url: "http://chimana.co/sketch/"
slug: "chimanaco-moving-cube-experimental-the-cube-theme-and-variation-edward-zajec"
artwork_slug: "v1n2-the-cube-theme-and-variation"
category: "experimental"
description: ""
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "The Cube Theme and Variation" by Edward Zajec
Originally published in "Computer Graphics and Art" v1n2, 1976
Copyright (c) 2013 chimanaco - OSI/MIT license (http://recodeproject/license).
*/

//---------
// GLOBALS
//---------

let bgColor;
let drawColor;

let strokeW = 3;
let loopNum = 20;
let objetOffsetX = -2;
let objetOffsetY = 2;

let bgOffset = 12;
let bottomW = 560;
let bottomH = 20;
let bottomX = 32;
let bottomY = 278;

let baseX = 250;
let baseY = 15;
let baseX1 = 20;
let baseY1 = 40;
let baseX2 = 90;
let baseY2 = 80;

let marginY = 100;
let firstLY = 100;
let firstMLY = 65;

let speed = 2;
let angle = 0;



//---------
// SETUP
//---------

function setup() {
  // Screen
  createCanvas(400, 400);
  bgColor = color(0);
  drawColor = color(255, 255, 255);
}

//---------
// DRAW
//---------

function draw() {
  let s = sin(radians(angle));
  let m = map(s, -1, 1, -10, 10);
  let c = map(s, -1, 1, 0, 255);

  // Background
  background(bgColor);

  // update Postion
  objetOffsetX = m;
  objetOffsetY = -m;

  strokeWeight(strokeW);
  stroke(drawColor);

  // drawBG line
  for (let i = 0; i < width; i++) {
    line(i * bgOffset, 0, 0, i * bgOffset);
  }

  fill(bgColor);

  let marginX = baseX1 + baseX2;

  // drawbottom
  drawRect();

  // first left & third top
  drawMultiL(baseX - marginX * 2, baseY + marginY, baseX1, baseY1,
baseX2, baseY2);

  // third right & second top
  drawL(baseX - marginX, baseY - firstLY, baseX1, baseY1 + firstLY,
baseX2, baseY2 + firstLY);

  // base -> second right & second top
  drawL(baseX, baseY, baseX1, baseY1, baseX2, baseY2);

  // first right & second top
  drawL(baseX + marginX, baseY, baseX1, baseY1, baseX2, baseY2);

  // second right & first top
  drawL(baseX, baseY - marginY, baseX2, baseY1, baseX2, baseY2);

  // first right & first top
  drawL(baseX + marginX, baseY - marginY, baseX2, baseY1, baseX2, baseY2);

  angle += speed;
}

/*
  drawRect
 */
function drawRect() {
  push();
  translate(bottomX, bottomY);

  for (let i = 0; i < loopNum; i++) {
    let posX = i * objetOffsetX;
    let posY = i * objetOffsetY;

    stroke(drawColor);
    rect(posX, posY, bottomW, bottomH);

    if (i % 2 == 0) {
      stroke(bgColor);
      line(posX, posY, posX + bottomW, posY);
    }
  }
  pop();
}

/*
  draw L
 */
function drawL(posX, posY, x1, y1, x2, y2) {
  for (let i = 0; i < loopNum; i++) {
    push();
    translate(posX + i * objetOffsetX, posY + i * objetOffsetY);

    beginShape();
    stroke(drawColor);
    vertex(0, 0);
    vertex(x1, 0);
    vertex(x1, y1);
    vertex(x2, y1);
    vertex(x2, y2);
    vertex(0, y2);
    endShape(CLOSE);

    if (i % 2 == 0) {
      stroke(bgColor);
      line(0, 0, x1, 0);
      line(x1, y1, x2, y1);
    }

    pop();
  }
}

/*
  draw L
 */
function drawMultiL(posX, posY, x1, y1, x2, y2) {
  for (let i = 0; i < loopNum; i++) {
    push();
    translate(posX + i * objetOffsetX, posY + i * objetOffsetY);

    beginShape();
    stroke(drawColor);

    for (let j = 0; j < 4; j++) {
      if (j==0) {
        vertex(0, -firstMLY);
        vertex(x1, -firstMLY);
      }
      else {
        vertex(x2 * j + x1 * j, 0);
        vertex(x2 * j + x1 * (j + 1), 0);
      }
      vertex(x2 * j + x1 * (j + 1), y1);
      vertex(x2 * (j + 1) + x1 * (j + 1), y1);
    }

    vertex(x2 * 4 + x1 * 4, y2);
    vertex(0, y2);

    endShape(CLOSE);

    if (i % 2 == 0) {
      stroke(bgColor);

      for (let j = 0; j < 4; j++) {
        if (j==0) {
          line(0, -firstMLY, x1, -firstMLY);
        }
        else {
          line(x2 * j + x1 * j, 0, x2 * j + x1  * (j + 1), 0);
        }
        line(x2 * j + x1 * (j + 1), y1, x2 * (j + 1) + x1 * (j + 1), y1);
      }
    }

    pop();
  }
}
</script>
