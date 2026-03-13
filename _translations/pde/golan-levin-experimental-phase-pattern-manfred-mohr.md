---
title: "P145 - Phase Pattern"
translator: "Golan Levin"
translator_url: "http://flong.com/"
slug: "golan-levin-experimental-phase-pattern-manfred-mohr"
artwork_slug: "v1n4-phase-pattern"
category: "experimental"
description: "Based on \"P145 - Phase Pattern\" by Manfred Mohr: a series of 2 plotter drawings, ink on paper, 50cm x 50cm each, (c) 1973 by Manfred Mohr. First published in Catalog Manfred Mohr, \"Drawings Dessins Zeichnungen Dibujos\", Galerie Weiller, Paris and Galerie Gilles Gheerbrant, Montreal, 1974. Re-published in \"Computer Graphics and Art\" Vol.1 No.4, 1976 The algorithm as described by Manfred Mohr at: http://www.emohr.com/sc69-73/vfile_145.html: \"Two horizontally oriented curves are created from randomly chosen points fit with a 3rd degree spline function. One curve is oriented the same in both drawings having the space below it filled with parallel vertical lines and the space above with parallel horizontal lines. The second curve has only parallel vertical lines in the space above it in the first drawing and is flipped in the second drawing so that the parallel vertical lines are on the bottom.\" ProcessingJS port copyright (c) 2012 Golan Levin - OSI/MIT license. Implemented in ProcessingJS using Processing 2.0b7 on 29 December 2012. Remarks by Golan Levin about this Processing port for the ReCode project: \"Mohr does not specify which '3rd degree spline' he used for his curves, nor how they were randomized. For the sake of brevity and clarity, I have selected Processing's \"noise()\" function for this purpose, as it implements Perlin's noise function with 3rd-order continuities. Technically, however, this choice should be regarded as an anachronism, as Perlin's noise was not published until ~1984. This is a bit like seeing a new font employed in a period-piece movie about the past: a telltale giveaway that it's a re-creation. I did implement a version of P145 with a piecewise continuous Bezier curve instead of the noise() function. In fact: it did look much better, and had a more authentic character than Perlin's curve. However, the vertical lookup proved surprisingly complex (requiring iterative Newton-Raphelson estimation), and attempting to replicate the specific quality of randomness by which Mohr positioned his control points became a genuine rabbit-hole. Creating the port proved to be an enjoyable exercise, and I have a newfound understanding of the complexities of Mohr's deceptively simple design. One fault of the port is that it is particularly susceptible to visual corruption due to aliased rendering of lines located at fractional coordinates. The different Processing renderers sometimes do the piece justice, sometimes not. Additionally, there is a bug in the ProcessingJS handling of noiseSeed() which required a small overcomplicating workaround.  Click in the sketch frame to change output."
runs_in_browser: true
---
/*
Part of the ReCode Project (http://recodeproject.com)
A series of 2 plotter drawings, ink on paper, 50cm x 50cm each, (c) 1973 by Manfred Mohr
First published in Catalog Manfred Mohr, "Drawings Dessins Zeichnungen Dibujos",
Galerie Weiller, Paris and Galerie Gilles Gheerbrant, Montreal, 1974
Re-published in "Computer Graphics and Art" Vol.1 No.4, 1976
https://github.com/downloads/matthewepler/ReCode_Project/COMPUTER_GRAPHICS_AND_ART_Nov1976.pdf
Copyright (c) 2012 Golan Levin - OSI/MIT license (http://recodeproject/license).
*/


int   nLinesAcross   = 133;     // 133 Number of lines across, counted per original
float marginPercent = 0.02857;  // Thickness of margin, measured per original
float strokePercent  = 0.25;    // StrokeWeight as a % of line step, estimated per original 
int   seriesMode      = 0;      // 0 or 1, depending which of the series we are rendering

float margin; 
float xLeft, xRight;
float yTop, yBottom; 

int seed1; 
int seed2;
int clickTime = 0;

FPoint storedCurve[];
class FPoint {
  float x; 
  float y;
}


//==========================================================
void setup() {
  size (560, 560, P2D);

  reseed();
  storedCurve = new FPoint[nLinesAcross];
  for (int i=0; i<nLinesAcross; i++) {
    storedCurve[i] = new FPoint();
  }


  marginPercent = 0.02857;
  margin  = marginPercent * width; 
  xLeft   = margin;
  xRight  = width - margin;
  yTop    = margin;
  yBottom = height - margin;
}


