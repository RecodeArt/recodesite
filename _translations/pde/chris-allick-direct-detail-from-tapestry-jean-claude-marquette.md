---
title: "Jean Claude Marquette"
translator: "Chris Allick"
translator_url: "http://chrisallick.com/"
slug: "chris-allick-direct-detail-from-tapestry-jean-claude-marquette"
artwork_slug: "v1n2-detail-from-tapestry"
category: "direct"
description: "Click in canvas to redraw."
runs_in_browser: true
---
/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Detail from Tapestry" by Jean Claude Marquette
Originally published in "Computer Graphics and Art" vol1 no2, 1976
Copyright (c) 2012 Chris Allick - OSI/MIT license (http://recodeproject/license).
*/

PGraphics pg;

void setup() {
  size( 416, 500, P2D );
  fill( 0 );
  noStroke();
  pg = createGraphics( 416, 500);
  
  rotate(-0.01);
  drawSquares();
}

void draw() {
}

void drawSquares() {
  background( 240 );
  pg.beginDraw();
    pg.background( 240 );
    for( int r = 2; r < 15; r++ ) {
      for( int c = 0; c < 28; c++ ) {
        int rand = (int)round(random(0,1));
        pg.noStroke();
        if( rand == 1 ) {
          pg.fill( 63 );
        } else {
          pg.noFill();
        }
        pg.rect( r*26, c*26, 26, 26 );
      }
    }
  pg.endDraw();

  image(pg, 0, 0);
}

void mousePressed() {
  rotate(-0.01);
  drawSquares();
}
