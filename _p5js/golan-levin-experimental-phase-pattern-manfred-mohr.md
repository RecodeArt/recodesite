---
title: "P145 - Phase Pattern"
translator: "Golan Levin"
translator_url: "http://flong.com/"
slug: "golan-levin-experimental-phase-pattern-manfred-mohr"
artwork_slug: "v1n4-phase-pattern"
category: "experimental"
description: 'Based on "P145 - Phase Pattern" by Manfred Mohr: a series of 2 plotter drawings, ink on paper, 50cm x 50cm each, (c) 1973 by Manfred Mohr. First published in Catalog Manfred Mohr, "Drawings Dessins Zeichnungen Dibujos", Galerie Weiller, Paris and Galerie Gilles Gheerbrant, Montreal, 1974. Re-published in "Computer Graphics and Art" Vol.1 No.4, 1976 The algorithm as described by Manfred Mohr at: http://www.emohr.com/sc69-73/vfile_145.html: "Two horizontally oriented curves are created from randomly chosen points fit with a 3rd degree spline function. One curve is oriented the same in both drawings having the space below it filled with parallel vertical lines and the space above with parallel horizontal lines. The second curve has only parallel vertical lines in the space above it in the first drawing and is flipped in the second drawing so that the parallel vertical lines are on the bottom." ProcessingJS port copyright (c) 2012 Golan Levin - OSI/MIT license. Implemented in ProcessingJS using Processing 2.0b7 on 29 December 2012. Remarks by Golan Levin about this Processing port for the ReCode project: "Mohr does not specify which ''3rd degree spline'' he used for his curves, nor how they were randomized. For the sake of brevity and clarity, I have selected Processing''s "noise()" function for this purpose, as it implements Perlin''s noise function with 3rd-order continuities. Technically, however, this choice should be regarded as an anachronism, as Perlin''s noise was not published until ~1984. This is a bit like seeing a new font employed in a period-piece movie about the past: a telltale giveaway that it''s a re-creation. I did implement a version of P145 with a piecewise continuous Bezier curve instead of the noise() function. In fact: it did look much better, and had a more authentic character than Perlin''s curve. However, the vertical lookup proved surprisingly complex (requiring iterative Newton-Raphelson estimation), and attempting to repli... (line truncated to 2000 chars)'
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
A series of 2 plotter drawings, ink on paper, 50cm x 50cm each, (c) 1973 by Manfred Mohr
First published in Catalog Manfred Mohr, "Drawings Dessins Zeichnungen Dibujos",
Galerie Weiller, Paris and Galerie Gilles Gheerbrant, Montreal, 1974
Re-published in "Computer Graphics and Art" Vol.1 No.4, 1976
https://github.com/downloads/matthewepler/ReCode_Project/COMPUTER_GRAPHICS_AND_ART_Nov1976.pdf
Copyright (c) 2012 Golan Levin - OSI/MIT license (http://recodeproject/license).
*/


let nLinesAcross   = 133;     // 133 Number of lines across, counted per original
let marginPercent = 0.02857;  // Thickness of margin, measured per original
let strokePercent  = 0.25;    // StrokeWeight as a % of line step, estimated per original
let seriesMode      = 0;      // 0 or 1, depending which of the series we are rendering

let margin;
let xLeft, xRight;
let yTop, yBottom;

let seed1;
let seed2;
let clickTime = 0;

let storedCurve;

class FPoint {
  constructor() {
    this.x = 0;
    this.y = 0;
  }
}


//==========================================================
function setup() {
  createCanvas(560, 560);

  reseed();
  storedCurve = [];
  for (let i = 0; i < nLinesAcross; i++) {
    storedCurve[i] = new FPoint();
  }


  marginPercent = 0.02857;
  margin  = marginPercent * width;
  xLeft   = margin;
  xRight  = width - margin;
  yTop    = margin;
  yBottom = height - margin;
}


function keyPressed() {
  seriesMode = 1 - seriesMode;
}

function mousePressed() {
  reseed();
}
function reseed() {
  seed1 = int(random(10000));
  seed2 = int(random(10000));
  clickTime = millis();
}


//==========================================================
function draw() {
  background(25);
  stroke(240);
  strokeCap(ROUND);
  noFill();

  let stepSize = (xRight - xLeft) / nLinesAcross;
  let lineThickness = strokePercent * stepSize;
  strokeWeight(lineThickness);

  noiseDetail(2, 0.8);
  let noiseScale1 = 0.0050;
  let noiseScale2 = 0.0047;
  let minYPercent = 0.30; // determined by inspection of the original
  let maxYPercent = 1.0 - minYPercent;
  let minY = yTop + minYPercent * (yBottom - yTop);
  let maxY = yTop + maxYPercent * (yBottom - yTop);

  // Compute and store first curve
  noiseSeed(seed1);
  for (let i = 0; i < nLinesAcross; i++) {
    let x = map(i, 0, (nLinesAcross - 1), xLeft, xRight);
    let n = noise(x * noiseScale1 + clickTime);
    let y = map(n, 0, 1, minY, maxY);
    storedCurve[i].x = x;
    storedCurve[i].y = y;
  }

  // Draw first set of vertical lines, down from the first curve
  for (let i = 0; i < nLinesAcross; i++) {
    let x = storedCurve[i].x;
    let y = storedCurve[i].y;
    line(x, y, x, yBottom);
  }

  // Draw the outline of the first curve, itself
  beginShape();
  for (let i = 0; i < nLinesAcross; i++) {
    vertex(storedCurve[i].x, storedCurve[i].y);
  }
  endShape();


  // Search for top and bottom of storedCurve
  let curveTop = yBottom;
  let curveBottom = 0;
  for (let i = 0; i < nLinesAcross; i++) {
    let y = storedCurve[i].y;
    if (y < curveTop) {
      curveTop = y;
    }
    if (y >  curveBottom) {
      curveBottom = y;
    }
  }

  // Draw horizontal lines
  for (let i = 0; i < nLinesAcross; i++) {
    let y = map(i, 0, (nLinesAcross - 1), yTop, yBottom);
    if (y <= curveTop) {
      line(xLeft + lineThickness, y, xRight, y);
    }
    else if ( y > curveBottom) {
      ; // draw no line
    }
    else {

      let px0 = xLeft + lineThickness;
      let UNDEFINED_EDGE = -1;
      let RISING_EDGE = 0;
      let FALLING_EDGE = 1;
      let mostRecentIntersection = UNDEFINED_EDGE;

      for (let j = 0; j < (nLinesAcross - 1); j++) {
        let xj = storedCurve[j].x;
        let yj = storedCurve[j].y;
        let xk = storedCurve[j+1].x;
        let yk = storedCurve[j+1].y;
        let bIntersectionOnRisingEdge  = ((y <= yj) && (y >= yk));
        let bIntersectionOnFallingEdge = ((y >= yj) && (y <= yk));
        let bOnLastLine = (j == (nLinesAcross - 2));

        if (bIntersectionOnRisingEdge) {
          let px1 = xj + (yj - y) / (yj - yk) * (xk - xj);
          line(px0, y, px1, y);
          mostRecentIntersection = RISING_EDGE;
          px0 = px1;
        }
        else if (bIntersectionOnFallingEdge) {
          px0 = xj + (y - yj) / (yk - yj) * (xk - xj);
          mostRecentIntersection = FALLING_EDGE;
        }
        else if (bOnLastLine && (mostRecentIntersection == FALLING_EDGE)) {
          line(px0, y, xk, y);
        }
      }
    }
  }

  // Draw the second set of vertical lines.
  // Note: noiseSeed() does not seem to be working in ProcessingJS.
  // The +seed2+clicktime below is a workaround to overcome this bug.
  noiseSeed(seed2);
  for (let i = 0; i < nLinesAcross; i++) {
    let x = map(i, 0, (nLinesAcross - 1), xLeft, xRight);
    let n = noise(x * noiseScale2 + seed2 + clickTime); // see above note.
    let y = map(n, 0, 1, minY, maxY);
    if (seriesMode == 0) {
      line(x + lineThickness + 1, yTop, x + lineThickness, y);
    }
    else {
      line(x + lineThickness + 1, y, x + lineThickness, yBottom);
    }
  }
}
</script>
