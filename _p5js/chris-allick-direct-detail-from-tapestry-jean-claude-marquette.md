---
title: "Jean Claude Marquette"
translator: "Chris Allick"
translator_url: "http://chrisallick.com/"
slug: "chris-allick-direct-detail-from-tapestry-jean-claude-marquette"
artwork_slug: "v1n2-detail-from-tapestry"
category: "direct"
description: "Click in canvas to redraw."
runs_in_browser: true
p5_version: 1.11.10
---

<script type="text/javascript">
/*
Part of the ReCode Project (http://recodeproject.com)
Based on "Detail from Tapestry" by Jean Claude Marquette
Originally published in "Computer Graphics and Art" vol1 no2, 1976
Copyright (c) 2012 Chris Allick - OSI/MIT license (http://recodeproject/license).
*/

let pg;

function setup() {
  createCanvas( 416, 500);
  fill( 0 );
  noStroke();
  pg = createGraphics( 416, 500);

  rotate(-0.01);
  drawSquares();
}

function draw() {
}

function drawSquares() {
  background( 240 );
  pg.background( 240 );
    for( let r = 2; r < 15; r++ ) {
      for( let c = 0; c < 28; c++ ) {
        let rand = int(round(random(0,1)));
        pg.noStroke();
        if( rand == 1 ) {
          pg.fill( 63 );
        } else {
          pg.noFill();
        }
        pg.rect( r*26, c*26, 26, 26 );
      }
    }

  image(pg, 0, 0);
}

function mousePressed() {
  rotate(-0.01);
  drawSquares();
}
</script>
