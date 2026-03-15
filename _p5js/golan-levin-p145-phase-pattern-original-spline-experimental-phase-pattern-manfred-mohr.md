---
title: "P145 - Phase Pattern (Original Spline)"
translator: "Golan Levin"
translator_url: "http://flong.com/"
slug: "golan-levin-p145-phase-pattern-original-spline-experimental-phase-pattern-manfred-mohr"
artwork_slug: "v1n4-phase-pattern"
category: "experimental"
description: 'This is the second of my ports of Manfred Mohr''s two plotter drawings, "P145 - Phase Pattern" (1973). These were first published in Catalog Manfred Mohr, "Drawings Dessins Zeichnungen Dibujos", Galerie Weiller, Paris and Galerie Gilles Gheerbrant, Montreal, 1974, and Re-published in "Computer Graphics and Art" Vol.1 No.4, 1976. The originals, whose algorithm was described by Mohr at http://www.emohr.com/sc69-73/vfile_145.html, are ink on paper, 50cm x 50cm. This ProcessingJS port uses Bezier curves to duplicate, to the best of my abilities, the exact 3rd-degree splines used in Mohr''s originals. The randomization technique by which Mohr generated these curves is unknown, and in the absence of other information about his method I have not attempted to invent one.'
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

This version reproduces the exact 3rd-order spline curves used in Mohr's original.
See: http://www.emohr.com/sc69-73/vfile_145.html
*/


let nLinesAcross  = 133;        // Number of lines across, counted per original
let marginPercent = 0.02857;    // Thickness of margin, measured per original
let strokePercent = 0.25;       // StrokeWeight as a % of line step, estimated per original
let seriesMode    = 0;          // 0 or 1, depending which of the series we're rendering

let margin;
let xLeft, xRight;
let yTop, yBottom;

let curveA;
let curveB;

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

  storedCurve = [];
  for (let i = 0; i < nLinesAcross; i++) {
    storedCurve[i] = new FPoint();
  }

  margin  = marginPercent * width;
  xLeft   = margin;
  xRight  = width - margin;
  yTop    = margin;
  yBottom = height - margin;

  initializeSplineSegmentCollections();

  // Compute and store first curve
  for (let i = 0; i < nLinesAcross; i++) {
    let x = map(i, 0, (nLinesAcross - 1), 0, 1);
    let y = curveA.cubicBezierLookup(x);
    x = map(x, 0, 1, xLeft, xRight);
    y = map(y, 0, 1, yTop, yBottom);
    storedCurve[i].x = x;
    storedCurve[i].y = y;
  }
}


//==========================================================
function initializeSplineSegmentCollections() {

  // These are cubic Bezier control points in the format {x,y,x,y,x,y,x,y}
  // which duplicate, to the best of my abilities, the cubic splines used in
  // the original by Manfred Mohr: http://www.emohr.com/sc69-73/vfile_145.html.
  // Mohr's original randomization technique for producing these is otherwise unknown.
  // The numbers have been normalized in the range 0...1.

  let ctrlPtsA0 = [-0.09318, 0.65749, 0.00986, 0.65749, 0.02457, 0.46173, 0.08051, 0.46173];
  let ctrlPtsA1 = [0.08051, 0.46173, 0.10847, 0.46173, 0.14233, 0.60598, 0.17324, 0.60598];
  let ctrlPtsA2 = [0.17324, 0.60598, 0.22328, 0.60598, 0.32043, 0.39402, 0.43818, 0.39402];
  let ctrlPtsA3 = [0.43818, 0.39402, 0.47792, 0.39402, 0.53533, 0.41169, 0.57948, 0.41169];
  let ctrlPtsA4 = [0.57948, 0.41169, 0.64719, 0.41169, 0.73992, 0.39255, 0.81646, 0.39255];
  let ctrlPtsA5 = [0.81646, 0.39255, 0.95629, 0.39255, 1.10201, 0.57654, 1.13733, 0.57654];

  let ctrlPtsB0 = [-0.15500, 0.34987, -0.10790, 0.34987, 0.00544, 0.52355, 0.13202, 0.52355];
  let ctrlPtsB1 = [0.13202, 0.52355, 0.24094, 0.52355, 0.27333, 0.38666, 0.31012, 0.38666];
  let ctrlPtsB2 = [0.31012, 0.38666, 0.34251, 0.38666, 0.41905, 0.57507, 0.47056, 0.57507];
  let ctrlPtsB3 = [0.47056, 0.57507, 0.50000, 0.57507, 0.50883, 0.52797, 0.53238, 0.52797];
  let ctrlPtsB4 = [0.53238, 0.52797, 0.55004, 0.52797, 0.56624, 0.53680, 0.58684, 0.53680];
  let ctrlPtsB5 = [0.58684, 0.53680, 0.66191, 0.53680, 0.71048, 0.45731, 0.81204, 0.45731];
  let ctrlPtsB6 = [0.81204, 0.45731, 0.94893, 0.45731, 1.04166, 0.55299, 1.10495, 0.55299];

  // Init the first curve, using those control points.
  let ctrlPtsA = [];
  ctrlPtsA[0] = ctrlPtsA0;
  ctrlPtsA[1] = ctrlPtsA1;
  ctrlPtsA[2] = ctrlPtsA2;
  ctrlPtsA[3] = ctrlPtsA3;
  ctrlPtsA[4] = ctrlPtsA4;
  ctrlPtsA[5] = ctrlPtsA5;
  curveA = new SplineSegmentCollection(6, ctrlPtsA);

  // Init the second curve, using those control points.
  let ctrlPtsB = [];
  ctrlPtsB[0] = ctrlPtsB0;
  ctrlPtsB[1] = ctrlPtsB1;
  ctrlPtsB[2] = ctrlPtsB2;
  ctrlPtsB[3] = ctrlPtsB3;
  ctrlPtsB[4] = ctrlPtsB4;
  ctrlPtsB[5] = ctrlPtsB5;
  ctrlPtsB[6] = ctrlPtsB6;
  curveB = new SplineSegmentCollection(7, ctrlPtsB);
}