void keyPressed() {
  seriesMode = 1 - seriesMode;
}

void mousePressed() {
  reseed();
}
void reseed() {
  seed1 = (int) random(10000);
  seed2 = (int) random(10000);
  clickTime = millis();
}


//==========================================================
void draw() {
  background (25); 
  stroke (240); 
  strokeCap (ROUND);
  noFill(); 
  smooth(); 

  float stepSize = (xRight-xLeft) / (float)nLinesAcross;
  float lineThickness = strokePercent * stepSize;
  strokeWeight (lineThickness); 

  noiseDetail(2, 0.8); 
  float noiseScale1 = 0.0050;
  float noiseScale2 = 0.0047;
  float minYPercent = 0.30; // determined by inspection of the original
  float maxYPercent = 1.0 - minYPercent;
  float minY = yTop + minYPercent*(yBottom - yTop); 
  float maxY = yTop + maxYPercent*(yBottom - yTop);

  // Compute and store first curve
  noiseSeed (seed1); 
  for (int i=0; i<nLinesAcross; i++) {
    float x = map(i, 0, (nLinesAcross-1), xLeft, xRight); 
    float n = noise (x * noiseScale1 +clickTime); 
    float y = map(n, 0, 1, minY, maxY);
    storedCurve[i].x = x; 
    storedCurve[i].y = y;
  }

  // Draw first set of vertical lines, down from the first curve
  for (int i=0; i<nLinesAcross; i++) {
    float x = storedCurve[i].x;
    float y = storedCurve[i].y;
    line (x, y, x, yBottom);
  }

  // Draw the outline of the first curve, itself
  beginShape(); 
  for (int i=0; i<nLinesAcross; i++) {
    vertex (storedCurve[i].x, storedCurve[i].y);
  }
  endShape(); 


  // Search for top and bottom of storedCurve
  float curveTop = yBottom; 
  float curveBottom = 0; 
  for (int i=0; i<nLinesAcross; i++) {
    float y = storedCurve[i].y;
    if (y < curveTop) {
      curveTop = y;
    }
    if (y >  curveBottom) {
      curveBottom = y;
    }
  }

  // Draw horizontal lines
  for (int i=0; i<nLinesAcross; i++) {
    float y = map(i, 0, (nLinesAcross-1), yTop, yBottom); 
    if (y <= curveTop) {
      line (xLeft+lineThickness, y, xRight, y);
    } 
    else if ( y > curveBottom) {
      ; // draw no line
    } 
    else {

      float px0 = xLeft + lineThickness;
      int UNDEFINED_EDGE = -1;
      int RISING_EDGE = 0;
      int FALLING_EDGE = 1;
      int mostRecentIntersection = UNDEFINED_EDGE;

      for (int j=0; j<(nLinesAcross-1); j++) {
        float xj = storedCurve[j].x;
        float yj = storedCurve[j].y;
        float xk = storedCurve[j+1].x;
        float yk = storedCurve[j+1].y;
        boolean bIntersectionOnRisingEdge  = ((y <= yj) && (y >= yk));
        boolean bIntersectionOnFallingEdge = ((y >= yj) && (y <= yk));
        boolean bOnLastLine = (j == (nLinesAcross-2));

        if (bIntersectionOnRisingEdge) {
          float px1 = xj + (yj - y)/(yj - yk)*(xk-xj);  
          line (px0, y, px1, y);
          mostRecentIntersection = RISING_EDGE;
          px0 = px1;
        } 
        else if (bIntersectionOnFallingEdge) {
          px0 = xj + (y - yj)/(yk - yj)*(xk-xj); 
          mostRecentIntersection = FALLING_EDGE;
        } 
        else if (bOnLastLine && (mostRecentIntersection == FALLING_EDGE)) {
          line (px0, y, xk, y);
        }
      }
    }
  }

  // Draw the second set of vertical lines.
  // Note: noiseSeed() does not seem to be working in ProcessingJS. 
  // The +seed2+clicktime below is a workaround to overcome this bug. 
  noiseSeed (seed2);
  for (int i=0; i<nLinesAcross; i++) {
    float x = map(i, 0, (nLinesAcross-1), xLeft, xRight); 
    float n = noise (x*noiseScale2 +seed2+clickTime); // see above note. 
    float y = map(n, 0, 1, minY, maxY);
    if (seriesMode == 0) {
      line (x+lineThickness+1, yTop, x+lineThickness, y);
    } 
    else {
      line (x+lineThickness+1, y, x+lineThickness, yBottom);
    }
  }
}