//==========================================================
function keyPressed() {
  seriesMode = 1 - seriesMode;
}

//==========================================================
function mousePressed() {
  seriesMode = 1 - seriesMode;
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
  for (let i = 0; i < nLinesAcross; i++) {
    let x = map(i, 0, (nLinesAcross - 1), 0, 1);
    let y = curveB.cubicBezierLookup(x);
    x = map(x, 0, 1, xLeft, xRight);
    y = map(y, 0, 1, yTop, yBottom);

    if (seriesMode == 0) {
      line(x + lineThickness + 1, yTop, x + lineThickness, y);
    }
    else {
      line(x + lineThickness + 1, y, x + lineThickness, yBottom);
    }
  }
}



//==========================================================
class SplineSegmentCollection {
  constructor(nSegs, controlPoints) {
    this.nSplineSegments = nSegs;
    this.segments = [];
    for (let i = 0; i < this.nSplineSegments; i++) {
      this.segments[i] = new SplineSegment();

      this.segments[i].x0 = controlPoints[i][0];
      this.segments[i].y0 = controlPoints[i][1];
      this.segments[i].x1 = controlPoints[i][2];
      this.segments[i].y1 = controlPoints[i][3];
      this.segments[i].x2 = controlPoints[i][4];
      this.segments[i].y2 = controlPoints[i][5];
      this.segments[i].x3 = controlPoints[i][6];
      this.segments[i].y3 = controlPoints[i][7];
    }
  }

  //---------------------------------------
  cubicBezierLookup(x) {
    let y = 0;
    let whichSegment = this.inWhichSegmentIsXValueContained(x);
    if (whichSegment != -1) {
      y = this.segments[whichSegment].cubicBezierLookup(x);
    }
    return y;
  }

  //---------------------------------------
  inWhichSegmentIsXValueContained(x) {
    let whichSegment = -1;
    for (let s = 0; s < this.nSplineSegments; s++) {
      if ((x >= this.segments[s].x0) && (x <= this.segments[s].x3)) {
        whichSegment = s;
      }
    }
    return whichSegment;
  }

}


//==========================================================
class SplineSegment {
  constructor() {
    this.x0 = 0;  // initial x
    this.y0 = 0;  // initial y
    this.x1 = 0;  // 1st influence x
    this.y1 = 0;  // 1st influence y
    this.x2 = 0;  // 2nd influence x
    this.y2 = 0;  // 2nd influence y
    this.x3 = 0;  // final x
    this.y3 = 0;  // final y
  }

  //---------------------------------------
  cubicBezierLookup(queryx) {

    // Assume control points of (0,0), (a,b), (c,d), and (1,1);
    // Given horizontal query point x between 0...1
    // Return function value y (also in the range 0...1).

    // Adapted from BEZMATH.PS (1993) by Don Lancaster, Synergetics Inc.
    // http://www.tinaja.com/text/bezmath.html

    let A =   this.x3 - 3 * this.x2 + 3 * this.x1 - this.x0;
    let B = 3 * this.x2 - 6 * this.x1 + 3 * this.x0;
    let C = 3 * this.x1 - 3 * this.x0;
    let D =   this.x0;

    let E =   this.y3 - 3 * this.y2 + 3 * this.y1 - this.y0;
    let F = 3 * this.y2 - 6 * this.y1 + 3 * this.y0;
    let G = 3 * this.y1 - 3 * this.y0;
    let H =   this.y0;

    // Solve for t given x (using Newton-Raphelson), then solve for y given t.
    // Assume for the first guess that t = 0.5. (Could also use queryx if in 0...1)
    let currentt = 0.5;
    let nRefinementIterations = 5;
    for (let i = 0; i < nRefinementIterations; i++) {
      let currentx = this.xFromT(currentt, A, B, C, D);
      let currentslope = this.slopeFromT(currentt, A, B, C);
      currentt -= (currentx - queryx) * (currentslope);
      currentt = constrain(currentt, 0, 1);
    }

    let y = this.yFromT(currentt, E, F, G, H);
    return y;
  }

  //----------------------------------------------------------
  slopeFromT(t, A, B, C) {
    let dtdx = 1.0 / (3.0 * A * t * t + 2.0 * B * t + C);
    return dtdx;
  }
  //----------------------------------------------------------
  xFromT(t, A, B, C, D) {
    let x = A * (t * t * t) + B * (t * t) + C * t + D;
    return x;
  }
  //----------------------------------------------------------
  yFromT(t, E, F, G, H) {
    let y = E * (t * t * t) + F * (t * t) + G * t + H;
    return y;
  }
}
</script>
